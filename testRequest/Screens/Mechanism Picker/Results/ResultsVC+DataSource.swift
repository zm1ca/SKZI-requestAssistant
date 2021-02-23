//
//  ResultsVC+DataSource.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension ResultsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ResultsTableViewConstants.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(16 + section). \(ResultsTableViewConstants.sectionHeaders[section])"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultsTableViewConstants.sectionSizes[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRParagraphCell.reuseID, for: indexPath) as! TRParagraphCell
        let paragraph = Paragraph.getParagraph(for: indexPath)
        let baseTitle = "\(indexPath.row + 1). "
        
        if let neededMechanisms = request.missingMechanisms[paragraph] {
            let details = neededMechanisms!.reduce("Добавьте", { $0 + " " + $1.shortName + " или" }).dropLast(4)
            cell.set(title: baseTitle + "Не соответствует", details: String(details), backgroundColor: TRColors.failure)
            
        } else {
            cell.set(title: baseTitle + "Соответствует", details: nil, backgroundColor: TRColors.success)
        }

        return cell
    }
}
