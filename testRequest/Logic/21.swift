//
//  21.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import Foundation

func test21(for request: [Mechanism]) ->  [Mechanism]? {
    //ГСЧ и Безопасность
    guard request.contains(.brng) || request.contains(.bignGenkeypair) else {
        return [.brng, .bignSign]
    }
    
    guard request.contains(.hardware) || request.contains(.software) else {
        return [.hardware, .software]
    }
    
    return nil
}
