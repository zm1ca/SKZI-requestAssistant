//
//  UIViewController+Ext.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 14.09.20.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(with message: String) {
        let alertController = UIAlertController(title: "Что-то пошло не так ☹️", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
