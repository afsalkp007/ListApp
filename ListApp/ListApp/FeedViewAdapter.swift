//
//  FeedViewAdapter.swift
//  EssentialFeediOS
//
//  Created by Afsal on 18/04/2024.
//

import UIKit
import ListEngine
import LIstiOS

final class FeedViewAdapter: FeedView {
  private weak var controller: FeedViewController?
  
  init(controller: FeedViewController) {
    self.controller = controller
  }
  
  public func display(_ viewModel: FeedViewModel) {
    controller?.display(viewModel.feed.map { model in
      let adapter = FeedImageDataLoaderPresentationAdapter(model: model)
      let view = FeedImageCellController(delegate: adapter)
      
      adapter.presenter = FeedImagePresenter(view: WeakRefVirtualProxy(view))

      return view
    })
  }
}
