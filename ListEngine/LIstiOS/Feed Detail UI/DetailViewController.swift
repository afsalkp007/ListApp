//
//  DetailViewController.swift
//  LIstiOS
//
//  Created by Afsal on 02/05/2024.
//

import UIKit
import ListEngine

public protocol DetailViewControllerDelegate {
  func loadFeed()
}

public class DetailViewController: UIViewController, DetailView {
  public var delegate: DetailViewControllerDelegate?
  
  @IBOutlet private(set) public var nameLabel: UILabel!
  @IBOutlet private(set) public var stateLabel: UILabel!
  @IBOutlet private(set) public var countryLabel: UILabel!
  @IBOutlet private(set) public var webpageLabel: UILabel!
  @IBOutlet private(set) public var codeLabel: UILabel!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate?.loadFeed()
  }
  
  public func display(_ viewModel: DetailViewModel) {
    nameLabel.text = viewModel.name
    stateLabel.text = viewModel.state
    countryLabel.text = viewModel.country
    codeLabel.text = viewModel.code
    webpageLabel.text = viewModel.webpage
  }
}
