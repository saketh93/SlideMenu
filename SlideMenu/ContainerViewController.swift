//
//  ContainerViewController.swift
//  SlideMenu
//
//  Created by Saketh Manemala on 28/06/17.
//  Copyright © 2017 Saketh. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case expanded
}

class ContainerViewController: UIViewController,HomeViewControllerDelegate,UIGestureRecognizerDelegate {
    var tapGestureRecognizer = UITapGestureRecognizer()
    var centerNavigationController: UINavigationController!
    var centerViewController: HomeViewController!
    // var mainPanelExpandedOffset: CGFloat = 518
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = currentState != .collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController: MenuViewController?
    // change this value to adjust width of Corespoding VC
    
    let centerPanelExpandedOffset: CGFloat = 125
    var opacityView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMove(toParentViewController: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture))
        panGestureRecognizer.delegate = self
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ContainerViewController.handleTapGesture(_:)))
        tapGestureRecognizer.delegate = self
        centerNavigationController.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: HomeViewController delegate methods
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .expanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        switch (currentState) {
        case .expanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            //under testing
            opacityView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            opacityView.backgroundColor = UIColor.clear
            opacityView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
            opacityView.layer.opacity = 0.8
            // view.insertSubview(opacityView, atIndex: 1)
            centerViewController.view.addSubview(opacityView)
            // view.addSubview(opacityView)
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: MenuViewController) {
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func animateLeftPanel(_ shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .expanded
            animateCenterPanelXPosition(250)
        } else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .collapsed
                self.opacityView.removeFromSuperview()
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    
    func animateCenterPanelXPosition(_ targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // MARK: Gesture recognizer
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        if centerNavigationController.viewControllers.last?.restorationIdentifier == "HomeViewController"{
            let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
            let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width - 50
            switch(recognizer.state) {
            case .began:
                if (currentState == .collapsed) {
                    if (gestureIsDraggingFromLeftToRight) {
                        addLeftPanelViewController()
                        showShadowForCenterViewController(true)
                        currentState = .expanded
                    }
                }
            case .changed:
                if (currentState == .expanded){
                    
                    //                print(recognizer.velocityInView(view).x)
                    //                recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
                    //                recognizer.setTranslation(CGPointZero, inView: view)
                    
                    let screen_center = recognizer.view!.frame.width/2
                    let new_center = recognizer.view!.center.x+recognizer.translation(in: view).x
                    if(screen_center <= new_center)
                    {
                        recognizer.view!.center.x = new_center
                        recognizer.setTranslation(CGPoint.zero, in: view)
                    }
                }
            case .ended:
                if (leftViewController != nil) {
                    // animate the side panel open or closed based on whether the view has moved more or less than halfway
                    print(hasMovedGreaterThanHalfway)
                    animateLeftPanel(hasMovedGreaterThanHalfway)
                }
            default:
                break
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view == centerViewController.view {
            return true
        }else if touch.view == opacityView {
            return true
        }else {
            return false
        }
    }
    
    func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        
        collapseSidePanels()
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftViewController() -> MenuViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
    }
    
    //enable below for right menu
    /*
    class func rightViewController() -> MenuViewController? {
        return   mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? MenuViewController
    }
    */
    class func centerViewController() -> HomeViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    }
}

