//
//  SavedRequestsVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class SavedRequestsVC: UIViewController {

    let emptyStateLabel: TRTitleLabel = {
        let label = TRTitleLabel()
        label.text = "Здесь будет отображён список сохранённых заявок."
        label.numberOfLines = 0
        return label
    }()

    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)

    var requests: [Request] = [] {
        didSet {
            guard let trashButton = self.navigationItem.rightBarButtonItem else { return }

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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        layoutUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRequests()
    }

    private func loadRequests() {
        PersistenceManager.loadRequests { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let requests):
                self.requests = requests.sorted { $0.dateModified > $1.dateModified }
                self.tableView.reloadDataOnMainThread()

            case .failure(let error):
                self.presentAlertOnMainThread(with: TRErrorVerbouseConstants.somethingWrong, and: error.rawValue)
            }
        }
    }

    @objc private func removeAllButtonTapped() {
        let alertController = UIAlertController(title: "Удалить все заявки?", message: nil, preferredStyle: .alert)

        let approveAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self = self else { return }

            for request in self.requests {
                PersistenceManager.updateWith(request: request, actionType: .remove) { error in
                    guard let error = error else { return }
                    self.presentAlertOnMainThread(with: TRErrorVerbouseConstants.somethingWrong, and: error.rawValue)
                }
            }

            self.requests.removeAll()
            self.tableView.reloadDataOnMainThread()
        }
        alertController.addAction(approveAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Сохранённые"
        navigationController?.navigationBar.prefersLargeTitles = true

        let removeAllBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllButtonTapped))
        navigationItem.rightBarButtonItem = removeAllBarButtonItem
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.rowHeight  = 100
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.removeAccessCells()

        tableView.register(TRRequestCell.self, forCellReuseIdentifier: TRRequestCell.reuseID)
    }

    private func layoutUI() {
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate([
            emptyStateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyStateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
