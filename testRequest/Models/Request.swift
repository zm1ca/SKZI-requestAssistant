//
//  Request.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import Foundation

struct Request: Codable, Hashable {

    var declaredMechanisms: [Mechanism] { didSet { dateModified = Date() } }
    var productName: String { didSet { dateModified = Date() } }
    var organizationName: String { didSet { dateModified = Date() } }
    var dateModified = Date()

    init(named productName: String, by organization: String, with mechanisms: [Mechanism]) {
        self.productName        = productName
        self.organizationName   = organization
        self.declaredMechanisms = mechanisms
        self.dateModified       = Date()
    }

    init() {
        self.init(named: "", by: "", with: [])
    }

    func contains(anyOf mechanisms: [Mechanism]) -> Bool {
        for mechanism in mechanisms {
            if self.declaredMechanisms.contains(mechanism) {
                return true
            }
        }
        return false
    }
}
