//
//  FeedImageCellController.swift
//  EssentialFeediOS
//
//  Created by Afsal on 06/04/2024.
//

import UIKit
import ListEngine

public protocol FeedImageCellControllerDelegate {
  func didRequestData()
  func didCancelDataRequest()
}

public final class FeedImageCellController: FeedImageView {
  private var delegate: FeedImageCellControllerDelegate
  private var cell: FeedImageCell?
  
  public init(delegate: FeedImageCellControllerDelegate) {
    self.delegate = delegate
  }

  func view(in tableView: UITableView) -> UITableViewCell {
    self.cell = tableView.dequeueReusableCell()
    delegate.didRequestData()
    return cell!
  }
  
  public func display(_ viewModel: FeedImageViewModel) {
    cell?.nameLabel.text = viewModel.name
    cell?.stateLabel.text = viewModel.country
    
    cell?.onReuse = { [weak self] in
      self?.releaseCellForReuse()
    }
  }
  
  func preload() {
    delegate.didRequestData()
  }
  
  func cancelLoad() {
    releaseCellForReuse()
    delegate.didCancelDataRequest()
  }
  
  private func releaseCellForReuse() {
    cell?.onReuse = nil
    cell = nil
  }
}