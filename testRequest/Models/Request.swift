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
    
    
    init(named productName: String?, by organization: String?, with mechanisms: Set<Mechanism>) {
        self.productName        = productName
        self.organizationName   = organization
        self.mechanisms         = mechanisms
    }
    
    
    mutating func set(productName: String, organizationName: String) {
        self.productName        = productName
        self.organizationName   = organizationName
    }

    
    var results: [Paragraph: Set<Mechanism>] {
        var results = [Paragraph: Set<Mechanism>]()
        for paragraph in Paragraph.allCases {
            results[paragraph] = paragraph.getNeededMechanisms(for: mechanisms)
        }
        
        return results
    }
    
    
    var matchingParagraphs: [Paragraph] {
        var matchingParagraphs: [Paragraph] = []
        for paragraph in Paragraph.allCases {
            if results[paragraph] == nil {
                matchingParagraphs.append(paragraph)
            }
        }
        
        return matchingParagraphs.sorted { $0.shortName < $1.shortName }
    }
}
