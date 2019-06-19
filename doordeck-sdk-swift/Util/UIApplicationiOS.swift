//
//  UIApplicationiOS.swift
//  doordeck-sdk-swift
//
//  Copyright © 2019 Doordeck. All rights reserved.
//

import UIKit

extension UIApplication {
    class func returnKeyWindowRoot () -> UIViewController?  {
        if #available(iOS 10, *) {
            #if WIDGET
            return nil
            #elseif WATCH
            return nil
            #else
            return UIApplication.shared.keyWindow?.rootViewController
            #endif
        } else {
            return nil
        }
    }
    
    class func topViewController(_ base: UIViewController? = UIApplication.returnKeyWindowRoot()) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController , top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
    
    class func returnRootNavigationController () -> UINavigationController? {
        return UIApplication.returnKeyWindowRoot() as? UINavigationController
    }
    
    class func returnRootofNavigationController (_ base: UIViewController? =
        UIApplication.returnKeyWindowRoot()) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.children.first)
        }
        return base
    }
    
    class func returnViewControllerFromStoryboard (storyBoard: String, storyboardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: storyboardID)
        return controller
    }
}


