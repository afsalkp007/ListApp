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
    let remoteURL = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
    
    let remoteFeedLoader = RemoteFeedLoader(url: remoteURL, client: httpClient)
    
    window?.rootViewController = UINavigationController(rootViewController: FeedUIComposer.feedComposedWith(
      feedLoader: FeedLoaderWithFallbackComposite(
        primary: FeedLoaderCacheDecorator(
          decoratee: remoteFeedLoader,
          cache: localFeedLoader),
        fallback: localFeedLoader)))
  }
}

