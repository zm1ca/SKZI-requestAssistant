//
//  Request.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

struct Request: Codable, Hashable {
    let productName:        String
    let organizationName:   String
    
    var mechanisms:         Set<Mechanism>
    
    
    init(named productName: String, by organization: String, with mechanisms: [Mechanism]) {
        self.productName        = productName
        self.organizationName   = organization
        self.mechanisms         = Set(mechanisms)
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(productName)
        hasher.combine(organizationName)
    }
}
