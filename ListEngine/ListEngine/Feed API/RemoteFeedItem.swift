//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Afsal on 18/03/2024.
//

import Foundation

struct RemoteFeedItem: Decodable {
  let id: UUID
  let name: String
  let country: String
}
