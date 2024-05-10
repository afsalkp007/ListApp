//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Afsal on 02/04/2024.
//

import UIKit
import ListEngine

public protocol FeedViewControllerDelegate {
  func didRequestFeedRefresh()
}

public final class FeedViewController: UITableViewController {
  @IBOutlet private(set) public var errorView: ErrorView!
  
  private var onViewIsAppearing: ((FeedViewController) -> Void)?
  public var delegate: FeedViewControllerDelegate?
  
  private var tableModel = [FeedImageCellController]() {
    didSet { tableView.reloadData() }
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    onViewIsAppearing = { vc in
      vc.refresh()
      vc.onViewIsAppearing = nil
    }
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.sizeTableHeaderToFit()
  }
  
  public override func viewIsAppearing(_ animated: Bool) {
    super.viewIsAppearing(animated)
    
    onViewIsAppearing?(self)
  }
  
  public func display(_ cellControllers: [FeedImageCellController]) {
    self.tableModel = cellControllers
  }
  
  @IBAction func refresh() {
    delegate?.didRequestFeedRefresh()
  }
}

extension FeedViewController: FeedLoadingView, FeedErrorView {
  public func display(_ viewModel: FeedLoadingViewModel) {
    refreshControl?.isHidden = !viewModel.isLoading
    refreshControl?.update(viewModel.isLoading)
  }
  
  public func display(_ viewModel: FeedErrorViewModel) {
    errorView.message = viewModel.message
    errorView.isHidden = viewModel.message == .none
  }
}
 
extension FeedViewController: UITableViewDataSourcePrefetching {
  public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableModel.count
  }
  
  public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellController(forRowAt: indexPath).view(in: tableView)
  }
  
  public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    removeCellController(forRowAt: indexPath)
  }
  
  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dl = cellController(forRowAt: indexPath)
    dl.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cellController(forRowAt: indexPath).preload()
  }
  
  public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    indexPaths.forEach { indexPath in
      cellController(forRowAt: indexPath).preload()
    }
  }
  
  public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    indexPaths.forEach(removeCellController)
  }
  
  private func removeCellController(forRowAt indexPath: IndexPath) {
    cellController(forRowAt: indexPath).cancelLoad()
  }
  
  private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
    return tableModel[indexPath.row]
  }
}
