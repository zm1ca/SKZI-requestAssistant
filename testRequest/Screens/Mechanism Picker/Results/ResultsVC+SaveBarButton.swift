//
//  ResultsVC+SaveBarButton.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 26.02.21.
//

import UIKit

extension ResultsVC {
    
    //TODO: Create UITest
    @objc func saveBarButtonTapped() {
        
        viewModel!.requestHasUnusedMechanisms
            ? presentUnusedMechanismsAlertController()
            : presentRequestSavingVCOnMainThread()
    }


    private func presentUnusedMechanismsAlertController() {
        let alertController = UIAlertController(title: "Выявлена избыточность!", message: viewModel!.unusedMechanismsShort, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        let forwardAction = UIAlertAction(title: "Игнорировать", style: .default) {[weak self] _ in
            guard let self = self else { return }
            alertController.dismiss(animated: true, completion: { self.presentRequestSavingVCOnMainThread() })
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(forwardAction)
        present(alertController, animated: true)
    }


    private func presentRequestSavingVCOnMainThread() {
        DispatchQueue.main.async {
            let requestSavingVC = RequestSavingVC()
            requestSavingVC.delegate = self
            requestSavingVC.request  = self.viewModel?.request
            requestSavingVC.modalPresentationStyle = .overFullScreen
            requestSavingVC.modalTransitionStyle   = .crossDissolve

            self.present(requestSavingVC, animated: true)
        }
    }
}

