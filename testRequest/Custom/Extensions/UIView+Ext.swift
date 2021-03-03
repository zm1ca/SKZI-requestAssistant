//
//  UIView+Ext.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
