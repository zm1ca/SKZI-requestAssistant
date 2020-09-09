//
//  21.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test21_1(for request: Set<Mechanism>) ->  Set<Mechanism>? {
    //ГСЧ и Безопасность
    guard request.contains(.brng) || request.contains(.bignGenkeypair) else {
        return [.brng, .bignSign]
    }
    
    guard request.contains(.hardware) || request.contains(.software) else {
        return [.hardware, .software]
    }
    
    return nil
}
