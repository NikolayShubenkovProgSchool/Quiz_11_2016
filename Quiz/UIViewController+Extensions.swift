//
//  UIViewController+Extensions.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 03/12/2016.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var isOnScreen:Bool {
        return isViewLoaded && view.window != nil
    }
    
}
