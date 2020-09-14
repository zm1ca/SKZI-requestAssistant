//
//  TestsForP20.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test20_1(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    //Требования к криптографическим алгоритмам
    guard request.contains(.bignSign) else {
        return [.bignSign]
    }
    
    guard request.contains(.beltHash) || request.contains(.bashHash) else {
        return [.beltHash, .bashHash]
    }
    
    //Безопасность
    guard request.contains(.hardware) || request.contains(.software) else {
        return [.hardware, .software]
    }
    
    //Требования к протоколам
    guard request.contains(.x509) else {
        return [.x509]
    }
    
    guard request.contains(.x509Crl) || request.contains(.ocsp) else {
        return [.x509Crl, .ocsp]
    }
    
    return nil
}
