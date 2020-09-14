//
//  UIViewController+Ext.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 14.09.20.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
