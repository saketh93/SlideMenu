//
//  Extensions.swift
//  SlideMenu
//
//  Created by Saketh Manemala on 28/06/17.
//  Copyright © 2017 Saketh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func imageWithImage(_ image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
    }
}

extension HomeViewController : MenuViewControllerDelegate {
//    func configureFirstText(_ textField: UITextField!)
//    {
//        if let aTextField = textField {
//            // aTextField.backgroundColor = UIColor.clearColor()
//            aTextField.placeholder = " Address"
//            aTextField.borderStyle = UITextBorderStyle.roundedRect
//        }
//    }
    func forSideMenuCollapse() {
        delegate?.collapseSidePanels()
    }
}

