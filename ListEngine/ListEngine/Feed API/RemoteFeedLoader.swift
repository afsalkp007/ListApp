//
//  RemoteFeedLoader.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

public enum HTTPClientResult {
  case success(Data, HTTPURLResponse)
  case failure(Error)
}

public protocol HTTPClient {
  func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public class RemoteFeedLoader {
  let client: HTTPClient
  let url: URL
  
  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }
  
  public enum Result: Equatable {
    case success([FeedItem])
    case failure(Error)
  }

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case let .success(data, response):
        if response.statusCode == 200, let items = try? JSONDecoder().decode(Root.self, from: data) {
          completion(.success(items.map { $0.item }))
        } else {
          completion(.failure(.invalidData))
        }
      case .failure:
        completion(.failure(.connectivity))
      }
    }
  }
}

private typealias Root = [Item]

private struct Item {
  let name: String
  let state: String?
  let country: String
  let countryCode: String
  let webpage: [String]
  
  var item: FeedItem {
    return FeedItem(name: name, state: state, country: country, countryCode: countryCode, webpage: webpage)
  }
}

extension Item: Decodable {
  private enum CodingKeys: String, CodingKey {
    case name
    case state = "state-province"
    case country
    case countryCode = "alpha_two_code"
    case webpage = "web_pages"
  }
}

