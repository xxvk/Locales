//
//  RegionCell.swift
//  Locales
//
//  Created by xxvk on 2017/12/12.
//  Copyright © 2017年 FBC. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell {
    
    var model: Locale?{
        didSet{
            if model == nil {
                return
            }
            if let img = model!.flag() {
                imageView?.image = img
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
            
            if let countryName: String = (preferLocale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: model!.regionCode!){
                textLabel?.text = countryName
            }
            textLabel?.textColor = UIColor.darkGray
            
            if let currencyName: String = (preferLocale as NSLocale).displayName(forKey:NSLocale.Key.currencyCode, value: model!.currencyCode!){
                let curString = NSMutableAttributedString(string: "\(model!.currencyCode!) - \(currencyName) - \(model!.currencySymbol!)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
                curString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:4))
                detailTextLabel?.attributedText = curString
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
