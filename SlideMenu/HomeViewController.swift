//
//  HomeViewController.swift
//  SlideMenu
//
//  Created by Saketh Manemala on 28/06/17.
//  Copyright © 2017 Saketh. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate {
    func toggleLeftPanel() /* toggle the navigation drawer from left to right */
    func collapseSidePanels() /* collapse the slide menu */
   /* func toggleRightPanel() //  toggle navigation drawer from right to left */
}

class HomeViewController: UIViewController {
    var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func slideMenuButtonClicked(_ sender: UIBarButtonItem) {
        delegate?.toggleLeftPanel()
        print("Hello")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
