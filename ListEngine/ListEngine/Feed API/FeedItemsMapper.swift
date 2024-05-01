//
//  FeedItemsMapper.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

class FeedItemsMapper {
  private typealias Root = [Item]

  private struct Item: Decodable {
    let name: String
    let state: String?
    let country: String
    let countryCode: String
    let webpage: [String]
    
    var item: FeedItem {
      return FeedItem(name: name, state: state, country: country, countryCode: countryCode, webpage: webpage)
    }
    
    private enum CodingKeys: String, CodingKey {
      case name
      case state = "state-province"
      case country
      case countryCode = "alpha_two_code"
      case webpage = "web_pages"
    }
  }
  
  static var OK_200: Int { return 200 }

  static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
    guard response.statusCode == OK_200 else {
      throw RemoteFeedLoader.Error.invalidData
    }
    
    let items = try JSONDecoder().decode(Root.self, from: data)
    return items.map { $0.item }
  }
}
