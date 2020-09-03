//
//  Choice.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

struct Choice {
    let toggle: UISwitch
    let mechanism: Mechanism
    
    var label: UILabel {
        let label = UILabel()
        label.text = "\(mechanism)"
        return label
    }
    
    
    init(mechanism: Mechanism) {
        toggle          = UISwitch()
        self.mechanism  = mechanism
    }
}
