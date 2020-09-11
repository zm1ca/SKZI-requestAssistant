//
//  TRRequestCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit

class TRRequestCell: UITableViewCell {
    
    static let reuseID  = "RequestCell"
    let nameLabel = TRTitleLabel(textAlignment: .left, fontSize: 18)
    let paragraphsLabel = TRBodyLabel(textAlignment: .left, font: UIFont.preferredFont(forTextStyle: .footnote))
    let dateModifiedLabel = TRBodyLabel(textAlignment: .right, font: UIFont.preferredFont(forTextStyle: .caption2))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        let views = [nameLabel, paragraphsLabel, dateModifiedLabel]
        for view in views {
            addSubview(view)
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            ])
        }
        
        addSubviews(nameLabel, paragraphsLabel, dateModifiedLabel)
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            dateModifiedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            dateModifiedLabel.heightAnchor.constraint(equalToConstant: 14),
            
            paragraphsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            paragraphsLabel.bottomAnchor.constraint(equalTo: dateModifiedLabel.topAnchor, constant: -5)
        ])
    }
    
    
    func set(for request: Request) {
        dateModifiedLabel.text = dateString(from: request.dateModified)
        nameLabel.text = "\(request.productName!) от «\(request.organizationName!)»"
        paragraphsLabel.text = !request.matchingParagraphs.isEmpty ?
            String(request.matchingParagraphs.reduce("Соответствует:", { $0 + " " + $1.shortName + "," }).dropLast()) :
            "Не соответствует приказу №77 ОАЦ."
    }
    
    
    func dateString(from date: Date) -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.locale     = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
