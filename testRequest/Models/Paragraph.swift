//
//  Paragraph.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum Paragraph: String, CaseIterable, Codable {
    case p16_1 = "Для СКЗИ применяющих предварительное распределение ключей."
    case p16_2 = "Для СКЗИ в которых доверие к ключам шифрования устанавливается посредством ЭЦП."
    case p17_1 = "Для линейных шифраторов с предварительным распределением секретов."
    case p17_2 = "Для линейных шифраторов с протоколом Диффи-Хеллмана усиленным ЭЦП."
    case p17_3 = "Для линейных шифраторов реализующих протокол TLS."
    case p17_4 = "Для линейных шифраторов применяющих альтернативное усиление протокола Диффи-Хеллмана."
    case p18_1 = "Для программных средств выработки ЭЦП."
    case p18_2 = "Для аппаратных средств выработки ЭЦП."
    case p19_1 = "Для защищённого аппаратного хранилища личного ключа."
    case p20_1 = "Для СКЗИ осуществляющих проверку ЭЦП."
    case p21_1 = "Для СКЗИ осуществляющих выработку личных и открытых ключей ЭЦП."
    case p22_1 = "Для контроля целостности с помощью бесключевых хэш-функций."
    case p22_2 = "Для контроля целостности с помощью ключевых хэш-функций"
    case p22_3 = "Для контроля целостности с помощью ЭЦП."
        
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
