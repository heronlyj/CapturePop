////
////  UINavigationController+ShouldPopExtension.m
////  CapturePopAction
////
////  Created by lyj on 9/5/16.
////  Copyright © 2016 heronlyj. All rights reserved.
////
//
//#import "UINavigationController+BagShouldPopExtension.h"
//#import <objc/runtime.h>
//
//static NSString *const kOriginDelegate = @"kOriginDelegate";
//@implementation UINavigationController (BagShouldPopExtension)
//
//+ (void)load {
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//       
//        Class class = [self class];
//        
//        
//        {
//            SEL originalSelector = @selector(navigationBar:shouldPopItem:);
//            SEL swizzledSelector = @selector(bag_navigationBar:shouldPopItem:);
//            
//            Method originalMethod = class_getInstanceMethod(class, originalSelector);
//            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//            
//            BOOL didAddMethod = class_addMethod(class,
//                                                originalSelector,
//                                                method_getImplementation(swizzledMethod),
//                                                method_getTypeEncoding(swizzledMethod));
//            
//            if (didAddMethod) {
//                class_replaceMethod(class,
//                                    swizzledSelector,
//                                    method_getImplementation(originalMethod),
//                                    method_getTypeEncoding(originalMethod));
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod);
//            }
//        }
//        
//        
//        {
//            
//            SEL originalGestureSelector = @selector(viewWillAppear:);
//            SEL swizzledGestureSelector = @selector(bag_viewWillAppear:);
//            
//            Method originalGestureMethod = class_getInstanceMethod(class, originalGestureSelector);
//            Method swizzledGestureMethod = class_getInstanceMethod(class, swizzledGestureSelector);
//            
//            BOOL didAddGestureMethod = class_addMethod(class,
//                                                       originalGestureSelector,
//                                                       method_getImplementation(swizzledGestureMethod),
//                                                       method_getTypeEncoding(swizzledGestureMethod));
//            
//            if (didAddGestureMethod) {
//                class_replaceMethod(class,
//                                    swizzledGestureSelector,
//                                    method_getImplementation(originalGestureMethod),
//                                    method_getTypeEncoding(originalGestureMethod));
//            } else {
//                method_exchangeImplementations(originalGestureMethod, swizzledGestureMethod);
//            }
//            
//        }
//       
//
//    });
//    
//}
//
//
//- (BOOL)bag_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
//    
//    UIViewController *vc = self.topViewController;
//    if (item != vc.navigationItem) {
//        return YES;
//    }
//    
//    if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
//        if ([(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self]) {
//            return [self bag_navigationBar:navigationBar shouldPopItem:item];
//        } else {
//            return NO;
//        }
//    } else {
//        return [self bag_navigationBar:navigationBar shouldPopItem:item];
//    }
//    
//}
//
//
//- (void)bag_viewWillAppear:(BOOL)animated {
//    [self bag_viewWillAppear: animated];
//    
//    objc_setAssociatedObject(self, [kOriginDelegate UTF8String], self.interactivePopGestureRecognizer, OBJC_ASSOCIATION_ASSIGN);
//    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
//    
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    
//    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        UIViewController *vc = [self topViewController];
//        if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
//            if (![(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self]) {
//                return NO;
//            }
//        }
//    }
//    return YES;
//    
//}
//
//
//
//@end
