//
//  16.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test16_1(for request: Set<Mechanism>) -> Set<Mechanism>? {
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
    guard request.contains(.beltKeyrep) || request.contains(.beltHash) || request.contains(.bignKeyt) else {
        return [.beltKeyrep, .beltHash, .bignKeyt]
    }
    
    return nil
}


func test16_2(for request: Set<Mechanism>) ->  Set<Mechanism>? {
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
    guard request.contains(.bakeBsts) || request.contains(.bakeBmqv) || request.contains(.bignKeyt) else {
        return [.bakeBsts, .bakeBmqv, .bignKeyt]
    }
    
    guard request.contains(.x509) else {
        return [.x509]
    }
    
    guard request.contains(.x509Crl) || request.contains(.ocsp)  else {
        return [.x509Crl, .ocsp]
    }
    
    return nil
}
