//
//  TRMechanismCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit

class TRMechanismCell: UITableViewCell {
    
    static let reuseID  = "MechanismCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.font                             = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        detailTextLabel?.font                       = UIFont.systemFont(ofSize: 12, weight: .light)
        detailTextLabel?.numberOfLines              = 2
        detailTextLabel?.textColor                  = .secondaryLabel
        detailTextLabel?.adjustsFontSizeToFitWidth  = true
        detailTextLabel?.minimumScaleFactor         = 0.8
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(for mechanism: Mechanism) {
        textLabel?.text         = String(describing: mechanism)
        detailTextLabel?.text   = mechanism.rawValue
    }
}
