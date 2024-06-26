//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Afsal on 28/04/2024.
//

import Foundation
import ListEngine

public class FeedLoaderCacheDecorator: FeedLoader {
  private let decoratee: FeedLoader
  private let cache: FeedCache
  
  public init(decoratee: FeedLoader, cache: FeedCache) {
    self.decoratee = decoratee
    self.cache = cache
  }
  
  public func load(completion: @escaping (FeedLoader.Result) -> Void) {
    decoratee.load { [weak self] result in
      completion(result.map { feed in
        self?.cache.saveIgnoringResult(feed)
        return feed
      })
    }
  }
}

private extension FeedCache {
  func saveIgnoringResult(_ feed: [FeedImage]) {
    save(feed) { _ in }
  }
}
