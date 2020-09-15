//
//  TRTabBarController.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 3.09.20.
//

import UIKit

class TRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createMechanismPickerNC(), createSavedRequestsNC()]
    }

    
    func createMechanismPickerNC() -> UINavigationController {
        let mechanismPickerVC = MechanismPickerVC()
        mechanismPickerVC.tabBarItem = UITabBarItem(title: "Проверить", image: UIImage(named: "check")!, tag: 0)
        
        return UINavigationController(rootViewController: mechanismPickerVC)
    }
    

//    func createRequestCreatorNC() -> UINavigationController {
//        let requestCreatorVC = RequestCreatorVC()
//        requestCreatorVC.tabBarItem = UITabBarItem(title: "Составление", image: UIImage(named: "create")!, tag: 1)
//
//        return UINavigationController(rootViewController: requestCreatorVC)
//    }
    
    
    func createSavedRequestsNC() -> UINavigationController {
        let savedRequestsVC = SavedRequestsVC()
        savedRequestsVC.tabBarItem = UITabBarItem(title: "Сохраненные", image: UIImage(named: "saved")!, tag: 1)

        return UINavigationController(rootViewController: savedRequestsVC)
    }
}
