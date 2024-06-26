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
    selection: showDetailView))

  convenience init(httpClient: HTTPClient, store: FeedStore) {
    self.init()
    self.httpClient = httpClient
    self.store = store
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    configureWindow(with: scene)
  }
   
  func configureWindow(with scene: UIWindowScene) {
    window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  private func makeRemoteFeedLoader() -> RemoteFeedLoader {
    let remoteURL = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
    return RemoteFeedLoader(url: remoteURL, client: httpClient)
  }
  
  private func showDetailView(for image: FeedImage) {
    let detail = DetailUIComposer.detailComposed(with: image, callback: { [weak self] in
      self?.navigationController.dismiss(animated: true, completion: {
        self?.refreshFeedView(with: self?.navigationController)
      })
    })
    navigationController.present(detail, animated: true)
  }
  
  private func refreshFeedView(with nav: UINavigationController?) {
    if let controller = nav?.topViewController as? FeedViewController {
      controller.delegate?.didRequestFeedRefresh()
    }
  }
}

