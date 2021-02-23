//
//  ResultsVC+TableView.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension ResultsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let paragraph = Paragraph.getParagraph(for: indexPath)
        presentAlertOnMainThread(with: "\(TRErrorVerbouseConstants.paragraphInfo) \(paragraph.shortName)", and: paragraph.rawValue)
    }
}
