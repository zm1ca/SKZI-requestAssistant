//
//  ResultsVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit


class ResultsVC: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    var request: Request!
    
    
    init(request: Request) {
        super.init(nibName: nil, bundle: nil)
        self.request = request
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
        self.presentTRNamingOnMainThread(productName: request.productName, organizationName: request.organizationName, delegate: self)
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame           = view.bounds
        tableView.rowHeight       = 80
        tableView.allowsSelection = false
        tableView.separatorStyle  = .singleLine
        
        tableView.dataSource      = self
        tableView.register(TRParagraphCell.self, forCellReuseIdentifier: TRParagraphCell.reuseID)
    }
}


extension ResultsVC: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TRParagraphCell.reuseID, for: indexPath) as! TRParagraphCell
        
        let shortNameForIndexPath = "\(indexPath.section + 16).\(indexPath.row + 1)"
        guard let paragraph = Paragraph.allCases.filter({ $0.shortName == shortNameForIndexPath }).first else {
            fatalError(TRAlertConstants.paragraphError)
        }
        
        let baseTitle = "\(indexPath.row + 1). "
        if let neededMechanisms = request.results[paragraph] {
            let details = neededMechanisms.reduce("Добавьте что-то из:", { $0 + " " + $1.shortName })
            cell.set(title: baseTitle + "Не соответствует", details: details, backgroundColor: UIColor.systemRed.withAlphaComponent(0.75))
        } else {
            cell.set(title: baseTitle + "Соответствует", details: "", backgroundColor: UIColor.systemGreen.withAlphaComponent(0.75))
        }

        return cell
    }
}


extension ResultsVC: TRNamingVCDelegate {
    
    func updateRequest(with productName: String, organizationName: String) {
        request.set(productName: productName, organizationName: organizationName)
    }
    
    
    func saveRequest() {
        PersistenceManager.updateWith(request: self.request, actionType: .add) { error in
            guard let error = error else {
                self.presentTRAlertOnMainThread(title: TRAlertConstants.noErrorsTitle, message: TRAlertConstants.requsetSavedMessage)
                return
            }
            
            self.presentTRAlertOnMainThread(title: TRAlertConstants.sadErrorTitle, message: error.rawValue)
        }
    }
}
