//
//  TRNamingVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 10.09.20.
//

import UIKit

class TRNamingVC: UIViewController {

    let containerView             = TRAlertContainerView()
    let productNameTextField      = UITextField()
    let organizationNameTextField = UITextField()
    let actionButton              = TRButton(backgroundColor: .systemPink)
    
    var productName: String?
    var organizationName: String?
    
    let padding: CGFloat = 20
    
    init(productName: String?, organizationName: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.productName        = productName
        self.organizationName   = organizationName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, productNameTextField, organizationNameTextField, actionButton)
        
        configureContainerView()
        //configureProductNameTextField()
        configureActionButton()
        //configureOrganizationNameTextField()
    }
    
    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureProductNameTextField() {
        productNameTextField.text = productName ?? ""
        
        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            productNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            productNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            productNameTextField.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        actionButton.setTitle("Ок", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureOrganizationNameTextField() {
        organizationNameTextField.text = organizationName ?? ""
        
        NSLayoutConstraint.activate([
            organizationNameTextField.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 8),
            organizationNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            organizationNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            organizationNameTextField.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }

}
