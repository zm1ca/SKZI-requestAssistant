//
//  ResultsVC+DataSource.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension ResultsVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel!.numberOfSections
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel!.titleForHeader(in: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRParagraphCell.reuseID, for: indexPath) as! TRParagraphCell

        let (title, details, color): (String, String?, UIColor) =
            viewModel!.paragraphCellInfo(for: indexPath)

        cell.set(title: title, details: details, backgroundColor: color)

        return cell
    }
}
