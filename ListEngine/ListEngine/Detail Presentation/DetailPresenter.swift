//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Afsal on 22/04/2024.
//

import Foundation

public protocol DetailView {
  func display(_ viewModel: DetailViewModel)
}

final public class DetailPresenter {
  private let view: DetailView

  public init(detailView: DetailView) {
    self.view = detailView
  }
  
  public func didFinishLoadingDetail(with feed: FeedImage) {
    view.display(
      DetailViewModel(
        name: feed.name,
        country: feed.country,
        code: feed.code,
        state: feed.state,
        webpage: feed.webpage
      )
    )
  }
}
