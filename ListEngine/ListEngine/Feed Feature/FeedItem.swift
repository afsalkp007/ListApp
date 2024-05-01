//
//  FeedItem.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

public struct FeedItem: Equatable {
  public let name: String
  public let state: String?
  public let country: String
  public let countryCode: String
  public let webpage: [String]
  
  public init(name: String, state: String?, country: String, countryCode: String, webpage: [String]) {
    self.name = name
    self.state = state
    self.country = country
    self.countryCode = countryCode
    self.webpage = webpage
  }
}
