//
//  UITabBarController.swift
//  Dicey
//
//  Created by Matthew Dias on 1/25/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit.UITabBarController

extension UITabBarController {
    
    func setTabBar(hidden: Bool) {
        guard isTabBarHidden != hidden else { return }
        
        let offsetY = hidden ? tabBar.frame.height : -tabBar.frame.height
        let endFrame = tabBar.frame.offsetBy(dx: 0, dy: offsetY)
        let cvc: UIViewController? = viewControllers?[selectedIndex]
        var newInsets = cvc?.additionalSafeAreaInsets
        
        weak var tabBarRef = self.tabBar
        UIView.animate(withDuration: 0.1, animations: {
            
        }, completion: { isFinished in
            let height: CGFloat = offsetY + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0)

            newInsets?.bottom -= height
            cvc?.additionalSafeAreaInsets = newInsets!
            
            if isFinished {
                UIView.animate(withDuration: 0.2, animations: {
                    tabBarRef?.frame = endFrame
                }, completion: nil)
            }
        })
    }
    
    var isTabBarHidden: Bool {
        return !tabBar.frame.intersects(view.frame)
    }
}
