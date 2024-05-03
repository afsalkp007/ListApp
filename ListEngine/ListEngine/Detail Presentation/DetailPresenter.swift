//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Afsal on 22/04/2024.
//

import Foundation

public struct DetailViewModel {
  public let name: String
  public let country: String
  public let code: String
  public let state: String?
  public let webpage: String?
}

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
