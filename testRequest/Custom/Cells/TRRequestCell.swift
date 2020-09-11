//
//  TRRequestCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit

class TRRequestCell: UITableViewCell {
    //TODO: Исправить ячейку для заявки
    static let reuseID  = "RequestCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(for request: Request) {
        textLabel?.text = "\(request.productName!) by \(request.organizationName!)"

        if !request.matchingParagraphs.isEmpty {
            detailTextLabel?.text = request.matchingParagraphs.reduce("Соответствует:", { $0 + " " + $1.shortName })
        } else {
            detailTextLabel?.text = "Не соответствует приказу №77 ОАЦ."
        }
        
        accessoryType = .disclosureIndicator
    }
}
