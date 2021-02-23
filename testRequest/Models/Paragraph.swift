//
//  Paragraph.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

enum Paragraph: String, CaseIterable {
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
        var name = String(describing: self)
        name = name.replacingOccurrences(of: "_", with: ".")
        name = name.replacingOccurrences(of: "p", with: "")
        return name
    }    
    
    //FIX: Review func (it might be moved to ViewModel)
    static func getParagraph(for indexPath: IndexPath) -> Paragraph {
        let shortNameForIndexPath = "\(indexPath.section + 16).\(indexPath.row + 1)"
        guard let paragraph = Paragraph.allCases.filter({ $0.shortName == shortNameForIndexPath }).first else {
            fatalError(TRErrorVerbouseConstants.paragraphError)
        }
        
        return paragraph
    }
     
    var demandedMechanisms: [[Mechanism]] {
        switch self {
        case .p16_1:
            return [
                [.beltModes],
                [.beltMac, .brngHmac, .beltDwp],
                [.brng],
                [.software, .hardware],
                [.beltKeyrep, .beltHash, .bignKeyt]
            ]
        case .p16_2:
            return [
                [.beltModes],
                [.beltMac, .brngHmac, .beltDwp],
                [.brng],
                [.software, .hardware],
                [.bakeBsts, .bakeBmqv, .bignKeyt],
                [.x509],
                [.x509Crl, .ocsp]
            ]
        case .p17_1:
            return [
                [.beltModes],
                [.beltMac, .brngHmac, .beltDwp],
                [.brng],
                [.software, .hardware],
                [.bakeBpace, .dhePskBign, .beltKeyrep, .beltHash, .bignKeyt]
            ]
        case .p17_2:
            return [
                [.beltModes],
                [.beltMac, .brngHmac, .beltDwp],
                [.brng],
                [.software, .hardware],
                [.bakeBsts, .bakeBmqv, .bakeDh, .dheBign, .dhtPskBign, .dhtPskBign, .bignKeyt],
                [.x509],
                [.x509Crl, .ocsp]
            ]
        case .p17_3:
            return [
                [.beltModes],
                [.beltMac, .brngHmac, .beltDwp],
                [.brng],
                [.software, .hardware],
                [.btls]
            ]
        case .p17_4:
            return [
                [.beltModes],
                [.beltMac, .brngHmac, .beltDwp],
                [.brng],
                [.software, .hardware],
                [.bakeDh],
                [.beltHash, .beltKeyrep],
                [.bignCurves]
            ]
        case .p18_1:
            return [
                [.bignSign],
                [.beltHash, .bashHash],
                [.brng, .bignGenk],
                [.software],
                [.bpkiContainer],
                [.beltKwp]
            ]
        case .p18_2:
            return [
                [.bignSign],
                [.beltHash, .bashHash],
                [.brng, .bignGenk],
                [.hardware]
            ]
        case .p19_1:
            return [
                [.bignSign],
                [.beltHash, .bashHash],
                [.brng, .bignGenk],
                [.hardware],
                [.bakeBpace],
                [.btokBpace],
                [.cryptoki],
                [.bignGenkeypair, .bignGenk, .bignKeyt],
                [.csr, .x509]
            ]
        case .p20_1:
            return [
                [.bignSign],
                [.beltHash, .bashHash],
                [.hardware, .software],
                [.x509],
                [.x509Crl, .ocsp]
            ]
        case .p21_1:
            return [
                [.brng, .bignGenkeypair],
                [.hardware, .software]
            ]
        case .p22_1:
            return [
                [.beltHash, .bashHash]
            ]
        case .p22_2:
            return [
                [.beltMac, .brngHmac],
                [.brng],
                [.beltKeyrep, .beltHash],
                [.hardware, .software]
            ]
        case .p22_3:
            return [
                [.bignSign],
                [.beltHash, .bashHash],
                [.brng],
                [.bignGenkeypair],
                [.bignGenk],
                [.hardware, .software]
            ]
        }
    }
}
