//
//  DetailUIComposer.swift
//  ListApp
//
//  Created by Afsal on 02/05/2024.
//

import UIKit
import LIstiOS

final class DetailUIComposer {
  
  static func makeDetail() -> DetailViewController {
    let bundle = Bundle(for: DetailViewController.self)
    let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
    let controller = storyboard.instantiateInitialViewController() as! DetailViewController
    return controller
  }
}
