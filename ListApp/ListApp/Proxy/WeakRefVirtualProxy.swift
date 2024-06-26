//
//  WeakRefVirtualProxy.swift
//  EssentialFeediOS
//
//  Created by Afsal on 18/04/2024.
//

import UIKit
import ListEngine

final class WeakRefVirtualProxy<T: AnyObject> {
  private weak var object: T?
  
  init(_ object: T) {
    self.object = object
  }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
  func display(_ viewModel: FeedLoadingViewModel) {
    object?.display(viewModel)
  }
}

extension WeakRefVirtualProxy: FeedErrorView where T: FeedErrorView {
  func display(_ viewModel: FeedErrorViewModel) {
    object?.display(viewModel)
  }
}

extension WeakRefVirtualProxy: FeedImageView where T: FeedImageView {
  func display(_ viewModel: FeedImageViewModel) {
    object?.display(viewModel)
  }
}

extension WeakRefVirtualProxy: DetailView where T: DetailView {
  func display(_ viewModel: DetailViewModel) {
    object?.display(viewModel)
  }
}
