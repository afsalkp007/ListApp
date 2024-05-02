//
//  Localized+Detail.swift
//  ListEngine
//
//  Created by Afsal on 02/05/2024.
//

import Foundation

extension Localized {
  private static var detail: String { "Detail" }
  
  public enum Detail {
    public static var title: String {
      return NSLocalizedString(
        "Detail_VIEW_TITLE",
        tableName: detail,
        bundle: Bundle(for: DetailPresenter.self),
        comment: "Title for the detail view"
      )
    }
  }
}
