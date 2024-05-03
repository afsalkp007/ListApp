//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Afsal on 03/04/2024.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
  @IBOutlet private(set) public var nameLabel: UILabel!
  @IBOutlet private(set) public var stateLabel: UILabel!
  
  var onReuse: (() -> Void)?
  
  public override func prepareForReuse() {
    super.prepareForReuse()
    
    onReuse?()
  }
}
