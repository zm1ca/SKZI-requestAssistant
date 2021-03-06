//
//  Mechanism.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import UIKit

enum Mechanism: String, CaseIterable, Codable {

    case software       = "СТБ 34.101.27-2011 (класс 1 или 2)"
    case hardware       = "СТБ 34.101.1-2014, СТБ 34.101.2-2014, СТБ 34.101.3-2014"
    case brng           = "СТБ 34.101.27-2011 (п. 5.6) или СТБ 34.101.47-2017 (п. 6.2 или 6.3)"
    case beltModes      = "СТБ 34.101.31-2011 (пп. 6.3 или 6.4 или 6.5)"
    case bignSign       = "СТБ 34.101.45-2013 (п. 7.1)"
    case beltMac        = "СТБ 34.101.31-2011 (п. 6.6)"
    case beltDwp        = "СТБ 34.101.31-2011 (п. 6.7)"
    case beltHash       = "СТБ 34.101.31-2011 (п. 6.9)"
    case bashHash       = "СТБ 34.101.77-2016 (1=128 или 1=192 или 1=256)"
    case beltKeyrep     = "СТБ 34.101.31-2011 (п. 7.2)"
    case bignKeyt       = "СТБ 34.101.45-2013 (п. 7.2)"
    case bignGenkeypair = "СТБ 34.101.45-2013 (п. 6.2)"
    case bignGenk       = "СТБ 34.101.45-2013 (п. 6.3)"
    case brngHmac       = "СТБ 34.101.47-2017 (п. 6.1)"
    case beltKwp        = "СТБ 34.101.45-2013 (приложение Е)"
    case bakeDh         = "СТБ 34.101.66-2014 (приложение А)"
    case bignCurves     = "СТБ 34.101.45-2013 (таблица Б1 или Б2 или БЗ, приложение Д)"
    case belsShare      = "СТБ 34.101.60-2014 (раздел 7, таблица А1)"
    case bpkiContainer  = "СТБ 34.101.78-2019 (раздел 11)"
    case btls           = "СТБ 34.101.65-2014"
    case dheBign        = "СТБ 34.101.65-2014 (п. В.2.5.1)"
    case dhtBign        = "СТБ 34.101.65-2014 (п. B.2.5.2)"
    case dhePskBign     = "СТБ 34.101.65-2014 (п. B.2.5.3)"
    case dhtPskBign     = "СТБ 34.101.65-2014 (п. B.2.5.4)"
    case bakeBsts       = "СТБ 34.101.66-2014 (п. 7.4)"
    case bakeBmqv       = "СТБ 34.101.66-2014 (п. 7.5)"
    case bakeBpace      = "СТБ 34.101.66-2014 (п. 7.6)"
    case btokBpace      = "СТБ 34.101.79-2019 (п. 8.3)"
    case btokBauth      = "СТБ 34.101.79-2019 (п. 8.4)"
    case cryptoki       = "СТБ 34.101.21-2009 (разделы 1-11, 13), СТБ 34.101.78-2019 (раздел 12)"
    case csr            = "СТБ 34.101.17-2012, СТБ 34.101.78-2019 (п. 8.2)"
    case x509           = "СТБ 34.101.19-2012 (разделы 6, 8), СТБ 34.101.78-2019 (п. 8.3)"
    case bpkiRevoke     = "СТБ 34.101.78-2019 (п. 8.4, п. 10.5)"
    case x509Crl        = "СТБ 34.101.19-2012 (раздел 7), СТБ 34.101.78-2019 (п. 8.5)"
    case ocsp           = "СТБ 34.101.26-2012, СТБ 34.101.78-2019 (п. 8.8)"
    case attr           = "СТБ 34.101.67-2014"
    case btokCvc        = "СТБ 34.101.79-2019 (раздел 9)"
    case cmsSigned      = "СТБ 34.101.23-2012 (раздел 8)"
    case cmsEnveloped   = "СТБ 34.101.23-2012 (раздел 9 или 13)"
    case bpkiSigned     = "СТБ 34.101.78-2019 (п. 8.6)"
    case bpkiEnveloped  = "СТБ 34.101.78-2019 (п. 8.7)"
    case ades           = "СТБ 34.101.80-2019 (п. 7.2 или 7.3 или 7.4 или 7.5 или приложение А, п. 8.1 или 8.2, раздел 9 или 10 или 11)"
    case dvcs           = "СТБ 34.101.81-2019, СТБ 34.101.78-2019 (п. 8.10)"
    case tsp            = "СТБ 34.101.82-2019, СТБ 34.101.78-2019 (п. 8.9)"
    case stb1176Sign    = "СТБ 1176.1-99, СТБ 1176.2-99 (разделы 5, 6), СТБ 34.101.50-2019 (приложение В)"

    var shortName: String {
        return String(describing: self)
    }
}
