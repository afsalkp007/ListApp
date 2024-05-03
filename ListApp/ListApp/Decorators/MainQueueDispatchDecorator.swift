//
//  MainQueueDispatchDecorator.swift
//  EssentialFeediOS
//
//  Created by Afsal on 18/04/2024.
//

import Foundation
import ListEngine
import LIstiOS

final class MainQueueDispatchDecorator<T> {
  private let decoratee: T
  
  init(decoratee: T) {
    self.decoratee = decoratee
  }
  
  func dispatch(completion: @escaping EmptyClosure) {
    guard Thread.isMainThread else {
      return DispatchQueue.main.async(execute: completion)
    }
    
    completion()
  }
}

extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
  func load(completion: @escaping (FeedLoader.Result) -> Void) {
    decoratee.load { [weak self] result in
      self?.dispatch { completion(result) }
    }
  }
}
