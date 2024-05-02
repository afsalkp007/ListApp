//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Afsal on 09/03/2024.
//

import Foundation

public struct FeedImage: Equatable {
  public let name: String
  public let country: String
  
  public init(name: String, country: String) {
    self.name = name
    self.country = country
  }
}
