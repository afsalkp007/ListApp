//
//  RemoteFeedLoader.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

public enum HTTPClientResult {
  case success(HTTPURLResponse)
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

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load(completion: @escaping (Error) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success:
        completion(.invalidData)
      case .failure:
        completion(.connectivity)
      }
    }
  }
}

