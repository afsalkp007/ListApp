//
//  RemoteFeedLoader.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

public protocol HTTPClient {
  func get(from url: URL)
}

public class RemoteFeedLoader {
  let client: HTTPClient
  let url: URL

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load() {
    client.get(from: url)
  }
}

