//
//  FeedImageDataLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Afsal on 18/04/2024.
//

import ListEngine
import LIstiOS

final class FeedImageDataLoaderPresentationAdapter: FeedImageCellControllerDelegate {
  private let model: FeedImage
  
  var presenter: FeedImagePresenter?
  
  init(model: FeedImage) {
    self.model = model
  }
  
  func didRequestData() {
    presenter?.loadData(for: model)
  }
  
  func didCancelDataRequest() {}
}
