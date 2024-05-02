//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by Afsal on 22/04/2024.
//

import Foundation

public protocol FeedImageView {
  func display(_ viewModel: FeedImageViewModel)
}

public final class FeedImagePresenter {
  private let view: FeedImageView
  
  public init(view: FeedImageView) {
    self.view = view
  }
  
  public func loadData(for model: FeedImage) {
    view.display(
      FeedImageViewModel(
        name: model.name,
        country: model.country,
        code: model.code,
        state: model.state,
        webpage: model.webpage
      )
    )
  }
}
