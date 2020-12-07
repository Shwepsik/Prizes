//
//  CreatePrizeRouter.swift
//  Prizes
//
//  Created by Valerii on 07.12.2020.
//  Copyright (c) 2020 Valerii. All rights reserved.
//

import UIKit

protocol CreatePrizeRouting {

    func navigateToSomewhere()
    func initialViewController() -> CreatePrizeViewController
}


    final class CreatePrizeRouter {

        // MARK: - Public properties

        weak var viewController: CreatePrizeViewController!
    }

// MARK: - Navigation

extension CreatePrizeRouter: CreatePrizeRouting {    

    func navigateToSomewhere() {

        // NOTE: Teach the router how to navigate to another Module. Some examples follow:

        // 1. Trigger a storyboard segue
        // viewController.performSegueWithIdentifier("PresentOtherModule", sender: nil)

        // 2. Present another view controller programmatically
        // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)

        // 3. Ask the navigation controller to push another view controller onto the stack
        // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)

        // 4. Present a view controller from a different storyboard
        // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
        // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
        // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    }
    
    func initialViewController() -> CreatePrizeViewController {
        // TODO: Instantiate current view controller here like:
        
        // let storyboard = UIStoryboard(name: "StoryboardNameHere", bundle: nil)
        // let controller = storyboard.instantiateViewController(withIdentifier: "ViewControllerNameHere")
        // return controller
        
        return CreatePrizeViewController()
    }
}
