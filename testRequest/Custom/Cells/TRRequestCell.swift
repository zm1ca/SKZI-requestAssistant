//
//  TRRequestCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit

class TRRequestCell: UITableViewCell {
    
    static let reuseID  = "RequestCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(for request: Request) {
        textLabel?.text = "\(request.productName) by \(request.organizationName)"
        #warning("Пункты приказа вместо механизмов")
        detailTextLabel?.text = request.mechanisms.reduce("", { $0 + " " + $1.shortName })
        accessoryType = .disclosureIndicator
    }
}
