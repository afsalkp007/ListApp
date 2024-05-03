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
  @NSManaged var state: String?
  @NSManaged var webpage: String?
}
 
extension ManagedFeedImage {
  static func images(from feed: [LocalFeedImage], in context: NSManagedObjectContext) -> NSOrderedSet {
    return NSOrderedSet(array: feed.map { local in
      let managed = ManagedFeedImage(context: context)
      managed.id = UUID()
      managed.name = local.name
      managed.country = local.country
      managed.code = local.code
      managed.state = local.state
      managed.webpage = local.webpage
      return managed
    })
  }
  
  var local: LocalFeedImage {
    return LocalFeedImage(name: name, country: country, code: code, state: state, webpage: webpage)
  }
}
