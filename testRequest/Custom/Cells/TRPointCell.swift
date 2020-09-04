//
//  TRPointCell.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit

class TRPointCell: UITableViewCell {
    
    static let reuseID  = "FavoriteCell"
    
    var testFunc: (([Mechanism]) -> [Mechanism]?)?
    
    func configure(for indexPath: IndexPath, with mechanisms: [Mechanism]) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                testFunc = test16_1(for:)
            case 1:
                testFunc = test16_2(for:)
                
            default:
                testFunc = nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                testFunc = test17_1(for:)
            case 1:
                testFunc = test17_2(for:)
            case 2:
                testFunc = test17_3(for:)
            case 3:
                testFunc = test17_4(for:)
                
            default:
                testFunc = nil
            }
        case 2:
            switch indexPath.row {
            case 0:
                testFunc = test18_1(for:)
            case 1:
                testFunc = test18_2(for:)
                
            default:
                testFunc = nil
            }
        case 3:
            testFunc = test19(for:)
        case 4:
            testFunc = test20(for:)
        case 5:
            testFunc = test21(for:)
        case 6:
            switch indexPath.row {
            case 0:
                testFunc = test22_1(for:)
            case 1:
                testFunc = test22_1(for:)
            case 2:
                testFunc = test22_1(for:)
                
            default:
                testFunc = nil
            }
            
        default:
            return testFunc = nil
        }
        
        guard let testFunc = testFunc else {
            print("No func for \(indexPath)")
            return
        }
        
        self.layer.borderColor  = UIColor.systemGray6.cgColor
        self.layer.borderWidth  = 6
        self.layer.cornerRadius = 15
        #warning("Border pixel bug")
        
        self.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        if let rest = testFunc(mechanisms) {
            self.textLabel?.text = "Failed"
            self.backgroundColor = UIColor.systemRed.withAlphaComponent(0.75)
            print("Rest for \(indexPath) is \(rest)")
        } else {
            self.textLabel?.text = "Passed"
            self.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.75)
        }
    }
}
