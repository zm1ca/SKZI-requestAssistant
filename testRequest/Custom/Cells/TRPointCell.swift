//
//  TRPointCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit

class TRPointCell: UITableViewCell {
    
    static let reuseID  = "PointCell"
    var testFunc: (([Mechanism]) -> [Mechanism]?)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font                 = UIFont.systemFont(ofSize: 20, weight: .bold)
        detailTextLabel?.textColor      = .secondaryLabel
        detailTextLabel?.numberOfLines  = 2
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(for indexPath: IndexPath, with mechanisms: [Mechanism]) {
        guard let testFunc = getTestFunction(for: indexPath) else { return }
        
        if let restMechanisms = testFunc(mechanisms) {
            textLabel?.text         = "Не соответствует"
            detailTextLabel?.text   = restMechanisms.reduce("Добавьте что-то из:", { $0 + " " + $1.shortName })
            
            backgroundColor         = UIColor.systemRed.withAlphaComponent(0.75)
        } else {
            textLabel?.text         = "Соответствует"
            detailTextLabel?.text   = ""
            backgroundColor         = UIColor.systemGreen.withAlphaComponent(0.75)
        }
    }
    
    
    //ToDo: -- Refactor
    func getTestFunction(for indexPath: IndexPath) -> (([Mechanism]) -> [Mechanism]?)? {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return test16_1(for:)
            case 1:
                return test16_2(for:)
                
            default:
                return nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                return test17_1(for:)
            case 1:
                return test17_2(for:)
            case 2:
                return test17_3(for:)
            case 3:
                return test17_4(for:)
                
            default:
                return nil
            }
        case 2:
            switch indexPath.row {
            case 0:
                return test18_1(for:)
            case 1:
                return test18_2(for:)
                
            default:
                return nil
            }
        case 3:
            return test19(for:)
        case 4:
            return test20(for:)
        case 5:
            return test21(for:)
        case 6:
            switch indexPath.row {
            case 0:
                return test22_1(for:)
            case 1:
                return test22_1(for:)
            case 2:
                return test22_1(for:)
                
            default:
                return nil
            }
            
        default:
            return nil
        }
    }
}
