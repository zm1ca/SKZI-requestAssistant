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
        
        configureVС()
        configureTableView()
    }
    
    
    @objc func presentTRNamingVCOnMainThread() {
        DispatchQueue.main.async {
            let namingVC = NamingVC(productName: self.request.productName, organizationName: self.request.organizationName, request: self.request)
            namingVC.delegate = self
            namingVC.modalPresentationStyle  = .overFullScreen
            namingVC.modalTransitionStyle    = .crossDissolve
    
            self.present(namingVC, animated: true)
        }
    }

    
    func configureVС() {
        view.backgroundColor = .secondarySystemBackground
        title = "Результаты"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let saveBarButttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentTRNamingVCOnMainThread))
        navigationItem.rightBarButtonItem = saveBarButttonItem
    }
    
    
    func configureTableView(){
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
        let paragraph = Paragraph.getParagraph(for: indexPath)
        let baseTitle = "\(indexPath.row + 1). "
        
        if let neededMechanisms = request.results[paragraph] {
            let details = neededMechanisms.reduce("Добавьте что-то из:", { $0 + " " + $1.shortName + "," }).dropLast()
            cell.set(title: baseTitle + "Не соответствует", details: String(details), backgroundColor: TRColors.failure)
            
        } else {
            cell.set(title: baseTitle + "Соответствует", details: nil, backgroundColor: TRColors.success)
        }

        return cell
    }
}


extension ResultsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let paragraph = Paragraph.getParagraph(for: indexPath)
        presentAlertOnMainThread(with: "\(TRAlertConstants.paragraphInfo) \(paragraph.shortName)", and: paragraph.rawValue)
    }
}


extension ResultsVC: TRNamingVCDelegate {
    //TODO: might be improved:
    //1. clear request in MechanissmPicker before segue
    //2. pop root controller for SavedRequestsNC
    func resetVCAndTransferToSaved() {
        if tabBarController?.selectedIndex == 0 {
            tabBarController?.selectedIndex = 2
        } else {
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
