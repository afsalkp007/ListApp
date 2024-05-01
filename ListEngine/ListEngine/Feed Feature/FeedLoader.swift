//
//  FeedLoader.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

public enum LoadFeedResult {
  case success([FeedItem])
  case failure(Error)
}

public protocol FeedLoader {
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
