//
//  RequestCreatorVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit
import SafariServices

class RequestCreatorVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Составление"
        
        let infoButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    
    @objc func infoButtonTapped() {
        guard let url = URLConstants.order77Table else {
            print(TRAlertConstants.cantOpenWebsite)
            return
        }
        
        present(SFSafariViewController(url: url), animated: true)
    }
}
