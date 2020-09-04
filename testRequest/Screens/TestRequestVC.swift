//
//  TestRequestVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TestRequestVC: UIViewController {
    
    let scrollView      = UIScrollView()
    let choiceStackView = UIStackView()
    let actionButton    = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureActionButton()
        configureScrollView()
        configureStackView()
        configureChoices()
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Choose mechanisms"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        actionButton.backgroundColor    = .systemGray5
        actionButton.layer.cornerRadius = 15
        actionButton.layer.borderWidth  = 2
        actionButton.layer.borderColor  = UIColor.secondaryLabel.cgColor
    
        actionButton.setTitleColor(.secondaryLabel, for: .normal)
        actionButton.setTitle("Test", for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: actionButton.topAnchor)
        ])
    }
    
    
    private func configureStackView() {
        choiceStackView.axis            = .vertical
        choiceStackView.distribution    = .equalSpacing
        choiceStackView.spacing         = 5
        
        scrollView.addSubview(choiceStackView)
        choiceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        choiceStackView.pinToEdges(of: scrollView)
        NSLayoutConstraint.activate([
            choiceStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            choiceStackView.heightAnchor.constraint(equalToConstant: CGFloat(Mechanism.allCases.count * (34 + 40)))
        ])
    }
    
    
    func configureChoices() {
        for mechanism in Mechanism.allCases {
            let choiceView = TRChoiceView()
            choiceView.set(with: mechanism)
            choiceStackView.addArrangedSubview(choiceView)
        }
    }
    
    
    @objc func actionButtonTapped() {
        var chosenMechanisms: [Mechanism] = []
        
        for choiceView in choiceStackView.arrangedSubviews {
            guard let choiceView = choiceView as? TRChoiceView, choiceView.toggle.isOn else { continue }
            chosenMechanisms.append(choiceView.mechanism)
        }
        
        navigationController?.pushViewController(TestResultVC(mechanisms: chosenMechanisms), animated: true)
    }
}
