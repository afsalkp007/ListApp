//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Afsal on 06/04/2024.
//

import UIKit
import ListEngine
import LIstiOS

public final class FeedUIComposer {
  private init() {}
  
  public static func feedComposedWith(
    feedLoader: FeedLoader,
    selection: @escaping (FeedImage) -> Void = { _ in }
) -> FeedViewController {
    let presentationAdapter = FeedLoaderPresentationAdapter(
      feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader)
    )
    
    let feedController = makeWith(
      delegate: presentationAdapter,
      title: Localized.Feed.title
    )
    
    presentationAdapter.presenter = FeedPresenter(
      feedView: FeedViewAdapter(
        controller: feedController,
        selection: selection
      ),
      loadingView: WeakRefVirtualProxy(feedController),
      errorView: WeakRefVirtualProxy(feedController)
    )
    
    return feedController
  }
  
  private static func makeWith(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
    let bundle = Bundle(for: FeedViewController.self)
    let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
    let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
    feedController.delegate = delegate
    feedController.title = title
    return feedController
  }
}
