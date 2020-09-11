//
//  TRTextField.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 11.09.20.
//

import UIKit

//TODO: does not conform to UITextInput protocol?
class TRTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        keyboardType                = .namePhonePad
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        //clearButtonMode             = .whileEditing
    }
}
