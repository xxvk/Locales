//
//  RegionDetailViewController.swift
//  Locales
//
//  Created by FBC on 2017/12/12.
//  Copyright © 2017年 FBC. All rights reserved.
//

import UIKit

class RegionDetailViewController: UITableViewController {
    
    var model: Locale?{
        didSet{
            guard let ist: Locale = model else {
                return
            }
            
            var preferLocale: Locale
            let bool =
                UserDefaults
                    .standard
                    .bool(forKey: MainViewController.segmentStoreKey)
            if bool {
                preferLocale = Locale.China
            }else{
                preferLocale = Locale.USA
            }
            if let countryName: String = (preferLocale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: ist.regionCode!){
                displayer[1] = countryName
                title = countryName
            }
            displayer[2] = ist.identifier
            displayer[3] = ist.regionCode ?? ""
            displayer[4] = ist.regionNumber() ?? ""
            displayer[5] = ist.dialingCode() ?? ""
            displayer[6] = ist.currencyCode ?? ""
            
            if let currencyName: String = (preferLocale as NSLocale).displayName(forKey:NSLocale.Key.currencyCode, value: model!.currencyCode!){
                displayer[7] = currencyName
            }
            displayer[8] = model?.currencySymbol ?? ""
            tableView.reloadData()
        }
    }
    
    var titles: [String] =
        ["Flag",
         "Name",
         "Locale Identifier",
         "Region Code",
         "Region Number",
         "Dialing Code",
         "Currency Code",
         "Currency Name",
         "Currency Symbol"]
    
    var displayer: [String] = ["","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    static let reuseID = "DetailCell"
    func configTableView() {
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: RegionDetailViewController.reuseID)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegionDetailViewController.reuseID, for: indexPath)
        if indexPath.row == 0 {
            if model != nil {
                if let img = model!.flag() {
                    cell.imageView?.image = img
                }
            }
        }else{
//            cell.textLabel?.text = titles[indexPath.row]
            cell.textLabel?.text = displayer[indexPath.row]
        }
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
