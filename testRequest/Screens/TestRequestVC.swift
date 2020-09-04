//
//  TestRequestVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TestRequestVC: UIViewController {
    
    var chosenMechanisms: [Mechanism]   = []
    var leftMechanisms                  = Mechanism.allCases

    let tableView                       = UITableView(frame: CGRect.zero, style: .grouped)
    let actionButton                    = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureSearchController()
        configureTableView()
        configureActionButton()
        layoutUI()
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
        tableView.rowHeight         = 60
        tableView.separatorStyle    = .singleLine
        tableView.allowsSelection   = false
        tableView.setEditing(true, animated: true)
        
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.register(TRMechanismCell.self, forCellReuseIdentifier: TRMechanismCell.reuseID)
    }
    
    
    @objc func actionButtonTapped() {
        navigationController?.pushViewController(TestResultVC(mechanisms: chosenMechanisms), animated: true)
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
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //tableView.bottomAnchor.constraint(equalTo: actionButton.topAnchor)
        ])
        
        self.view.bringSubviewToFront(self.actionButton)
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
        return section == 0 ? chosenMechanisms.count : leftMechanisms.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: TRMechanismCell.reuseID, for: indexPath) as! TRMechanismCell
        let mechanisms  = indexPath.section == 0 ? chosenMechanisms: leftMechanisms
        let mechanism   = mechanisms[indexPath.row]
        cell.set(for: mechanism)
   
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            chosenMechanisms.append(leftMechanisms[indexPath.row])
            leftMechanisms.remove(at: indexPath.row)
            tableView.moveRow(at: indexPath, to: IndexPath(row: chosenMechanisms.count - 1, section: 0))
            
        } else if editingStyle == .delete {
            leftMechanisms.insert(chosenMechanisms[indexPath.row], at: 0)
            chosenMechanisms.remove(at: indexPath.row)
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 1))
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.section == 0 ? .delete : .insert
    }
}


extension TestRequestVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // filter leftMechanisms
        
//        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
//            filteredFollowers.removeAll()
//            isSearching = false
//            updateData(on: followers)
//            return
//        }
//
//        isSearching = true
//        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
//        updateData(on: filteredFollowers)
    }
}
