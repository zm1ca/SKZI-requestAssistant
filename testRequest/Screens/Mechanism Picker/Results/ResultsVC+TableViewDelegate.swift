//
//  ResultsVC+TableView.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension ResultsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let (title, message): (String, String) = viewModel!.paragraphAccessoryInfo(for: indexPath)
        presentAlertOnMainThread(with: title, and: message)
    }
}
