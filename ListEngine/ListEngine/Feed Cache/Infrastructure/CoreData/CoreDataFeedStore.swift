//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Afsal on 27/03/2024.
//

import Foundation
import CoreData

public final class CoreDataFeedStore {
  private static let modelName = "Store"
  private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

  private let container: NSPersistentContainer
  private let context: NSManagedObjectContext
  
  enum StoreError: Error {
    case modelNotFound
    case failedToLoadPersistentContainer(Error)
  }

  public init(storeURL: URL) throws {
    guard let model = CoreDataFeedStore.model else {
      throw StoreError.modelNotFound
    }
    
    do {
      container = try NSPersistentContainer.load(name: CoreDataFeedStore.modelName, model: model,url: storeURL)
      context = container.newBackgroundContext()
    } catch {
      throw StoreError.failedToLoadPersistentContainer(error)
    }
  }
    
  func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
    let context = self.context
    context.perform { action(context) }
  }
  
  private func cleanUpReferencesToPresistentStores() {
    context.performAndWait {
      let coordinator = self.container.persistentStoreCoordinator
      try? coordinator.persistentStores.forEach(coordinator.remove)
    }
  }
  
  deinit {
    cleanUpReferencesToPresistentStores()
  }
}
