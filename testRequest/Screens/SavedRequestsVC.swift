//
//  SavedRequestsVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class SavedRequestsVC: UIViewController {
    
    let tableView           = UITableView()
    var requests: [Request] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRequests()
    }
    
    
    func configureVC() {
        view.backgroundColor = .secondarySystemGroupedBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "История"
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 60
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeAccessCells()
        
        tableView.register(TRRequestCell.self, forCellReuseIdentifier: TRRequestCell.reuseID)
    }
    
    
    func getRequests() {
        PersistenceManager.retrieveRequests { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let Requests):
                self.requests = Requests
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentTRAlertOnMainThread(title: TRAlertConstants.sadErrorTitle, message: error.rawValue)
            }
        }
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
        
        PersistenceManager.updateWith(request: requests[indexPath.row], actionType: .remove) { error in
            guard let error = error else {
                self.requests.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentTRAlertOnMainThread(title: TRAlertConstants.sadErrorTitle, message: error.rawValue)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = requests[indexPath.row]
        let destinationVC  = MechanismPickerVC(request: request)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
