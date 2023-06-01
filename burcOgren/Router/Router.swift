//
//  Router.swift
//  burcOgren
//
//  Created by Furkan Erzurumlu on 21.05.2023.
//

import Foundation
import UIKit

final class Router{
    static var shared: Router = Router()
    
    func showHomeFlow(navigationController: UINavigationController?){
        let homeFlowVC = HomeFlow.instantiate(storyboard: .homeFlow)
        navigationController?.pushViewController(homeFlowVC, animated: true)
    }
}
