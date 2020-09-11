//
//  TRBodyLabel.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit

class TRBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
    }
    
    
    convenience init(textAlignment: NSTextAlignment, font: UIFont) {
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.font           = font
    }
    
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory   = true
        textColor                           = .secondaryLabel
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.85
        lineBreakMode                       = .byTruncatingTail

        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
