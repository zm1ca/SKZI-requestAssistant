//
//  SavedRequestsVC+DataSource.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension SavedRequestsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRRequestCell.reuseID) as! TRRequestCell
        let viewModel = SavedRequestsViewModel(request: requests[indexPath.row])
        cell.configure(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        PersistenceManager.updateWith(request: requests[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }

            guard let error = error else {
                self.requests.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }

            self.presentAlertOnMainThread(with: TRErrorVerbouseConstants.somethingWrong, and: error.rawValue)
        }
    }
}
