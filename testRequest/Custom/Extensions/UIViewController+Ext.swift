//
//  UIViewController+Ext.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentTRAlertOnMainThread(title:String, message: String) {
        DispatchQueue.main.async {
            let alertVC = TRAlertVC(title: title, message: message)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
