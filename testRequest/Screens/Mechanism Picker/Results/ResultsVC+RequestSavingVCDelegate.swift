//
//  ResultsVC+TRNamingVCDelegate.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 23.02.21.
//

import Foundation

extension ResultsVC: RequestSavingVCDelegate {
    //Might be improved:
    //1. clear request in MechanismPicker before segue
    //2. pop root controller for SavedRequestsNC
    func resetVCAndTransferToSaved() {
        if tabBarController?.selectedIndex == 0 {
            tabBarController?.selectedIndex = 2 //FIX: doesn't seem to work
        } else {
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
