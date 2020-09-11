//
//  TRNamingVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 10.09.20.
//

import UIKit

protocol TRNamingVCDelegate {
    func updateRequest(with productName: String, organizationName: String)
    func saveRequest()
}

class TRNamingVC: UIViewController {

    let containerView             = TRAlertContainerView()
    let titleLabel                = TRTitleLabel(textAlignment: .center, fontSize: 20)
    let productNameTextField      = TRTextField()
    let organizationNameTextField = TRTextField()
    let cancelButton              = TRButton(backgroundColor: .tertiarySystemBackground)
    let actionButton              = TRButton(backgroundColor: .systemGray4)
    
    var productName: String?
    var organizationName: String?
    
    var delegate: TRNamingVCDelegate!
    
    let padding: CGFloat = 20
    
    init(productName: String?, organizationName: String?, delegate: TRNamingVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.productName        = productName
        self.organizationName   = organizationName
        self.delegate           = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, productNameTextField, organizationNameTextField, cancelButton, actionButton)
        
        configureContainerView()
        configureTitleLabel()
        configureProductNameTextField()
        configureOrganizationNameTextField()
        configureCancelButton()
        configureActionButton()
    }
    
    
    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 238),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    
    func configureTitleLabel() {
        titleLabel.text = "Сохранение заявки"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    func configureProductNameTextField() {
        productNameTextField.text = productName ?? ""
        productNameTextField.placeholder = "Название продукта"
        
        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            productNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            productNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            productNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureOrganizationNameTextField() {
        organizationNameTextField.text = organizationName ?? ""
        organizationNameTextField.placeholder = "Организация"
        
        NSLayoutConstraint.activate([
            organizationNameTextField.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 8),
            organizationNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            organizationNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            organizationNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureCancelButton() {
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: organizationNameTextField.bottomAnchor, constant: padding),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            cancelButton.widthAnchor.constraint(equalToConstant: 115),
            cancelButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureActionButton() {
        actionButton.setTitle("Ок", for: .normal)
        actionButton.addTarget(self, action: #selector(saveRequestAndDismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            actionButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 10),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        //actionButton.alpha = 0.3
    }
    
    
    @objc func saveRequestAndDismissVC() {
        //TODO: block button and visually present it
        guard let productNameText = productNameTextField.text, let organizationNameText = organizationNameTextField.text, !productNameText.isEmpty, !organizationNameText.isEmpty  else {
            return
        }
        
        delegate.updateRequest(with: productNameText, organizationName: organizationNameText)
        dismiss(animated: true, completion: nil)
        delegate.saveRequest()
    }
}


//extension TRNamingVC: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        saveRequestAndDismissVC()
//        return true
//    }
//}
