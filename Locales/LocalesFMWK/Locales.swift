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
    public static let India = Locale.init(identifier: "en_IN")
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
    func regionNumber() -> String? {
        if let key: String = regionCode {
            if let value: String = LocaleHelper.numbers[key] {
                return value
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
    
    static let numbers: [String: String] =
    [
        "AX" : "248" ,
        "AF" : "004" ,
        "AL" : "008" ,
        "DZ" : "012" ,
        "AS" : "016" ,
        "AD" : "020" ,
        "AO" : "024" ,
        "AI" : "660" ,
        "AQ" : "010" ,
        "AG" : "028" ,
        "AR" : "032" ,
        "AM" : "051" ,
        "AW" : "533" ,
        "AU" : "036" ,
        "AT" : "040" ,
        "AZ" : "031" ,
        "BS" : "044" ,
        "BH" : "048" ,
        "BD" : "050" ,
        "BB" : "052" ,
        "BY" : "112" ,
        "BE" : "056" ,
        "BZ" : "084" ,
        "BJ" : "204" ,
        "BM" : "060" ,
        "BT" : "064" ,
        "BO" : "068" ,
        "BA" : "070" ,
        "BW" : "072" ,
        "BV" : "074" ,
        "BR" : "076" ,
        "IO" : "086" ,
        "BN" : "096" ,
        "BG" : "100" ,
        "BF" : "854" ,
        "BI" : "108" ,
        "KH" : "116" ,
        "CM" : "120" ,
        "CA" : "124" ,
        "CV" : "132" ,
        "KY" : "136" ,
        "CF" : "140" ,
        "TD" : "148" ,
        "CL" : "152" ,
        "CN" : "156" ,
        "CX" : "162" ,
        "CC" : "166" ,
        "CO" : "170" ,
        "KM" : "174" ,
        "CD" : "180" ,
        "CG" : "178" ,
        "CK" : "184" ,
        "CR" : "188" ,
        "CI" : "384" ,
        "HR" : "191" ,
        "CU" : "192" ,
        "CY" : "196" ,
        "CZ" : "203" ,
        "DK" : "208" ,
        "DJ" : "262" ,
        "DM" : "212" ,
        "DO" : "214" ,
        "EC" : "218" ,
        "EG" : "818" ,
        "SV" : "222" ,
        "GQ" : "226" ,
        "ER" : "232" ,
        "EE" : "233" ,
        "ET" : "231" ,
        "FK" : "238" ,
        "FO" : "234" ,
        "FJ" : "242" ,
        "FI" : "246" ,
        "FR" : "250" ,
        "GF" : "254" ,
        "PF" : "258" ,
        "TF" : "260" ,
        "GA" : "266" ,
        "GM" : "270" ,
        "GE" : "268" ,
        "DE" : "276" ,
        "GH" : "288" ,
        "GI" : "292" ,
        "GR" : "300" ,
        "GL" : "304" ,
        "GD" : "308" ,
        "GP" : "312" ,
        "GU" : "316" ,
        "GT" : "320" ,
        "GN" : "324" ,
        "GW" : "624" ,
        "GY" : "328" ,
        "HT" : "332" ,
        "HM" : "334" ,
        "HN" : "340" ,
        "HK" : "344" ,
        "HU" : "348" ,
        "IS" : "352" ,
        "IN" : "356" ,
        "ID" : "360" ,
        "IR" : "364" ,
        "IQ" : "368" ,
        "IE" : "372" ,
        "IL" : "376" ,
        "IT" : "380" ,
        "JM" : "388" ,
        "JP" : "392" ,
        "JO" : "400" ,
        "KZ" : "398" ,
        "KE" : "404" ,
        "KI" : "296" ,
        "KP" : "408" ,
        "KR" : "410" ,
        "KW" : "414" ,
        "KG" : "417" ,
        "LA" : "418" ,
        "LV" : "428" ,
        "LB" : "422" ,
        "LS" : "426" ,
        "LR" : "430" ,
        "LY" : "434" ,
        "LI" : "438" ,
        "LT" : "440" ,
        "LU" : "442" ,
        "MO" : "446" ,
        "MK" : "807" ,
        "MG" : "450" ,
        "MW" : "454" ,
        "MY" : "458" ,
        "MV" : "462" ,
        "ML" : "466" ,
        "MT" : "470" ,
        "MH" : "584" ,
        "MQ" : "474" ,
        "MR" : "478" ,
        "MU" : "480" ,
        "YT" : "175" ,
        "MX" : "484" ,
        "FM" : "583" ,
        "MD" : "498" ,
        "MC" : "492" ,
        "MN" : "496" ,
        "MS" : "500" ,
        "MA" : "504" ,
        "MZ" : "508" ,
        "MM" : "104" ,
        "NA" : "516" ,
        "NR" : "520" ,
        "NP" : "524" ,
        "NL" : "528" ,
        "AN" : "530" ,
        "NC" : "540" ,
        "NZ" : "554" ,
        "NI" : "558" ,
        "NE" : "562" ,
        "NG" : "566" ,
        "NU" : "570" ,
        "NF" : "574" ,
        "MP" : "580" ,
        "NO" : "578" ,
        "OM" : "512" ,
        "PK" : "586" ,
        "PW" : "585" ,
        "PS" : "275" ,
        "PA" : "591" ,
        "PG" : "598" ,
        "PY" : "600" ,
        "PE" : "604" ,
        "PH" : "608" ,
        "PN" : "612" ,
        "PL" : "616" ,
        "PT" : "620" ,
        "PR" : "630" ,
        "QA" : "634" ,
        "RE" : "638" ,
        "RO" : "642" ,
        "RU" : "643" ,
        "RW" : "646" ,
        "SH" : "654" ,
        "KN" : "659" ,
        "LC" : "662" ,
        "PM" : "666" ,
        "VC" : "670" ,
        "WS" : "882" ,
        "SM" : "674" ,
        "ST" : "678" ,
        "SA" : "682" ,
        "SN" : "686" ,
        "CS" : "891" ,
        "SC" : "690" ,
        "SL" : "694" ,
        "SG" : "702" ,
        "SK" : "703" ,
        "SI" : "705" ,
        "SB" : "090" ,
        "SO" : "706" ,
        "ZA" : "710" ,
        "ES" : "724" ,
        "LK" : "144" ,
        "SD" : "736" ,
        "SR" : "740" ,
        "SJ" : "744" ,
        "SZ" : "748" ,
        "SE" : "752" ,
        "CH" : "756" ,
        "SY" : "760" ,
        "TW" : "158" ,
        "TJ" : "762" ,
        "TZ" : "834" ,
        "TH" : "764" ,
        "TL" : "626" ,
        "TG" : "768" ,
        "TK" : "772" ,
        "TO" : "776" ,
        "TT" : "780" ,
        "TN" : "788" ,
        "TR" : "792" ,
        "TM" : "795" ,
        "TC" : "796" ,
        "TV" : "798" ,
        "UG" : "800" ,
        "UA" : "804" ,
        "AE" : "784" ,
        "GB" : "826" ,
        "US" : "840" ,
        "UM" : "581" ,
        "UY" : "858" ,
        "UZ" : "860" ,
        "VU" : "548" ,
        "VA" : "336" ,
        "VE" : "862" ,
        "VN" : "704" ,
        "VG" : "092" ,
        "VI" : "850" ,
        "WF" : "876" ,
        "EH" : "732" ,
        "YE" : "887" ,
        "ZM" : "894" ,
        "ZW" : "716" ,
    ]
    
    init() {
        print("Country Flags Count: \(LocaleHelper.flags.count)")
    }
}
