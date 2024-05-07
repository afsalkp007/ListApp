//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Afsal on 18/03/2024.
//

import Foundation

public final class LocalFeedLoader {
  private let store: FeedStore
  
  public init(store: FeedStore) {
    self.store = store
  }
}

extension LocalFeedLoader: FeedCache {
  public typealias SaveResult = FeedCache.Result
  
  public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
    store.deleteCachedFeed { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success:
        self.cache(feed, completion: completion)
        
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  private func cache(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
    store.insert(feed.toLocal(), completion: { [weak self] result in
      guard self != nil else { return }
      
      switch result {
      case .success:
        break
        
      case let .failure(error):
        completion(.failure(error))
      }
    })
  }
}

extension LocalFeedLoader: FeedLoader {
  public enum Error: Swift.Error {
    case emptyData
  }
 
  public typealias LoadResult = FeedLoader.Result
  
  public func load(completion: @escaping (LoadResult) -> Void) {
    store.retrieve { [weak self] result in
      guard self != nil else { return }
      
      switch result {
      case let .failure(error):
        completion(.failure(error))
        
      case let .success(.some(cache)):
        completion(.success(cache.feed.toModels()))
        
      case .success:
        completion(.failure(Error.emptyData))
      }
    }
  }
}

private extension Array where Element == FeedImage {
  func toLocal() -> [LocalFeedImage] {
    return map { LocalFeedImage(name: $0.name, country: $0.country, code: $0.code, state: $0.state, webpage: $0.webpage) }
  }
}

private extension Array where Element == LocalFeedImage {
  func toModels() -> [FeedImage] {
    return map { FeedImage( name: $0.name, country: $0.country, code: $0.code, state: $0.state, webpage: $0.webpage) }
  }
}
