//
//  FeedItemsMapper.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

class FeedItemsMapper {

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

  internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
    guard response.statusCode == OK_200,
      let feed = try? JSONDecoder().decode([Item].self, from: data) else {
      return .failure(.invalidData)
    }
    
    return .success(feed.map(\.item))
  }
}
