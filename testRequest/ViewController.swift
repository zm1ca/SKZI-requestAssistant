//
//  ViewController.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 24.08.20.
//

import UIKit

class InitialVC: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var request: [Mechanism] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.append(Mechanism(mechanismTitle: .attr))
    }

    @IBAction func testRequest(_ sender: Any) {
        let result = computeResult(for: request)
        resultLabel.text = result.rawValue
    }
    
    
    func computeResult(for request: [Mechanism]) -> Result {
        let rest = test16_1(for: request)
        if rest.isEmpty {
            return .success
        } else {
            print(rest)
            return .failure
        }
    }
    
    
    func test16_1(for request: [Mechanism]) ->  [Mechanism] {
        return []
    }
}

