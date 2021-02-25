//
//  Request.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation


struct Request: Codable, Hashable {

    var declaredMechanisms: [Mechanism] { didSet { dateModified = Date() } }
    var productName:        String { didSet { dateModified = Date() } }
    var organizationName:   String { didSet { dateModified = Date() } }
    var dateModified = Date()
    
    
    var missingMechanisms: [Paragraph: [Mechanism]?] {
        var mechanisms = [Paragraph: [Mechanism]]()
        
        for paragraph in Paragraph.allCases {
            for mechanismsBlock in paragraph.demandedMechanisms {
                if self.contains(anyOf: mechanismsBlock) {
                    continue
                } else {
                    mechanisms[paragraph] = mechanismsBlock
                }
            }
        }
        
        return mechanisms
    }
    
    
    var unusedMechanisms: [Mechanism] {
        var unusedMechanisms = declaredMechanisms
        
        for paragraph in matchingParagraphs {
            for mechanismsBlock in paragraph.demandedMechanisms {
                for mechanism in mechanismsBlock {
                    if let mechanismIndex = unusedMechanisms.firstIndex(of: mechanism) {
                        unusedMechanisms.remove(at: mechanismIndex)
                    }
                }
            }
        }
        
        return unusedMechanisms
    }
    
    
    var matchingParagraphs: [Paragraph] {
        let matchingParagraphs: [Paragraph] = Paragraph.allCases.filter { missingMechanisms[$0] == nil }
        return matchingParagraphs.sorted { $0.shortName < $1.shortName }
    }

    
    init(named productName: String, by organization: String, with mechanisms: [Mechanism]) {
        self.productName        = productName
        self.organizationName   = organization
        self.declaredMechanisms = mechanisms
        self.dateModified       = Date()
    }
    
    
    init() {
        self.init(named: "Draft Product", by: "Draft Org", with: [])
    }
     
    
    private func contains(anyOf mechanisms: [Mechanism]) -> Bool {
        for mechanism in mechanisms {
            if self.declaredMechanisms.contains(mechanism) {
                return true
            }
        }
        return false
    }
}
