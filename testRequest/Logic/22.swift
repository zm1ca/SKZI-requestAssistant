//
//  22.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test22_1(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    
    guard request.contains(.beltHash) || request.contains(.bashHash) else {
        return [.beltHash, .bashHash]
    }
    
    return nil
}


func test22_2(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    
    guard request.contains(.beltMac) || request.contains(.brngHmac) else {
        return [.beltMac, .brngHmac]
    }
    
    guard request.contains(.brng)  else {
        return [.brng]
    }
    
    guard request.contains(.beltKeyrep) || request.contains(.beltHash) else {
        return [.beltKeyrep, .beltHash]
    }
    
    guard request.contains(.hardware) || request.contains(.software) else {
        return [.hardware, .software]
    }
    
    return nil
}


func test22_3(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    
    guard request.contains(.bignSign) else {
        return [.bignSign]
    }
    
    guard request.contains(.beltHash) || request.contains(.bashHash) else {
        return [.beltHash, .bashHash]
    }
    
    guard request.contains(.brng)  else {
        return [.brng]
    }
    
    guard request.contains(.bignGenkeypair) && request.contains(.bignGenk) else {
        return [.bignGenkeypair, .bignGenk]
    }
    
    guard request.contains(.hardware) || request.contains(.software) else {
        return [.hardware, .software]
    }
    
    return nil
}

