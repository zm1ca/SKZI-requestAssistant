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
        self.viewControllers = [createMechanismPickerNC(), createRequestCreatorNC(), createSavedRequestsNC()]
    }
    
    //TODO: Make good TabBarItems
    //MARK: titles don't work fine here
    
    
    func createMechanismPickerNC() -> UINavigationController {
        let testRequestVC = MechanismPickerVC()
        testRequestVC.tabBarItem = UITabBarItem(title: "Проверить", image: .strokedCheckmark, tag: 0)
        
        return UINavigationController(rootViewController: testRequestVC)
    }
    

    func createRequestCreatorNC() -> UINavigationController {
        let makeRequestVC = RequestCreatorVC()
        makeRequestVC.tabBarItem = UITabBarItem(title: "Составление", image: .add, tag: 1)

        return UINavigationController(rootViewController: makeRequestVC)
    }
    
    
    func createSavedRequestsNC() -> UINavigationController {
        let listVC = SavedRequestsVC()
        listVC.tabBarItem = UITabBarItem(title: "Сохраненные", image: .actions, tag: 2)

        return UINavigationController(rootViewController: listVC)
    }
}
