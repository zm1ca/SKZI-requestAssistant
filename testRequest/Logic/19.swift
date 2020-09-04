//
//  19.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test19(for request: [Mechanism]) ->  [Mechanism]? {
    //Требования к криптографическим алгоритмам
    guard request.contains(.bignSign) else {
        return [.bignSign]
    }
    
    guard request.contains(.beltHash) || request.contains(.bashHash) else {
        return [.beltHash, .bashHash]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) else {
        return [.brng]
    }
    
    guard request.contains(.hardware) else {
        return [.hardware]
    }
    
    //Требования к протоколам
    guard request.contains(.bakeBpace) && request.contains(.btokBpace) else {
        return [.bakeBpace, .btokBpace]
    }
    
    guard request.contains(.cryptoki) else {
        return [.cryptoki]
    }
    
    guard request.contains(.bignGenkeypair) && request.contains(.bignGenk) && request.contains(.bignKeyt) else {
        return [.bignGenkeypair, .bignGenk, .bignKeyt]
    }
    
    guard request.contains(.csr) && request.contains(.x509) else {
        return [.csr, .x509]
    }
    
    return nil
}
