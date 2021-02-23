//
//  SavedRequestsVC+TableView.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit


extension SavedRequestsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = requests[indexPath.row]
        let destinationVC = MechanismPickerVC()
        destinationVC.request = request
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
