//
//  MechanismPickerVC+DataSource.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import UIKit

extension MechanismPickerVC: UITableViewDataSource {
    
    var leftMechanisms: [Mechanism] {
        Mechanism.allCases.filter { !request.declaredMechanisms.contains($0) }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return "Оставшиеся механизмы"
        } else {
            return section == 0 ? "Выбранные механизмы" : "Оставшиеся механизмы"
        }
            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredLeftMechanisms.count
        } else {
            return section == 0 ? request.declaredMechanisms.count : leftMechanisms.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRMechanismCell.reuseID, for: indexPath) as! TRMechanismCell
        
        var mechanisms: [Mechanism] = []
        if isSearching {
            mechanisms = filteredLeftMechanisms
        } else {
            mechanisms = indexPath.section == 0 ? request.declaredMechanisms: leftMechanisms
        }
        
        let mechanism = mechanisms[indexPath.row]
        cell.set(for: mechanism)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isSearching {
            guard editingStyle == .insert else { return }
            
            let chosenMechanism = filteredLeftMechanisms[indexPath.row]
            request.declaredMechanisms.append(chosenMechanism)
            tableView.reloadDataOnMainThread() //Review
            
        } else {
            if editingStyle == .insert {
                request.declaredMechanisms.append(leftMechanisms[indexPath.row])
                tableView.moveRow(at: indexPath, to: IndexPath(row: request.declaredMechanisms.count - 1, section: 0))
                
            } else if editingStyle == .delete {
                request.declaredMechanisms.remove(at: indexPath.row)
                tableView.reloadDataOnMainThread() //Review
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 && !isSearching {
            return .delete
        } else {
            return .insert
        }
    }
}
