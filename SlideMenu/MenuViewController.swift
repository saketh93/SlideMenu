//
//  MenuViewController.swift
//  SlideMenu
//
//  Created by Saketh Manemala on 28/06/17.
//  Copyright © 2017 Saketh. All rights reserved.
//

import UIKit
protocol MenuViewControllerDelegate {
    func forSideMenuCollapse()
    
}
class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : MenuViewControllerDelegate?
    var contr : ContainerViewController?
    var profileImageView : UIImageView?
    var profileLabel : UILabel?
    var emailIdLabel : UILabel?

    var menuList = ["Profile","Books","Electronics","Fashion","Settings","Help" ]
    var menuImageList = ["Profile.png","Books.png","Electronics.png","Fashion.png","Settings.png","Help.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        if indexPath.row == 0 {
            cell.imageView?.tintColor = UIColor.black
            cell.imageView?.image = imageWithImage(UIImage(named: menuImageList[indexPath.row])!, scaledToSize: CGSize(width: 50, height: 50))
            cell.textLabel?.text =  menuList[indexPath.row]
            cell.textLabel?.font = UIFont (name: "Helvetica Neue", size: 15)
            cell.detailTextLabel?.text = "saketh@xyz.com"
        } else{
            cell.imageView?.tintColor = UIColor.black
            cell.imageView?.image = imageWithImage(UIImage(named: menuImageList[indexPath.row])!, scaledToSize: CGSize(width: 20, height: 20))
            cell.textLabel?.text =  menuList[indexPath.row]
            cell.textLabel?.font = UIFont (name: "Helvetica Neue", size: 15)
            cell.detailTextLabel?.text = nil
        }
        return cell
    }
    
}

// Mark: Table View Delegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let storyBoard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        print(selectedIndex)
        //let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        // let selectedRowText = cell?.textLabel?.text!
        
        switch selectedIndex {
        case 0:
            break
        case 1:
            let booksVC = storyBoard.instantiateViewController(withIdentifier: "BooksViewController")
            self.navigationController?.pushViewController(booksVC, animated: true)
            break
        case 2:
            let electronicsVC = storyBoard.instantiateViewController(withIdentifier: "ElectronicsViewController")
            self.navigationController?.pushViewController(electronicsVC, animated: true)
            break
        case 3:
            let fashionVC = storyBoard.instantiateViewController(withIdentifier: "FashionViewController")
            self.navigationController?.pushViewController(fashionVC, animated: true)
            break
            
        case 4:
            
            break
        case 5:
            break
        case 6:
            break
        case 7:
            print("Clicked Button2")
        case 8:
//            let languageVC = storyBoard.instantiateViewController(withIdentifier: "LanguageViewController")
//            self.navigationController?.pushViewController(languageVC, animated: true)
            print("Clicked Button2")
        case 9:
            print("Clicked Button2")
            break
        case 10:
            break
        case 11:
            
            break
        case 12:
            print("Clicked Button2")
        default:
            break
        }
        
        delegate?.forSideMenuCollapse()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        }
        else{
            return 45
        }
    }
}
