//
//  18.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test18_1(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    //Требования к криптографическим алгоритмам
    guard request.contains(.bignSign) else {
        return [.bignSign]
    }
    
    guard request.contains(.beltHash) || request.contains(.bashHash) else {
        return [.beltHash, .bashHash]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) || request.contains(.bignGenk) else {
        return [.brng, .bignGenk]
    }
    
    guard request.contains(.software) else {
        return [.software]
    }
    
    //Требования к криптографическим протоколам
    guard request.contains(.bpkiContainer) else {
        return [.bpkiContainer]
    }
    
    guard request.contains(.beltKwp) else {
        return [.beltKwp]
    }
    
    return nil
}


func test18_2(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    //Требования к криптографическим алгоритмам
    guard request.contains(.bignSign) else {
        return [.bignSign]
    }
    
    guard request.contains(.beltHash) || request.contains(.bashHash) else {
        return [.beltHash, .bashHash]
    }
    
    //Генератор случайных чисел и безопасность
    guard request.contains(.brng) || request.contains(.bignGenk) else {
        return [.brng, .bignGenk]
    }
    
    guard request.contains(.hardware) else {
        return [.hardware]
    }
    
    return nil
}
