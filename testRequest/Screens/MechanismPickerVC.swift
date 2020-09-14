//
//  MechanismPickerVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class MechanismPickerVC: UIViewController {

    let tableView       = UITableView(frame: CGRect.zero, style: .insetGrouped)
    let actionButton    = UIButton()
    
    var request:            Request?
    var chosenMechanisms:   [Mechanism]!
    var leftMechanisms:     [Mechanism]!
    
    var filteredLeftMechanisms  = [Mechanism]()
    var isSearching             = false
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.request = Request(named: nil, by: nil, with: [])
        updateMechanisms()
    }
    
    
    init(request: Request) {
        super.init(nibName: nil, bundle: nil)
        self.request = request
        updateMechanisms()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureActionButton()
        configureTableView()
        configureSearchController()
        
        layoutUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateButtonsVisibility()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollToTop()
    }
    
    
    @objc func resetBarButtonTapped() {
        self.request?.mechanisms.removeAll()
        updateMechanisms()
        updateButtonsVisibility()
        tableView.reloadDataOnMainThread()
    }
    
    
    @objc func actionButtonTapped() {
        guard !chosenMechanisms.isEmpty else { return }
        var destVC: ResultsVC
        
        if request != nil {
            request!.mechanisms = Set(chosenMechanisms)
            destVC = ResultsVC(request: request!)
        } else {
            let newRequest = Request(named: nil, by: nil, with: Set(chosenMechanisms))
            destVC = ResultsVC(request: newRequest)
        }
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func scrollToTop() {
        if !chosenMechanisms.isEmpty {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    
    func updateButtonsVisibility() {
        guard let resetButton = self.navigationItem.rightBarButtonItem else { return }
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            
            if self.chosenMechanisms.isEmpty {
                self.actionButton.alpha = 0
                resetButton.isEnabled   = false
                resetButton.tintColor   = UIColor.clear
                
            } else {
                self.actionButton.alpha = 1
                resetButton.isEnabled   = true
                resetButton.tintColor   = UIColor.systemBlue
            }
        }
    }
    
    
    func updateMechanisms() {
        if let request = request {
            chosenMechanisms    = Array(request.mechanisms)
            leftMechanisms      = Mechanism.allCases.filter{ !self.chosenMechanisms.contains($0) }
        } else {
            chosenMechanisms    = []
            leftMechanisms      = Mechanism.allCases
        }
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Проверка"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let infoButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetBarButtonTapped))
        navigationItem.rightBarButtonItem = infoButton
    }

    
    func configureActionButton() {
        actionButton.alpha              = 0
        
        actionButton.backgroundColor    = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
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
        tableView.setEditing(true, animated: false)
        
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.register(TRMechanismCell.self, forCellReuseIdentifier: TRMechanismCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Найти механизм"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    func layoutUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
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


extension MechanismPickerVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return "Оставшиеся механизмы"
        } else {
            return section == 0 ? "Выбранные механизмы" : "Оставшиеся механизмы"
        }
            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredLeftMechanisms.count
        } else {
            return section == 0 ? chosenMechanisms.count : leftMechanisms.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRMechanismCell.reuseID, for: indexPath) as! TRMechanismCell
        
        var mechanisms: [Mechanism] = []
        if isSearching {
            mechanisms = filteredLeftMechanisms
        } else {
            mechanisms = indexPath.section == 0 ? chosenMechanisms: leftMechanisms
        }
        
        let mechanism = mechanisms[indexPath.row]
        cell.set(for: mechanism)
        return cell
    }
}


extension MechanismPickerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
            
        } else {
            guard editingStyle == .insert else { return }
            
            let chosenMechanism = filteredLeftMechanisms.remove(at: indexPath.row)
            chosenMechanisms.append(chosenMechanism)
            leftMechanisms = leftMechanisms.filter { $0.shortName != chosenMechanism.shortName }
            
            tableView.deleteRows(at: [indexPath], with: .right)
            //TODO: dismiss search if filtered.isEmpty
        }
        
        updateButtonsVisibility()
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 && !isSearching {
            return .delete
        } else {
            return .insert
        }
    }
}


extension MechanismPickerVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredLeftMechanisms.removeAll()
            isSearching = false
            tableView.reloadDataOnMainThread()
            return
        }

        isSearching = true
        filteredLeftMechanisms = leftMechanisms.filter({ $0.shortName.lowercased().contains(filter.lowercased()) || $0.rawValue.lowercased().contains(filter.lowercased()) })
        tableView.reloadDataOnMainThread()
    }
}
