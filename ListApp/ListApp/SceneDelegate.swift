//
//  SceneDelegate.swift
//  ListApp
//
//  Created by Afsal on 02/05/2024.
//

import UIKit
import CoreData
import ListEngine
import LIstiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  private lazy var httpClient: HTTPClient = {
    URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
  }()

  private lazy var store: FeedStore = {
    try! CoreDataFeedStore(
      storeURL: NSPersistentContainer
      .defaultDirectoryURL()
      .appendingPathComponent("feed-store.sqlite"))
  }()
  
  private lazy var localFeedLoader: LocalFeedLoader = {
    LocalFeedLoader(store: store)
  }()
  
  private lazy var navigationController = UINavigationController(rootViewController: FeedUIComposer.feedComposedWith(
    feedLoader: FeedLoaderWithFallbackComposite(
      primary: FeedLoaderCacheDecorator(
        decoratee: makeRemoteFeedLoader(),
        cache: localFeedLoader),
      fallback: localFeedLoader),
    selection: { [weak self] model in
      self?.showDetailView(for: model)
    }))

  convenience init(httpClient: HTTPClient, store: FeedStore) {
    self.init()
    self.httpClient = httpClient
    self.store = store
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    
    configureWindow()
  }
   
  func configureWindow() {
    window?.rootViewController = navigationController
  }
  
  private func makeRemoteFeedLoader() -> RemoteFeedLoader {
    let remoteURL = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
    return RemoteFeedLoader(url: remoteURL, client: httpClient)
  }
  
  private func showDetailView(for image: FeedImage) {
    let detail = DetailUIComposer.makeDetail()
    navigationController.pushViewController(detail, animated: true)
  }
}

