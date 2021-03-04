//
//  ResultsVC+SaveBarButton.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 26.02.21.
//

import UIKit

protocol UnusedMechanismsFixable {

    func removeUnusedDeclarations(of mechanisms: [Mechanism])
}

extension ResultsVC {

    // TODO: Create UITest
    @objc func saveBarButtonTapped() {

        viewModel!.requestHasUnusedMechanisms
            ? presentUnusedMechanismsAlertController()
            : presentRequestSavingVCOnMainThread()
    }

    private func presentUnusedMechanismsAlertController() {
        let alertController = UIAlertController(
            title: "Выявлена избыточность!",
            message: viewModel!.unusedMechanismsShort,
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "Назад", style: .cancel) { _ in
            alertController.dismiss(animated: true)
        }

        let forwardAction = UIAlertAction(title: "Игнорировать", style: .default) {[weak self] _ in
            guard let self = self else { return }
            alertController.dismiss(animated: true, completion: { self.presentRequestSavingVCOnMainThread() })
        }

        let fixAction = UIAlertAction(title: "Исправить", style: .default) {[weak self] _ in
            guard let self = self else { return }

            self.navigationController?.popToRootViewController(animated: true)
            let vc = self.navigationController?.visibleViewController as! UnusedMechanismsFixable

            vc.removeUnusedDeclarations(of: self.viewModel!.unusedMechanisms)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(forwardAction)
        alertController.addAction(fixAction)
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
