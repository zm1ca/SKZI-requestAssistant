//
//  Request.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation


struct Request: Codable, Hashable {
    
    var mechanisms:         Set<Mechanism>
    var productName:        String?
    var organizationName:   String?
    var dateModified:       Date!
    
    
    init(named productName: String?, by organization: String?, with mechanisms: Set<Mechanism>) {
        self.productName        = productName
        self.organizationName   = organization
        self.mechanisms         = mechanisms
        self.dateModified       = Date()
    }
    
    
    mutating func set(productName: String, organizationName: String) {
        self.productName        = productName
        self.organizationName   = organizationName
        self.dateModified       = Date()
    }

    
    var results: [Paragraph: Set<Mechanism>?] {
        var results = [Paragraph: Set<Mechanism>]()
        for paragraph in Paragraph.allCases {
            results[paragraph] = paragraph.neededMechanisms(for: mechanisms)
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
    
    
    var unusedMechanisms: Set<Mechanism> {
        var unusedMechanisms = mechanisms
        
        for paragraph in Paragraph.allCases.filter({ results[$0] == nil }) {
            for involvedMechanism in paragraph.info.involvedMechanisms {
                unusedMechanisms.remove(involvedMechanism)
            }
        }
        
        return unusedMechanisms
    }
}
