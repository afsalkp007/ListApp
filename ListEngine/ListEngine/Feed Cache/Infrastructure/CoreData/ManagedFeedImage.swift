//
//  ManagedFeedImage.swift
//  EssentialFeed
//
//  Created by Afsal on 28/03/2024.
//

import Foundation
import CoreData

@objc(ManagedFeedImage)
class ManagedFeedImage: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var name: String
  @NSManaged var country: String
  @NSManaged var code: String
}
 
extension ManagedFeedImage {
  static func images(from feed: [LocalFeedImage], in context: NSManagedObjectContext) -> NSOrderedSet {
    return NSOrderedSet(array: feed.map { local in
      let managed = ManagedFeedImage(context: context)
      managed.id = local.id
      managed.name = local.name
      managed.country = local.country
      managed.code = local.code
      return managed
    })
  }
  
  var local: LocalFeedImage {
    return LocalFeedImage(id: id, name: name, country: country, code: code)
  }
}
