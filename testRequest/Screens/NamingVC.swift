//
//  NamingVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 10.09.20.
//

import UIKit


protocol TRNamingVCDelegate {
    func resetVCAndTransferToSaved()
}


class NamingVC: UIViewController {
    
    var request: Request!
    
    let containerView             = TRNamingContainer()
    let titleLabel                = TRTitleLabel(textAlignment: .center, fontSize: 20)
    let productNameTextField      = TRTextField()
    let organizationNameTextField = TRTextField()
    let cancelButton              = TRButton(backgroundColor: .tertiarySystemBackground, titleColor: .secondaryLabel)
    let actionButton              = TRButton(backgroundColor: .systemGray4, titleColor: .label)
        
    var productName:        String?
    var organizationName:   String?
    
    var delegate: TRNamingVCDelegate!
    
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
        view.addSubview(containerView)
        
        configureTitleLabel()
        configureProductNameTextField()
        configureOrganizationNameTextField()
        configureCancelButton()
        configureActionButton()
        
        layoutUI()
    }
    

    @objc func saveRequest() {
        request.set(productName: productNameTextField.text!, organizationName: organizationNameTextField.text!)
        
        PersistenceManager.updateWith(request: self.request, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard error != nil else {
                self.indicateSuccessAndDismiss()
                self.delegate.resetVCAndTransferToSaved()
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func indicateSuccessAndDismiss() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        let scView = SuccessCheck(frame: CGRect(x: 40, y: 14, width: 200, height: 200))
        self.containerView.addSubview(scView)
        scView.initWithTime(withDuration: 0.001, bgCcolor: UIColor.green.withAlphaComponent(0), colorOfStroke: UIColor.systemGreen.withAlphaComponent(0.8), widthOfTick: 5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc func updateActionButtonState() {
        guard productNameTextField.text != nil, organizationNameTextField.text != nil else { return }
        actionButtonIsActive = !productNameTextField.text!.isEmpty && !organizationNameTextField.text!.isEmpty
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = "Сохранение заявки"
    }
    
    
    func configureProductNameTextField() {
        containerView.addSubview(productNameTextField)
        
        productNameTextField.text = productName ?? ""
        productNameTextField.placeholder = "Название СКЗИ"
        productNameTextField.addTarget(self, action: #selector(updateActionButtonState), for: .editingChanged)
        productNameTextField.becomeFirstResponder()
    }
    
    
    func configureOrganizationNameTextField() {
        containerView.addSubview(organizationNameTextField)
        
        organizationNameTextField.text = organizationName ?? ""
        organizationNameTextField.placeholder = "Организация"
        organizationNameTextField.addTarget(self, action: #selector(updateActionButtonState), for: .editingChanged)
    }
    
    
    func configureCancelButton() {
        containerView.addSubview(cancelButton)
        
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        
        actionButton.setTitle("Ок", for: .normal)
        actionButton.addTarget(self, action: #selector(saveRequest), for: .touchUpInside)
        updateActionButtonState()
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150 ),
            containerView.heightAnchor.constraint(equalToConstant: 238),
            containerView.widthAnchor.constraint(equalToConstant: 280),
        
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
        
            productNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            productNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            productNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            productNameTextField.heightAnchor.constraint(equalToConstant: 44),

            organizationNameTextField.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 8),
            organizationNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            organizationNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            organizationNameTextField.heightAnchor.constraint(equalToConstant: 44),

            cancelButton.topAnchor.constraint(equalTo: organizationNameTextField.bottomAnchor, constant: padding),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            cancelButton.widthAnchor.constraint(equalToConstant: 115),
            cancelButton.heightAnchor.constraint(equalToConstant: 34),

            actionButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            actionButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 10),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
