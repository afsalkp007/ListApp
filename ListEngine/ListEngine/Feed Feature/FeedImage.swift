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
  public let code: String
  public let state: String?
  public let webpage: String?
  
  public init(id: UUID, name: String, country: String, code: String, state: String?, webpage: String?) {
    self.id = id
    self.name = name
    self.country = country
    self.code = code
    self.state = state
    self.webpage = webpage
  }
}
