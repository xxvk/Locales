//
//  Locales.swift
//  Locales
//
//  Created by xxvk on 2017/12/12.
//  Copyright © 2017年 FBC. All rights reserved.
//

import UIKit

//Fast Links
extension Locale{
    //G8
    public static let USA = Locale.init(identifier: "en_US")
    public static let UK = Locale.init(identifier: "en_UK")
    public static let German = Locale.init(identifier: "de_DE")
    public static let Russia = Locale.init(identifier: "ru_RU")
    public static let France = Locale.init(identifier: "fr_FR")
    public static let Japan = Locale.init(identifier: "jp_JP")
    public static let Canada = Locale.init(identifier: "en_CA")
    public static let Italy = Locale.init(identifier: "it_IT")
    
    //CHN
    public static let China = Locale.init(identifier: "zh_CN")
    public static let HongKong = Locale.init(identifier: "zh_HK")
    public static let Macao = Locale.init(identifier: "zh_MO")
    public static let Taiwan = Locale.init(identifier: "zh_TW")
    
    //asia
    public static let Israel = Locale.init(identifier: "he_IL")
    public static let Australia = Locale.init(identifier: "en_AU")
    public static let Korean = Locale.init(identifier: "kr_KR")
    public static let India = Locale.init(identifier: "jp")
    public static let SaudiArabia = Locale.init(identifier: "ar_SA")
    public static let Singapore = Locale.init(identifier: "en_SG")
    public static let Indonesia = Locale.init(identifier: "en_ID")
    public static let Malaysia = Locale.init(identifier: "en_MY")
    public static let Thailand = Locale.init(identifier: "th_TH")
    public static let Vietnam = Locale.init(identifier: "zh_VN")
    public static let Philippines = Locale.init(identifier: "en_PH")
    public static let Laos = Locale.init(identifier: "lo_LA")
    public static let Turkey = Locale.init(identifier: "tr_TR")
    
    //americans
    public static let Mexico = Locale.init(identifier: "es_MX")
    public static let Brazil = Locale.init(identifier: "en_BR")
    public static let Argentina = Locale.init(identifier: "en_AR")
    
    //Africas
    public static let Egypt = Locale.init(identifier: "ar_EG")
    public static let SouthAfrica = Locale.init(identifier: "zu_ZA")
    
}

//
extension Locale{
    public enum Index {
        case identifier
        case regionCode
        case currencyCode
        case currencySymbol
        case languageCode
        case englishRegionName
        case chineseRegionName
    }
    
    public static func search(_ value: String, for key: Locale.Index) -> [Locale] {
        var result = [Locale]()
        switch key {
        case .identifier:
            for lo in LocaleHelper.array{
                if lo.identifier == value{
                    result.append(lo)
                }
            }
            break
        case .regionCode:
            for lo in LocaleHelper.array{
                if lo.regionCode == value{
                    result.append(lo)
                }
            }
            break
        case .currencyCode:
            for lo in LocaleHelper.array{
                if lo.currencyCode == value{
                    result.append(lo)
                }
            }
            break
        case .currencySymbol:
            for lo in LocaleHelper.array{
                if lo.currencySymbol == value{
                    result.append(lo)
                }
            }
            break
        case .languageCode:
            for lo in LocaleHelper.array{
                if lo.languageCode == value{
                    result.append(lo)
                }
            }
            break
        case .englishRegionName:
            let origin = (USA as NSLocale)
            for lo in LocaleHelper.regions{
                let name = origin.displayName(forKey: NSLocale.Key.countryCode, value: lo.regionCode!)
                if name?.lowercased() == value.lowercased(){
                    result.append(lo)
                    break
                }
            }
            break
        case .chineseRegionName:
            let origin = (China as NSLocale)
            for lo in LocaleHelper.regions{
                let name = origin.displayName(forKey: NSLocale.Key.countryCode, value: lo.regionCode!)
                if name == value{
                    result.append(lo)
                    break
                }
            }
            break
        }
        return result
    }
    public func flag() -> UIImage? {
        if let key: String = regionCode {
            if let image: UIImage = LocaleHelper.flags[key] {
                return image
            }
        }
        return nil
    }
}

internal class LocaleHelper {
    
    static let array: [Locale] = Locale.availableIdentifiers.map {
        (identifier) -> Locale in
        return Locale.init(identifier: identifier)
    }
    
    static let regions: [Locale] = {
        var arr = [Locale]()
        for region in Locale.isoRegionCodes {
            let some = Locale.search(region, for: Locale.Index.regionCode)
            if some.count > 0 {
                arr.append(some.first!)
            }
        }
        return arr
    }()
    
    static let flags: [String : UIImage] = {
        var result = [String : UIImage]()
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: "Locales", withExtension: "bundle") else {
            return result
        }
        guard let imageBundle = Bundle.init(url: url) else {
            return result
        }
        for rg in regions {
            if let key: String = rg.regionCode {
                if let filePath: String = imageBundle.path(forResource: key, ofType: "png"){
                    if let image: UIImage = UIImage.init(contentsOfFile: filePath) {
                        result[key] = image
                    }
                }
            }
        }
        return result
    }()
    
    init() {
        print("Country Flags Count: \(LocaleHelper.flags.count)")
    }
}
