//
//  Request.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

struct Request: Codable, Hashable {
    var productName:        String?
    var organizationName:   String?
    
    var mechanisms:         Set<Mechanism>
    var matchingParagraphs: Set<Paragraph>
    
    
    init(named productName: String?, by organization: String?, with mechanisms: Set<Mechanism>) {
        self.productName        = productName
        self.organizationName   = organization
        self.mechanisms         = mechanisms
        self.matchingParagraphs = []
    }
    
    
    mutating func set(productName: String, organizationName: String) {
        self.productName        = productName
        self.organizationName   = organizationName
    }
}
