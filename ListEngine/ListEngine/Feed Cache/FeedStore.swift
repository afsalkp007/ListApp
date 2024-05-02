//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Afsal on 18/03/2024.
//

import Foundation

public struct CachedFeed {
  let feed: [LocalFeedImage]
}

public protocol FeedStore {
  typealias DeletionResult = Result<Void, Error>
  typealias DeletionCompletion = (DeletionResult) -> Void
  
  typealias InsertionResult = Result<Void, Error>
  typealias InsertionCompletion = (InsertionResult) -> Void
  
  typealias RetrievalResult = Swift.Result<CachedFeed?, Error>
  typealias RetrievalCompletion = (RetrievalResult) -> Void
  
  /// The Completion handler can be invoked in any thread
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func deleteCachedFeed(completion: @escaping DeletionCompletion)
  
  /// The Completion handler can be invoked in any thread
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func insert(_ feed: [LocalFeedImage], completion: @escaping InsertionCompletion)
  
  /// The Completion handler can be invoked in any thread
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func retrieve(completion: @escaping RetrievalCompletion)
}
