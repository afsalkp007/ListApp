//
//  DetailViewPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Afsal on 18/04/2024.
//

import ListEngine
import LIstiOS

final class DetailViewPresentationAdapter: DetailViewControllerDelegate {
  var presenter: DetailPresenter?
  
  private let feed: FeedImage
  
  init(presenter: DetailPresenter? = nil, feed: FeedImage) {
    self.presenter = presenter
    self.feed = feed
  }
  
  func loadFeed() {
    presenter?.didFinishLoadingDetail(with: feed)
  }
}
