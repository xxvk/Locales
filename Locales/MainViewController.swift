//
//  MainViewController.swift
//  Locales
//
//  Created by xxvk on 2017/12/12.
//  Copyright © 2017年 FBC. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    static let reuseID = "Locales"
    func configTableView() {
        tableView.register(RegionCell.self, forCellReuseIdentifier: MainViewController.reuseID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocaleHelper.regions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.reuseID, for: indexPath)
        if let rcell: RegionCell = cell as? RegionCell {
            rcell.model = LocaleHelper.regions[indexPath.row]
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = RegionDetailViewController()
        vc.model = LocaleHelper.regions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
    static let segmentStoreKey = "isCHN"
    
    lazy var segment: UISegmentedControl = {
        let sg = UISegmentedControl.init(items: ["English","中文"])
        sg.addTarget(self,
                     action: #selector(MainViewController.segmentDidChanged(_:)) ,
                     for: UIControlEvents.valueChanged)
        let bool =
            UserDefaults
                .standard
                .bool(forKey: MainViewController.segmentStoreKey)
        if bool {
            sg.selectedSegmentIndex = 1
        }else{
            sg.selectedSegmentIndex = 0
        }
        return sg
    }()
    
    @objc func segmentDidChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UserDefaults
                .standard
                .set(false,
                     forKey: MainViewController.segmentStoreKey)
        }else if sender.selectedSegmentIndex == 1{
            UserDefaults
                .standard
                .set(true,
                     forKey: MainViewController.segmentStoreKey)
        }
        
        tableView.reloadData()
    }
    func configNavigator() {
        navigationItem.titleView = segment
    }

}
