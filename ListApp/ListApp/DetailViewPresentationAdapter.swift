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
  private let callback: EmptyClosure
  
  init(feed: FeedImage, callback: @escaping EmptyClosure) {
    self.feed = feed
    self.callback = callback
  }
  
  func loadFeed() {
    presenter?.didFinishLoadingDetail(with: feed)
  }
  
  func goBack() {
    callback()
  }
}
