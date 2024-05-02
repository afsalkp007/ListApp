//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Afsal on 18/03/2024.
//

import Foundation

public struct LocalFeedImage: Equatable {
  let id: UUID
  let name: String
  let country: String

  init(id: UUID, name: String, country: String) {
    self.id = id
    self.name = name
    self.country = country
  }
}
