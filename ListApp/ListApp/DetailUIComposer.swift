//
//  DetailUIComposer.swift
//  ListApp
//
//  Created by Afsal on 02/05/2024.
//

import UIKit
import ListEngine
import LIstiOS

final class DetailUIComposer {
  
  static func detailComposed(with feed: FeedImage) -> DetailViewController {
    let adapter = DetailViewPresentationAdapter(feed: feed)
    let controller = makeWith(delegate: adapter, title: Localized.Detail.title)
    
    adapter.presenter = DetailPresenter(detailView: WeakRefVirtualProxy(controller))
    
    return controller
  }
  
  static func makeWith(delegate: DetailViewControllerDelegate, title: String) -> DetailViewController {
    let bundle = Bundle(for: DetailViewController.self)
    let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
    let controller = storyboard.instantiateInitialViewController() as! DetailViewController
    controller.delegate = delegate
    controller.title = title
    return controller
  }
}
