//
//  FeedLoader.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

enum LoadFeedResult {
  case success([FeedItem])
  case error(Error)
}

protocol FeedLoader {
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
