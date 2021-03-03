//
//  RequestSavingVC.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 10.09.20.
//

import UIKit
import SnapKit

protocol RequestSavingVCDelegate: class {
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

    weak var delegate: RequestSavingVCDelegate!

    // MARK: UI Elements

    let containerView = TRNamingContainer()

    let titleLabel: TRTitleLabel = {
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

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        actionButton.addTarget(self, action: #selector(saveRequest), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        layoutUI()
    }

    @objc private func saveRequest() {
        guard let productName = productNameTextField.text,
              let organizationName = organizationNameTextField.text,
              request != nil
        else { return }

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
        scView.initWithTime(
            withDuration: 0.005,
            bgCcolor: UIColor.green.withAlphaComponent(0),
            colorOfStroke: UIColor.systemGreen.withAlphaComponent(0.8),
            widthOfTick: 5
        ) { self.dismiss(animated: true, completion: nil) }
    }

    @objc private func updateActionButtonState() {
        guard productNameTextField.text != nil, organizationNameTextField.text != nil else { return }
        actionButtonIsActive = !productNameTextField.text!.isEmpty && !organizationNameTextField.text!.isEmpty
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

    private func layoutUI() {
        let padding: CGFloat = 20

        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, productNameTextField, organizationNameTextField, cancelButton, actionButton)

        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(150)
            make.height.equalTo(238)
            make.width.equalTo(280)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }

        productNameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(44)
        }

        organizationNameTextField.snp.makeConstraints { make in
            make.top.equalTo(productNameTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(44)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(organizationNameTextField.snp.bottom).offset(padding)
            make.leading.equalToSuperview().inset(padding)
            make.width.equalTo(115)
            make.height.equalTo(34)
        }

        actionButton.snp.makeConstraints { make in
            make.centerY.equalTo(cancelButton.snp.centerY)
            make.leading.equalTo(cancelButton.snp.trailing).inset(10)
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(34)
        }
    }
}
