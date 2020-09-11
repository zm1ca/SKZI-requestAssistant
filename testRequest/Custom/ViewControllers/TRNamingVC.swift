//
//  TRNamingVC.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 10.09.20.
//

import UIKit


class TRNamingVC: UIViewController {
    
    var request: Request!
    
    let containerView             = TRAlertContainerView()
    let titleLabel                = TRTitleLabel(textAlignment: .center, fontSize: 20)
    let productNameTextField      = TRTextField()
    let organizationNameTextField = TRTextField()
    let cancelButton              = TRButton(backgroundColor: .tertiarySystemBackground, titleColor: .secondaryLabel)
    let actionButton              = TRButton(backgroundColor: .systemGray4, titleColor: .label)
        
    var productName:        String?
    var organizationName:   String?
    
    let padding: CGFloat          = 20
    
    var actionButtonIsActive      = false {
        didSet {
            if actionButtonIsActive {
                actionButton.isEnabled  = true
                actionButton.alpha      = 1
            } else {
                actionButton.isEnabled  = false
                actionButton.alpha      = 0.25
            }
        }
    }
    
    
    init(productName: String?, organizationName: String?, request: Request) {
        super.init(nibName: nil, bundle: nil)
        self.productName        = productName
        self.organizationName   = organizationName
        self.request            = request
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView)
        
        configureContainerView()
        configureTitleLabel()
        configureProductNameTextField()
        configureOrganizationNameTextField()
        configureCancelButton()
        configureActionButton()
    }

    
    func configureContainerView() {
        containerView.addSubviews(titleLabel, productNameTextField, organizationNameTextField, cancelButton, actionButton)
        
        //TODO: Get keyboard height instead of 300
        //FIX: does not conform to UITextInput protocol
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150 ),
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
        productNameTextField.placeholder = "Название СКЗИ"
        productNameTextField.addTarget(self, action: #selector(updateActionButtonState), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            productNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            productNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            productNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            productNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        productNameTextField.becomeFirstResponder()
    }
    
    
    func configureOrganizationNameTextField() {
        organizationNameTextField.text = organizationName ?? ""
        organizationNameTextField.placeholder = "Организация"
        organizationNameTextField.addTarget(self, action: #selector(updateActionButtonState), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            organizationNameTextField.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 8),
            organizationNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            organizationNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            organizationNameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func updateActionButtonState() {
        guard productNameTextField.text != nil, organizationNameTextField.text != nil else { return }
        
        actionButtonIsActive = !productNameTextField.text!.isEmpty && !organizationNameTextField.text!.isEmpty
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
        
        updateActionButtonState()
    }
    
    
    @objc func saveRequestAndDismissVC() {
        request.set(productName: productNameTextField.text!, organizationName: organizationNameTextField.text!)
        
        PersistenceManager.updateWith(request: self.request, actionType: .add) { error in
            guard error != nil else {
                self.presentCheckmarkAndDismiss()
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func presentCheckmarkAndDismiss() {
        let scView = SuccessCheck(frame: CGRect(x: 40, y: 14, width: 200, height: 200))
        self.containerView.addSubview(scView)
        scView.initWithTime(withDuration: 0.001, bgCcolor: UIColor.green.withAlphaComponent(0), colorOfStroke: UIColor.green.withAlphaComponent(8), widthOfTick: 5) {
            self.dismiss(animated: true, completion: nil)
            //TODO: перейти на SavedRequestsVC вместо ResultsVC
        }
    }
}
