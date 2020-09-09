//
//  Paragraph.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum Paragraph: String, CaseIterable, Codable {
    case p16_1, p16_2, p17_1, p17_2, p17_3, p17_4, p18_1, p18_2, p19_1, p20_1, p21_1, p22_1, p22_2, p22_3
        
    var shortName: String {
        //TODO: Красиво представление Paragraph
        return String(describing: self)
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
}
