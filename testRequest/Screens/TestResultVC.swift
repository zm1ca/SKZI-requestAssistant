//
//  TestResultVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit


class TestResultVC: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    var mechanisms: [Mechanism]!
    
    
    init(mechanisms: [Mechanism]) {
        super.init(nibName: nil, bundle: nil)
        self.mechanisms = mechanisms
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        title = "Результаты"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc func saveButtonTapped() {
        let request = Request(named: "Product", by: "Company", with: mechanisms)
        
        PersistenceManager.updateWith(request: request, actionType: .add) { error in
            guard let error = error else {
                self.presentTRAlertOnMainThread(title: TRAlertConstants.noErrorsTitle, message: TRAlertConstants.requsetSavedMessage)
                return
            }
            
            self.presentTRAlertOnMainThread(title: TRAlertConstants.sadErrorTitle, message: error.rawValue)
        }
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame           = view.bounds
        tableView.rowHeight       = 80
        tableView.allowsSelection = false
        tableView.separatorStyle  = .singleLine
        
        tableView.dataSource      = self
        tableView.register(TRPointCell.self, forCellReuseIdentifier: TRPointCell.reuseID)
    }
}


extension TestResultVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ResultsTableViewConstants.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(16 + section). \(ResultsTableViewConstants.sectionHeaders[section])"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultsTableViewConstants.sectionSizes[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRPointCell.reuseID, for: indexPath) as! TRPointCell
        cell.set(for: indexPath, with: mechanisms)
        
        return cell
    }
}
