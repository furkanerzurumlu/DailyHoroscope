//
//  UIViewController-Extension.swift
//  burcOgren
//
//  Created by Furkan Erzurumlu on 21.05.2023.
//

import Foundation
import UIKit

public enum StoryboardNames: String {
    case main = "Main"
    case homeFlow = "HomeFlow"
}

protocol StoryboardSettings {
    var storyboardName: StoryboardNames { get set }
}


public extension UIViewController {
    /// SwifterSwift: Instantiate UIViewController from storyboard.
    ///
    /// - Parameters:
    ///   - storyboard: Name of the storyboard where the UIViewController is located.
    ///   - bundle: Bundle in which storyboard is located.
    ///   - identifier: UIViewController's storyboard identifier.
    /// - Returns: Custom UIViewController instantiated from storyboard.
    
    class func instantiate(storyboard: StoryboardNames = StoryboardNames.main) -> Self {
        let viewControllerIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }
}
public extension UIViewController {
    
}
