//
//  SavedRequestsVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit


class SavedRequestsVC: UIViewController {
    
    let emptyStateLabel     = TRTitleLabel()
    let tableView           = UITableView(frame: CGRect.zero, style: .insetGrouped)
    var requests: [Request] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTableView()
        configureEmptyStateLabel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRequests()
    }
    
    
    func getRequests() {
        PersistenceManager.retrieveRequests { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let Requests):
                self.requests = Requests.sorted{ $0.dateModified > $1.dateModified }
                self.tableView.reloadDataOnMainThread()
                self.updateHasNothingSavedStatus()
                
            case .failure(let error):
                self.presentAlertOnMainThread(with: TRAlertConstants.somethingWrong, and: error.rawValue)
            }
        }
    }
    
    
    @objc func removeAllButtonTapped() {
        let alertController = UIAlertController(title: "Удалить все заявки?", message: nil, preferredStyle: .alert)
        
        let approveAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            for request in self.requests {
                PersistenceManager.updateWith(request: request, actionType: .remove) { error in
                    guard let error = error else { return }
                    self.presentAlertOnMainThread(with: TRAlertConstants.somethingWrong, and: error.rawValue)
                }
            }
            
            self.requests.removeAll()
            self.tableView.reloadDataOnMainThread()
            self.updateHasNothingSavedStatus()
        }
        alertController.addAction(approveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func updateHasNothingSavedStatus() {
        guard let trashButton = self.navigationItem.rightBarButtonItem else {
            return
        }

        if self.requests.isEmpty {
            trashButton.isEnabled = false
            trashButton.tintColor = UIColor.clear
            self.emptyStateLabel.isHidden = false
            self.tableView.isHidden = true
        } else {
            trashButton.isEnabled = true
            trashButton.tintColor = UIColor.systemBlue
            self.emptyStateLabel.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Сохранённые"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let removeAllBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllButtonTapped))
        navigationItem.rightBarButtonItem = removeAllBarButtonItem
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.rowHeight         = 90
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.removeAccessCells()
        
        tableView.register(TRRequestCell.self, forCellReuseIdentifier: TRRequestCell.reuseID)
    }
    
    
    func configureEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        emptyStateLabel.text = "Здесь будет отображён список сохранённых заявок."
        emptyStateLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            emptyStateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyStateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


extension SavedRequestsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRRequestCell.reuseID) as! TRRequestCell
        let request = requests[indexPath.row]
        cell.set(for: request)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(request: requests[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.requests.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                self.updateHasNothingSavedStatus()
                return
            }
            
            self.presentAlertOnMainThread(with: TRAlertConstants.somethingWrong, and: error.rawValue)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = requests[indexPath.row]
        let destinationVC  = MechanismPickerVC(request: request)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
