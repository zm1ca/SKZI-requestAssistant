//
//  17.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test17_1(for request: [Mechanism]) ->  [Mechanism] {
    //Требования к криптографическим алгоритмам
    guard request.contains(.beltModes) else {
        return [.beltModes]
    }
    
    guard request.contains(.beltMac) || request.contains(.brngHmac) || request.contains(.beltDwp) else {
        return [.beltMac, .brngHmac, .beltDwp]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) else {
        return [.brng]
    }
    
    guard request.contains(.software) || request.contains(.hardware) else {
        return [.software, .hardware]
    }
    
    //Требования к криптографическим протоколам
    guard request.contains(.bakeBpace) || request.contains(.dhePskBign) || request.contains(.beltKeyrep) || request.contains(.bignKeyt) else {
        return [.bakeBpace, .dhePskBign, .beltKeyrep, .bignKeyt]
    }
    
    return []
}


func test17_2(for request: [Mechanism]) ->  [Mechanism] {
    //Требования к криптографическим алгоритмам
    guard request.contains(.beltModes) else {
        return [.beltModes]
    }
    
    guard request.contains(.beltMac) || request.contains(.brngHmac) || request.contains(.beltDwp) else {
        return [.beltMac, .brngHmac, .beltDwp]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) else {
        return [.brng]
    }
    
    guard request.contains(.software) || request.contains(.hardware) else {
        return [.software, .hardware]
    }
    
    //Требования к криптографическим протоколам
    guard request.contains(.bakeBsts) || request.contains(.bakeBmqv) || request.contains(.bakeDh) || request.contains(.dheBign) || request.contains(.dhtBign) || request.contains(.dhtPskBign) || request.contains(.bignKeyt) else {
        return [.bakeBsts, .bakeBmqv, .bakeDh, .dheBign, .dhtPskBign, .dhtPskBign, .bignKeyt]
    }
    
    guard request.contains(.x509) else {
        return [.x509]
    }
    
    guard request.contains(.x509Crl) || request.contains(.ocsp) else {
        return [.x509Crl, .ocsp]
    }
    
    return []
}


func test17_3(for request: [Mechanism]) ->  [Mechanism] {
    //Требования к криптографическим алгоритмам
    guard request.contains(.beltModes) else {
        return [.beltModes]
    }
    
    guard request.contains(.beltMac) || request.contains(.brngHmac) || request.contains(.beltDwp) else {
        return [.beltMac, .brngHmac, .beltDwp]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) else {
        return [.brng]
    }
    
    guard request.contains(.software) || request.contains(.hardware) else {
        return [.software, .hardware]
    }
    
    //Требования к криптографическим протоколам
    guard request.contains(.btls) else {
        return [.btls]
    }
    
    return []
}


func test17_4(for request: [Mechanism]) ->  [Mechanism] {
    //Требования к криптографическим алгоритмам
    guard request.contains(.beltModes) else {
        return [.beltModes]
    }
    
    guard request.contains(.beltMac) || request.contains(.brngHmac) || request.contains(.beltDwp) else {
        return [.beltMac, .brngHmac, .beltDwp]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) else {
        return [.brng]
    }
    
    guard request.contains(.software) || request.contains(.hardware) else {
        return [.software, .hardware]
    }
    
    //Требования к криптографическим протоколам
    guard request.contains(.bakeDh) else {
        return [.bakeDh]
    }
    
    guard request.contains(.beltKeyrep) else {
        return [.beltKeyrep]
    }
    
    guard request.contains(.bignCurves) else {
        return [.bignCurves]
    }
    
    return []
}
