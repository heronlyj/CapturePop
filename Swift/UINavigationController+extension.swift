//
//  UINavigationController+extension.swift
//  bag
//
//  Created by lyj on 16/5/16.
//  Copyright © 2016年 Eastern Innovation Technologies Co., Ltd. All rights reserved.
//

import UIKit

protocol PopControlAble {
    func shouldPop(controller controller: UINavigationController) -> Bool
}

extension UINavigationController: UIGestureRecognizerDelegate {
    
    private var originDelegate: String {
        return "originDelegate"
    }

    override public class func initialize() {
        
        if self != UINavigationController.self {
            return
        }
        pop_swizzleAction()
    }
    
    class func pop_swizzleAction() {
        
        struct pop_swizzleToken {
            static var onceToken : dispatch_once_t = 0
        }
        
        dispatch_once(&pop_swizzleToken.onceToken) {
            
            let cls: AnyClass! = UINavigationController.self
            
            let originalSelector = #selector(UINavigationBarDelegate.navigationBar(_:shouldPopItem:))
            let swizzledSelector = #selector(pop_navigationBar(_:shouldPopItem:))
            
            let originalMethod = class_getInstanceMethod(cls, originalSelector)
            let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
            
            let didAddMethod = class_addMethod(
                cls,
                originalSelector,
                method_getImplementation(swizzledMethod),
                method_getTypeEncoding(swizzledMethod)
            )
            
            if didAddMethod {
                class_replaceMethod(
                    cls,
                    swizzledSelector,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod)
                )
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
            
            let originalGestureSelector = #selector(viewWillAppear(_:))
            let swizzledGestureSelector = #selector(pop_viewWillAppear(_:))
            
            let originalGestureMethod = class_getInstanceMethod(cls, originalGestureSelector)
            let swizzledGestureMethod = class_getInstanceMethod(cls, swizzledGestureSelector)
            
            let didAddGestureMethod = class_addMethod(
                cls,
                originalGestureSelector,
                method_getImplementation(swizzledGestureMethod),
                method_getTypeEncoding(swizzledGestureMethod)
            )
            
            if didAddGestureMethod {
                class_replaceMethod(
                    cls,
                    swizzledGestureSelector,
                    method_getImplementation(originalGestureMethod),
                    method_getTypeEncoding(originalGestureMethod)
                )
            } else {
                method_exchangeImplementations(originalGestureMethod, swizzledGestureMethod)
            }
        }
    }
    
    func pop_viewWillAppear(animated: Bool) {
        self.pop_viewWillAppear(animated)
        
        objc_setAssociatedObject(self, originDelegate, self.interactivePopGestureRecognizer, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN);
        
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func pop_navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        
        guard let vc = self.topViewController where item == vc.navigationItem else { return true }
        
        if let popController = vc as? PopControlAble {
            if popController.shouldPop(controller: self) {
                return pop_navigationBar(navigationBar, shouldPopItem: item)
            } else {
                return false
            }
        } else {
            return pop_navigationBar(navigationBar, shouldPopItem: item)
        }

    }
    
    public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let popController = self.topViewController as? PopControlAble
            where gestureRecognizer == self.interactivePopGestureRecognizer {
            return popController.shouldPop(controller: self)
        }
        return true
    }
    
}