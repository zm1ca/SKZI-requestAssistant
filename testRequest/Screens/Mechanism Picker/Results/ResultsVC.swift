//
//  ResultsVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

final class ResultsVC: UIViewController {

    let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    var viewModel: ResultsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVС()
        configureTableView()
    }

    private func configureVС() {
        view.backgroundColor = .systemBackground
        title = "Результаты"
        navigationController?.navigationBar.prefersLargeTitles = true

        let saveBarButttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveBarButtonTapped))
        navigationItem.rightBarButtonItem = saveBarButttonItem
    }

    private func configureTableView() {
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
