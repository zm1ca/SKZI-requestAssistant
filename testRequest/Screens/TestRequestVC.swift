//
//  TestRequestVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TestRequestVC: UIViewController {

    var chosenMechanisms: [Mechanism]       = []
    var leftMechanisms                      = Mechanism.allCases
    
    let tableView                           = UITableView(frame: CGRect.zero, style: .grouped)
    let actionButton                        = UIButton()
    
    
    var filteredLeftMechanisms: [Mechanism] = []
    var isSearching = false
    var correctLeftMechanisms: [Mechanism] {
        return isSearching ? self.filteredLeftMechanisms : self.leftMechanisms
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureSearchController()
        configureTableView()
        configureActionButton()
        layoutUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    func configureActionButton() {
        actionButton.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        actionButton.setTitleColor(.label, for: .normal)
        actionButton.setTitle("GO!", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        actionButton.layer.cornerRadius = 40
        actionButton.layer.borderWidth  = 2
        actionButton.layer.borderColor  = UIColor.tertiaryLabel.cgColor
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.rowHeight         = 60
        tableView.separatorStyle    = .singleLine
        tableView.allowsSelection   = false
        tableView.setEditing(true, animated: false)
        
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.register(TRMechanismCell.self, forCellReuseIdentifier: TRMechanismCell.reuseID)
    }
    
    
    @objc func actionButtonTapped() {
        navigationController?.pushViewController(TestResultVC(mechanisms: chosenMechanisms, self), animated: true)
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Найти механизм"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    func layoutUI() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.widthAnchor.constraint(equalToConstant: 80),
            actionButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}


extension TestRequestVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Выбранные механизмы" : "Оставшиеся механизмы"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? chosenMechanisms.count : correctLeftMechanisms.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: TRMechanismCell.reuseID, for: indexPath) as! TRMechanismCell
        let mechanisms  = indexPath.section == 0 ? chosenMechanisms: correctLeftMechanisms
        let mechanism   = mechanisms[indexPath.row]
        cell.set(for: mechanism)
   
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        #warning("Adding elements due searching isn't implemented yet")
        if !isSearching {
            if editingStyle == .insert {
                chosenMechanisms.append(leftMechanisms[indexPath.row])
                leftMechanisms.remove(at: indexPath.row)
                tableView.moveRow(at: indexPath, to: IndexPath(row: chosenMechanisms.count - 1, section: 0))
            } else if editingStyle == .delete {
                leftMechanisms.insert(chosenMechanisms[indexPath.row], at: leftMechanisms.count)
                chosenMechanisms.remove(at: indexPath.row)
                tableView.moveRow(at: indexPath, to: IndexPath(row: leftMechanisms.count - 1, section: 1))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.section == 0 ? .delete : .insert
    }
}


extension TestRequestVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredLeftMechanisms = leftMechanisms.filter({ $0.shortName.lowercased().contains(filter.lowercased()) })
        tableView.reloadData()
    }
}


extension TestRequestVC: TestResultVCDismissDelegate {
    
    func scrollToTop() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
