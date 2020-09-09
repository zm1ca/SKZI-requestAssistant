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
    
    
    init(mechanisms: Set<Mechanism>) {
        super.init(nibName: nil, bundle: nil)
        self.request = Request(named: nil, by: nil, with: mechanisms)
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
        //TODO: Check if request needs a name
        
        PersistenceManager.updateWith(request: self.request, actionType: .add) { error in
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
        
        let shortNameForIndexPath = "p\(indexPath.section + 16)_\(indexPath.row + 1)"
        guard let paragraph = Paragraph.allCases.filter({ $0.shortName == shortNameForIndexPath }).first else {
            fatalError(TRAlertConstants.paragraphError)
        }
        
        //TODO: Программа должна производить ВСЕ проверки при загрузке экрана и класть результаты в request
        //request должен хранить словать <Paragraph, Set<Mechanism>>
        //пару (paragraph, neededMechanisms) нужно получать фильтруя request.СЛОВАРЬ
        //needed mechanisms for Paragraph это дело Request'a при формировании словаря
        let baseTitle = "\(indexPath.row + 1). "
        if let neededMechanisms = paragraph.getNeededMechanisms(for: request.mechanisms) {
            let details = neededMechanisms.reduce("Добавьте что-то из:", { $0 + " " + $1.shortName })
            cell.set(title: baseTitle + "Не соответствует", details: details, backgroundColor: UIColor.systemRed.withAlphaComponent(0.75))
            request.matchingParagraphs.filter{ $0 != paragraph }
        } else {
            cell.set(title: baseTitle + "Соответствует", details: "", backgroundColor: UIColor.systemGreen.withAlphaComponent(0.75))
            if !request.matchingParagraphs.contains(paragraph) {
                request.matchingParagraphs.insert(paragraph)
            }
        }

        return cell
    }
}
