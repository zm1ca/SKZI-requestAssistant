//
//  MechanismPickerVC+UISearchResultsUpdating.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension MechanismPickerVC: UISearchResultsUpdating {

    var isSearching: Bool {
        !filteredLeftMechanisms.isEmpty
    }

    func configureSearchController() {
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.placeholder                = "Найти механизм"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredLeftMechanisms.removeAll()
            tableView.reloadDataOnMainThread()
            return
        }

        filteredLeftMechanisms = leftMechanisms.filter {
            $0.shortName.lowercased().contains(filter.lowercased()) ||
            $0.rawValue.lowercased().contains(filter.lowercased())
        }
        tableView.reloadDataOnMainThread()
    }
}
