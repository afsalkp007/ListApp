//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Afsal on 13/03/2024.
//

import Foundation

final class FeedItemsMapper {

  private struct Item: Decodable {
    let name: String
    let country: String

    var remote: RemoteFeedItem {
      return RemoteFeedItem(name: name, country: country)
    }
  }
    
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
    guard response.isOK, let items = try? JSONDecoder().decode([Item].self, from: data) else {
      throw RemoteFeedLoader.Error.invalidData
    }
    
    return items.map(\.remote)
  }
}
