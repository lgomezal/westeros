//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by luis gomez alonso on 13/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
