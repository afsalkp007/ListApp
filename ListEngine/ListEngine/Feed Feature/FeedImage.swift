//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Afsal on 09/03/2024.
//

import Foundation

public struct FeedImage: Equatable {
  public let id: UUID
  public let name: String
  public let country: String
  
  public init(id: UUID, name: String, country: String) {
    self.id = id
    self.name = name
    self.country = country
  }
}
