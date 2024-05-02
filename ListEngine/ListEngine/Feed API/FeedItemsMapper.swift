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
    let code: String
    let state: String?

    var remote: RemoteFeedItem {
      return RemoteFeedItem(id: UUID(), name: name, country: country, code: code, state: state)
    }
    
    private enum CodingKeys: String, CodingKey {
      case name
      case country
      case code = "alpha_two_code"
      case state = "state-province"
    }
  }
    
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
    guard response.isOK, let items = try? JSONDecoder().decode([Item].self, from: data) else {
      throw RemoteFeedLoader.Error.invalidData
    }
    
    return items.map(\.remote)
  }
}
