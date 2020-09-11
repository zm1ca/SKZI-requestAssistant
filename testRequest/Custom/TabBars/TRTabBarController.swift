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
    
    //TODO: Make good TabBarItems
    //MARK: titles don't work fine here
    
    
    func createTestRequestNC() -> UINavigationController {
        let testRequestVC = MechanismPickerVC()
        testRequestVC.tabBarItem = UITabBarItem(title: "Проверить", image: .strokedCheckmark, tag: 0)
        
        return UINavigationController(rootViewController: testRequestVC)
    }
    

    func createMakeRequestNC() -> UINavigationController {
        let makeRequestVC = RequestCreatorVC()
        makeRequestVC.tabBarItem = UITabBarItem(title: "Составление", image: .add, tag: 1)

        return UINavigationController(rootViewController: makeRequestVC)
    }
    
    
    func createListVC() -> UINavigationController {
        let listVC = SavedRequestsVC()
        listVC.tabBarItem = UITabBarItem(title: "История", image: .actions, tag: 2)

        return UINavigationController(rootViewController: listVC)
    }
}
