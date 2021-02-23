//
//  ResultsVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit


class ResultsVC: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    var request: Request!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVС()
        configureTableView()
    }
    
    
    @objc private func saveBarButtonTapped() {
        if !request.unusedMechanisms.isEmpty {
            let alertController = UIAlertController(title: "Выявлена избыточность!", message: "\(request.unusedMechanisms.reduce("", { $0 + " " + $1.shortName + "," }).dropLast())", preferredStyle: .alert)
            
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
            
        } else {
            presentRequestSavingVCOnMainThread()
        }
    }
    
    
    private func presentRequestSavingVCOnMainThread() {
        DispatchQueue.main.async {
            let requestSavingVC = RequestSavingVC()
            requestSavingVC.request = self.request
            requestSavingVC.delegate = self
            requestSavingVC.modalPresentationStyle  = .overFullScreen
            requestSavingVC.modalTransitionStyle    = .crossDissolve
    
            self.present(requestSavingVC, animated: true)
        }
    }

    
    private func configureVС() {
        view.backgroundColor = .secondarySystemBackground
        title = "Результаты"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let saveBarButttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveBarButtonTapped))
        navigationItem.rightBarButtonItem = saveBarButttonItem
    }
    
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.frame           = view.bounds
        tableView.rowHeight       = 80
        tableView.allowsSelection = false
        tableView.separatorStyle  = .singleLine
        
        tableView.dataSource      = self
        tableView.delegate        = self
        
        tableView.register(TRParagraphCell.self, forCellReuseIdentifier: TRParagraphCell.reuseID)
    }
}
