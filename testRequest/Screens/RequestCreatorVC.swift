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
    
    
    @objc func infoButtonTapped() {
        guard let url = URLConstants.order77Table else {
            presentAlertOnMainThread(with: TRAlertConstants.cantOpenWebsite)
            return
        }
        
        present(SFSafariViewController(url: url), animated: true)
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Составление"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let infoButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }
}
