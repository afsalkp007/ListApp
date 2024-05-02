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
  private let selection: (FeedImage) -> Void
  
  init(controller: FeedViewController, selection: @escaping (FeedImage) -> Void) {
    self.controller = controller
    self.selection = selection
  }
  
  public func display(_ viewModel: FeedViewModel) {
    controller?.display(viewModel.feed.map { [weak self] model in
      let adapter = FeedImageDataLoaderPresentationAdapter(model: model)
      let view = FeedImageCellController(delegate: adapter, selection: {
        self?.selection(model)
      })
      
      adapter.presenter = FeedImagePresenter(view: WeakRefVirtualProxy(view))

      return view
    })
  }
}
