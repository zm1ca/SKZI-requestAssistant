//
//  MechanismPickerVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit
import SnapKit

class MechanismPickerVC: UIViewController, UITableViewDelegate {

    // Make request a singleton?
    var request = Request() { didSet { updateButtonsVisibility() } }
    var filteredLeftMechanisms: [Mechanism] = [] // Move to UISearchResults somehow?

    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)

    let actionButton: UIButton = {
        let button = UIButton()
        button.alpha = 0

        button.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.9)
        button.setTitleColor(.label, for: .normal)
        button.setTitle("GO!", for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)

        button.layer.cornerRadius = 40
        button.layer.borderWidth  = 2
        button.layer.borderColor  = UIColor.tertiaryLabel.cgColor

        return button
    }()

    @objc private func actionButtonTapped() {
        let destVC = ResultsVC()
        destVC.viewModel = ResultsViewModel(request: request)
        navigationController?.pushViewController(destVC, animated: true)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureSearchController()
        layoutUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateButtonsVisibility()
    }

    private func updateButtonsVisibility() {
        guard let resetButton = self.navigationItem.rightBarButtonItem else { return }

        UIView.animate(withDuration: 0.25) {
            if self.request.declaredMechanisms.isEmpty {
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

    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Проверка"
        navigationController?.navigationBar.prefersLargeTitles = true

        let infoButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetBarButtonTapped))
        navigationItem.rightBarButtonItem = infoButton

        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(TRMechanismCell.self, forCellReuseIdentifier: TRMechanismCell.reuseID)
    }

    @objc private func resetBarButtonTapped() {
        self.request.declaredMechanisms.removeAll()
        updateButtonsVisibility()
        tableView.reloadDataOnMainThread()
    }

    private func configureTableView() {
        tableView.rowHeight       = 60
        tableView.separatorStyle  = .singleLine
        tableView.allowsSelection = false
        tableView.setEditing(true, animated: false)
    }

    private func layoutUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds

        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(80)
        }
    }
}
