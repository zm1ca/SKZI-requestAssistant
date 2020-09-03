//
//  TRTabBarController.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createTestRequestNC(), createMakeRequestNC(), createListVC()]
    }
    
    
    func createTestRequestNC() -> UINavigationController {
        let testRequestVC = TestRequestVC()
        testRequestVC.title = "Test request"
        testRequestVC.tabBarItem = UITabBarItem(title: "Test", image: .strokedCheckmark, tag: 0)
        
        return UINavigationController(rootViewController: testRequestVC)
    }
    

    func createMakeRequestNC() -> UINavigationController {
        let makeRequestVC = MakeRequestVC()
        makeRequestVC.title = "Make request"
        makeRequestVC.tabBarItem = UITabBarItem(title: "Make", image: .add, tag: 1)
        
        return UINavigationController(rootViewController: makeRequestVC)
    }
    
    
    func createListVC() -> UINavigationController {
        let listVC = ListVC()
        listVC.title = "My requests"
        listVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        return UINavigationController(rootViewController: listVC)
    }
}
