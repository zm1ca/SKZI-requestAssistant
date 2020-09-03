//
//  TestResultVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TestResultVC: UIViewController {
    
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
        performTests()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemGray6
        title = "Result"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func performTests() {
        test16_1(for: mechanisms) { self.failureMessage(for: "16.1", $0) }
    }
    
    
    func failureMessage(for test: String, _ mechanisms: [Mechanism]) {
        print("Test \(test) not passed. Try adding any of following mechanisms: ")
        for mechanism in mechanisms {
            print(mechanism.rawValue)
        }
    }
}
