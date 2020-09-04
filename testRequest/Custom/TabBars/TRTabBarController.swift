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
        testRequestVC.title = "Проверка заявки"
        testRequestVC.tabBarItem = UITabBarItem(title: "Проверить", image: .strokedCheckmark, tag: 0)
        
        return UINavigationController(rootViewController: testRequestVC)
    }
    

    func createMakeRequestNC() -> UINavigationController {
        let makeRequestVC = MakeRequestVC()
        makeRequestVC.title = "Составление заявки"
        makeRequestVC.tabBarItem = UITabBarItem(title: "Составить", image: .add, tag: 1)

        return UINavigationController(rootViewController: makeRequestVC)
    }
    
    
    func createListVC() -> UINavigationController {
        let listVC = ListVC()
        listVC.title = "История"
        listVC.tabBarItem = UITabBarItem(title: "История", image: .actions, tag: 2)

        return UINavigationController(rootViewController: listVC)
    }
}
