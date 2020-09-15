//
//  Paragraph.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum Paragraph: CaseIterable {
    case p16_1
    case p16_2
    case p17_1
    case p17_2
    case p17_3
    case p17_4
    case p18_1
    case p18_2
    case p19_1
    case p20_1
    case p21_1
    case p22_1
    case p22_2
    case p22_3
        
    var shortName: String {
        var latin = String(describing: self)
        latin = latin.replacingOccurrences(of: "_", with: ".")
        latin = latin.replacingOccurrences(of: "p", with: "")
        return latin
    }
    
    
    func neededMechanisms(for mechanisms: Set<Mechanism>) -> Set<Mechanism>? {
        guard let testFunction = self.info.testFunc else { fatalError("Error getting test function") }
        return testFunction(mechanisms)
    }
    
    
    static func getParagraph(for indexPath: IndexPath) -> Paragraph {
        let shortNameForIndexPath = "\(indexPath.section + 16).\(indexPath.row + 1)"
        guard let paragraph = Paragraph.allCases.filter({ $0.shortName == shortNameForIndexPath }).first else {
            fatalError(TRAlertConstants.paragraphError)
        }
        
        return paragraph
    }
    
    
    var info: ParagraphInfo {
        switch self {
        case .p16_1:
            return ParagraphInfo(testFunc: test16_1, details: ParagraphDetails.p16_1, involvedMechanisms: [.beltModes, .beltMac, .brngHmac, .beltDwp, .brng, .software, .hardware, .beltKeyrep, .beltHash, .bignKeyt])
        case .p16_2:
            return ParagraphInfo(testFunc: test16_2, details: ParagraphDetails.p16_2, involvedMechanisms: [.beltModes, .beltMac, .brngHmac, .beltDwp, .brng, .software, .hardware, .bakeBsts, .bakeBmqv, .bignKeyt, .x509, .x509Crl, .ocsp])
        case .p17_1:
            return ParagraphInfo(testFunc: test17_1, details: ParagraphDetails.p17_1, involvedMechanisms: [.beltModes, .beltMac, .brngHmac, .beltDwp, .brng, .software, .hardware, .bakeBpace, .dhePskBign, .beltKeyrep, .beltHash, .bignKeyt])
        case .p17_2:
            return ParagraphInfo(testFunc: test17_2, details: ParagraphDetails.p17_2, involvedMechanisms: [.beltModes, .beltMac, .brngHmac, .beltDwp, .brng, .software, .hardware, .bakeBsts, .bakeBmqv, .bakeDh, .dheBign, .dhtPskBign, .dhtPskBign, .bignKeyt, .x509, .x509Crl, .ocsp])
        case .p17_3:
            return ParagraphInfo(testFunc: test17_3, details: ParagraphDetails.p17_3, involvedMechanisms: [.beltModes, .beltMac, .brngHmac, .beltDwp, .brng, .software, .hardware, .btls])
        case .p17_4:
            return ParagraphInfo(testFunc: test17_4, details: ParagraphDetails.p17_4, involvedMechanisms: [.beltModes, .beltMac, .brngHmac, .beltDwp, .brng, .software, .hardware, .bakeDh, .beltHash, .beltKeyrep, .bignCurves ])
        case .p18_1:
            return ParagraphInfo(testFunc: test18_1, details: ParagraphDetails.p18_1, involvedMechanisms: [.bignSign, .beltHash, .bashHash, .brng, .bignGenk, .software, .bpkiContainer, .beltKwp])
        case .p18_2:
            return ParagraphInfo(testFunc: test18_2, details: ParagraphDetails.p18_2, involvedMechanisms: [.bignSign, .beltHash, .bashHash, .brng, .bignGenk, .hardware])
        case .p19_1:
            return ParagraphInfo(testFunc: test19_1, details: ParagraphDetails.p19_1, involvedMechanisms: [.bignSign, .beltHash, .bashHash, .brng, .hardware, .bakeBpace, .btokBpace, .cryptoki, .bignGenkeypair, .bignGenk, .bignKeyt, .csr, .x509])
        case .p20_1:
            return ParagraphInfo(testFunc: test20_1, details: ParagraphDetails.p20_1, involvedMechanisms: [.bignSign, .beltHash, .bashHash, .hardware, .software, .x509, .x509Crl, .ocsp])
        case .p21_1:
            return ParagraphInfo(testFunc: test21_1, details: ParagraphDetails.p21_1, involvedMechanisms: [.brng, .bignSign, .hardware, .software])
        case .p22_1:
            return ParagraphInfo(testFunc: test22_1, details: ParagraphDetails.p22_1, involvedMechanisms: [.beltHash, .bashHash])
        case .p22_2:
            return ParagraphInfo(testFunc: test22_2, details: ParagraphDetails.p22_2, involvedMechanisms: [.beltMac, .brngHmac, .brng, .beltKeyrep, .beltHash, .hardware, .software])
        case .p22_3:
            return ParagraphInfo(testFunc: test22_3, details: ParagraphDetails.p22_2, involvedMechanisms: [.bignSign, .beltHash, .bashHash, .brng, .hardware, .software, .bignGenk, .bignGenkeypair])
        }
    }
}


struct ParagraphInfo {
    let testFunc: ((Set<Mechanism>) -> Set<Mechanism>?)?
    let details: String
    let involvedMechanisms: [Mechanism]
}
