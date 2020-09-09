//
//  TRAlertContainerView.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//


import UIKit

class TRAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 10
        layer.borderWidth     = 2
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
