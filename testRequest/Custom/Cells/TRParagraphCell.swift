//
//  TRParagraphCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit

class TRParagraphCell: UITableViewCell {
    
    static let reuseID  = "ParagraphCell"
    var testFunc: (([Mechanism]) -> [Mechanism]?)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font                 = UIFont.systemFont(ofSize: 20, weight: .bold)
        detailTextLabel?.textColor      = .secondaryLabel
        detailTextLabel?.numberOfLines  = 2
        
        accessoryType   = .detailButton
        tintColor       = .label
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(title: String, details: String, backgroundColor: UIColor) {
        textLabel?.text         = title
        detailTextLabel?.text   = details
        self.backgroundColor    = backgroundColor
    }
}
