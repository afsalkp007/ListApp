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
  let code: String

  init(id: UUID, name: String, country: String, code: String) {
    self.id = id
    self.name = name
    self.country = country
    self.code = code
  }
}
