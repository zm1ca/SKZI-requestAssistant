//
//  MakeRequestVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class MakeRequestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    
    func configureVC() {
        view.backgroundColor = .secondarySystemGroupedBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Составление"
        
        let infoButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    
    @objc func infoButtonTapped() {
        guard let url = URLConstants.order77Table else {
            self.presentTRAlertOnMainThread(title: TRAlertConstants.sadErrorTitle, message: TRAlertConstants.cantOpenWebsite)
            return
        }
        
        self.presentSafariVC(with: url)
    }
}
