//
//  SavedRequestsVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit
import SnapKit

final class SavedRequestsVC: UIViewController {

    let emptyStateLabel: TRTitleLabel = {
        let label = TRTitleLabel()
        label.text = "Здесь будет отображён список сохранённых заявок."
        label.numberOfLines = 0
        return label
    }()

    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)

    var requests: [Request] = [] { didSet { updateUI() } }

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
        let ac = configureRemoveAllRequestsAlertController()
        present(ac, animated: true, completion: nil)
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
        emptyStateLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }

    private func updateUI() {
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

    private func configureRemoveAllRequestsAlertController() -> UIAlertController {
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

        return alertController
    }
}
