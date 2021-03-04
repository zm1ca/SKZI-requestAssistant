//
//  MechanismPickerVC+UnusedMechanismsFixable.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.03.21.
//

import Foundation

extension MechanismPickerVC: UnusedMechanismsFixable {

    func removeUnusedDeclarations(of mechanisms: [Mechanism]) {
        request.declaredMechanisms.removeAll { mechanisms.contains($0) }
        tableView.reloadDataOnMainThread()
    }
}
