//
//  ViewController.swift
//  LearningUIkitApp
//
//  Created by qian tao on 16/1/7.
//  Copyright © 2016年 qian tao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    var mainMenuView: UITableView?
    
    
    // MARK: DataSource
    struct MenuSection {
        var sectionHeader: String?
        var sectionBody: [String]?
        var sectionFooter: String?
    }
    
    var mainMenu = Array<MenuSection>()
    
    
    // MARK: View's life circle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainMenuView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Grouped)
        mainMenuView?.dataSource = self
        mainMenuView?.delegate = self
        mainMenuView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        mainMenuView?.contentInset.top = 5
        self.view.addSubview(mainMenuView!)
        
        initData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation

    
    // MARK: Actions
    func initData() {
        var viewSection = MenuSection(sectionHeader: "视图", sectionBody: ["UIView"], sectionFooter: nil)
        viewSection.sectionBody?.append("UIScrollView")
        viewSection.sectionBody?.append("UITableView")
        viewSection.sectionBody?.append("UICollectionView")
        
        var ctlSection = MenuSection(sectionHeader: "控件", sectionBody: ["UIButton"], sectionFooter: nil)
        ctlSection.sectionBody?.append("UILable")
        ctlSection.sectionBody?.append("UITextField")
        
        mainMenu.append(viewSection)
        mainMenu.append(ctlSection)
    }
}


// MARK: Delegations
extension MainViewController: UITableViewDelegate {
    
    //Implemention of didSelectRowAtIndexPath
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch mainMenu[indexPath.section].sectionBody![indexPath.row] {
            case "UIView": self.navigationController?.pushViewController(ShowUIViewController(title: "UIView"), animated: true)
            case "UIScrollView":
                self.navigationController?.pushViewController(ShowUIScrollViewController(title: "UIScrollView"), animated: true)
            case "UICollectionView":
                self.navigationController?.pushViewController(ShowUICollectionViewController(title: "UICollectionView"), animated: true)
        default:
            print("test")
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mainMenu.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenu[section].sectionBody!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        cell.textLabel?.text = mainMenu[indexPath.section].sectionBody![indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainMenu[section].sectionHeader
    }
}

