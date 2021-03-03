//
//  TRButton.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit

class TRButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    convenience init(backgroundColor: UIColor, titleColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
    }
}
