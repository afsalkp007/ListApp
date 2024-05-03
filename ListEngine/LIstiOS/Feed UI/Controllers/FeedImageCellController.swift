//
//  FeedImageCellController.swift
//  EssentialFeediOS
//
//  Created by Afsal on 06/04/2024.
//

import UIKit
import ListEngine

public typealias EmptyClosure = () -> Void

public protocol FeedImageCellControllerDelegate {
  func didRequestData()
}

public final class FeedImageCellController: NSObject, FeedImageView {
  public var delegate: FeedImageCellControllerDelegate
  private let selection: EmptyClosure
  private var cell: FeedImageCell?
  
  public init(delegate: FeedImageCellControllerDelegate, selection: @escaping EmptyClosure) {
    self.delegate = delegate
    self.selection = selection
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
  }
  
  private func releaseCellForReuse() {
    cell?.onReuse = nil
    cell = nil
  }
}

extension FeedImageCellController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selection()
  }
}
