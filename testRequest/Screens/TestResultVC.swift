//
//  TestResultVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TestResultVC: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
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
        setupTableView()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemGray6
        title = "Result"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 60
        tableView.dataSource    = self
        tableView.removeAccessCells()
        #warning("TableView doesn't allow selection!")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(TRPointCell.self, forCellReuseIdentifier: TRPointCell.reuseID)
    }
}


extension TestResultVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewConstants.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableViewConstants.sectionHeaders[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewConstants.sectionSizes[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRPointCell.reuseID, for: indexPath) as! TRPointCell
        cell.configure(for: indexPath, with: mechanisms)
        
        return cell
    }
}
