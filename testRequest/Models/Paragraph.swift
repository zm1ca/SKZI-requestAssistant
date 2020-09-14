//
//  Paragraph.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum Paragraph: String, CaseIterable, Codable {
    case p16_1 = "16.1"
    case p16_2 = "16.2"
    case p17_1 = "17.1"
    case p17_2 = "17.2"
    case p17_3 = "17.3"
    case p17_4 = "17.4"
    case p18_1 = "18.1"
    case p18_2 = "18.2"
    case p19_1 = "19"
    case p20_1 = "20"
    case p21_1 = "21"
    case p22_1 = "22.1"
    case p22_2 = "22.2"
    case p22_3 = "22.3"
        
    var shortName: String {
        var latin = String(describing: self)
        latin = latin.replacingOccurrences(of: "_", with: ".")
        latin = latin.replacingOccurrences(of: "p", with: "")
        return latin
    }
    
    func getNeededMechanisms(for mechanisms: Set<Mechanism>) -> Set<Mechanism>? {
        guard let testFunction = self.getTestFunction else { fatalError("Error getting test function") }
        return testFunction(mechanisms)
    }
    
    var getTestFunction: ((Set<Mechanism>) -> Set<Mechanism>?)? {
        switch self {
        case .p16_1:
            return test16_1
        case .p16_2:
            return test16_2
        case .p17_1:
            return test17_1
        case .p17_2:
            return test17_2
        case .p17_3:
            return test17_3
        case .p17_4:
            return test17_4
        case .p18_1:
            return test18_1
        case .p18_2:
            return test18_2
        case .p19_1:
            return test19_1
        case .p20_1:
            return test20_1
        case .p21_1:
            return test21_1
        case .p22_1:
            return test22_1
        case .p22_2:
            return test22_2
        case .p22_3:
            return test22_3
        }
    }
    
    
    static func getParagraph(for indexPath: IndexPath) -> Paragraph {
        let shortNameForIndexPath = "\(indexPath.section + 16).\(indexPath.row + 1)"
        guard let paragraph = Paragraph.allCases.filter({ $0.shortName == shortNameForIndexPath }).first else {
            fatalError(TRAlertConstants.paragraphError)
        }
        
        return paragraph
    }
}
