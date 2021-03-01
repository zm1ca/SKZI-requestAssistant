//
//  RequestSavingVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 10.09.20.
//

import UIKit


protocol RequestSavingVCDelegate {
    func resetVCAndTransferToSaved()
}


class RequestSavingVC: UIViewController {
    
    var request: Request? {
        didSet {
            guard let request = request else { return }
            productNameTextField.text = request.productName
            organizationNameTextField.text = request.organizationName
            updateActionButtonState()
        }
    }
    
    var delegate: RequestSavingVCDelegate!
    
    
    //MARK: UI Elements
    
    let containerView = TRNamingContainer()
    
    let titleLabel : TRTitleLabel = {
        let label = TRTitleLabel(textAlignment: .center, fontSize: 20)
        label.text = "Сохранение заявки"
        return label
    }()
    
    let productNameTextField: TRTextField = {
        let tf = TRTextField()
        tf.text = ""
        tf.placeholder = "Название СКЗИ"
        tf.addTarget(self, action: #selector(updateActionButtonState), for: .editingChanged)
        tf.becomeFirstResponder()
        return tf
    }()
    
    let organizationNameTextField: TRTextField = {
        let tf = TRTextField()
        tf.text = ""
        tf.placeholder = "Организация"
        tf.addTarget(self, action: #selector(updateActionButtonState), for: .editingChanged)
        return tf
    }()
    
    var cancelButton = TRButton(
        backgroundColor: .tertiarySystemBackground,
        titleColor: .secondaryLabel,
        title: "Отмена"
    )
    
    var actionButton = TRButton(
        backgroundColor: .systemGray4,
        titleColor: .label,
        title: "Ок"
    )
    
    private var actionButtonIsActive = false {
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

    
    //MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        actionButton.addTarget(self, action: #selector(saveRequest), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        layoutUI()
    }
    

    @objc private func saveRequest() {
        guard let productName = productNameTextField.text, let organizationName = organizationNameTextField.text, request != nil else { return }
        
        request!.productName = productName
        request!.organizationName = organizationName
        
        PersistenceManager.updateWith(request: request!, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard error != nil else {
                self.indicateSuccessAndDismiss()
                self.delegate.resetVCAndTransferToSaved()
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    private func indicateSuccessAndDismiss() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        let scView = SuccessCheck(frame: CGRect(x: 40, y: 14, width: 200, height: 200))
        self.containerView.addSubview(scView)
        scView.initWithTime(withDuration: 0.005, bgCcolor: UIColor.green.withAlphaComponent(0), colorOfStroke: UIColor.systemGreen.withAlphaComponent(0.8), widthOfTick: 5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc private func updateActionButtonState() {
        guard productNameTextField.text != nil, organizationNameTextField.text != nil else { return }
        actionButtonIsActive = !productNameTextField.text!.isEmpty && !organizationNameTextField.text!.isEmpty
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //TODO: Consider SnapKit
    private func layoutUI() {
        let padding: CGFloat = 20
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(productNameTextField)
        containerView.addSubview(organizationNameTextField)
        containerView.addSubview(cancelButton)
        containerView.addSubview(actionButton)
        
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
