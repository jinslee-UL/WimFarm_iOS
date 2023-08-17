//
//  VCExt.swift
//  WimFarm
//
//  Created by ulalalab on 2022/02/11.
//

import UIKit
import Foundation
import Alamofire
import CoreTelephony
import AdSupport
import ZVProgressHUD

let userDefault = UserDefaults.standard
let date = Date()

extension UIViewController
{
    func exitApplication()
    {
        exit(0)
    }
    
    func deviceUUID() -> String? {
        var uuidStr: String?
        
        uuidStr = userDefault.string(forKey: Common.UserDefaultKey.UUID)
        if(uuidStr == nil) {
            userDefault.set(NSUUID().uuidString, forKey: Common.UserDefaultKey.UUID)
            userDefault.synchronize()
            uuidStr = NSUUID().uuidString
        } else {
            
        }
        
        return uuidStr
    }
    
    func deviceModel() -> String? {
        var identifier: String?
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier! + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    func adIdentifierStr() -> String? {
        let myIDFA: String?
        
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            myIDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            myIDFA = nil
        }

        return myIDFA
    }
    
    func startLoading() {
        ZVProgressHUD.setDisplayStyle(.light)
        ZVProgressHUD.setMaskType(.black)
        ZVProgressHUD.setAnimationType(.flat)
//        ZVProgressHUD.displayStyle = .light
//        ZVProgressHUD.maskType = .black
//        ZVProgressHUD.animationType = .flat
        ZVProgressHUD.show()
    }
    
    func stopLoading() {
        ZVProgressHUD.dismiss()
    }
    
    func carrierCode() -> String? {
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider

        let carrierName = carrier?.carrierName
        print("Carrier: \(carrierName ?? "")")
        print("Mobile Country Code (MCC): \(carrier?.mobileNetworkCode ?? "")")

        var carrierCode = carrier?.mobileNetworkCode
        if carrierCode == nil {
            carrierCode = ""
        } else {
            if (carrierCode == "05") {
                carrierCode = "1"
            } else if (carrierCode == "08") {
                carrierCode = "2"
            } else {
                carrierCode = "3"
            }
        }

        return carrierCode
    }
    
    func decode(data: String?) -> String? {
        let decodedData = Data(base64Encoded: data ?? "", options: [])
        var decodedString: String? = nil
        if let decodedData = decodedData {
            decodedString = String(data: decodedData, encoding: .utf8)
        }

        return decodedString
    }
    
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func RGB(colorR: CGFloat, colorG: CGFloat, colorB: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: colorR/255.0, green: colorG/255.0, blue: colorB/255.0, alpha: alpha)
    }
    
    func fontEdit(_ allText: String?, editText: String?, fontName: String?, fontSize: CGFloat, rColor rClolr: CGFloat, gColor: CGFloat, bColor: CGFloat) -> NSMutableAttributedString? {

        let att = NSMutableAttributedString(string: allText ?? "")
        let range = (allText as NSString?)?.range(of: editText ?? "")
        if let range = range {
            att.addAttribute(.font, value: UIFont(name: fontName ?? "", size: fontSize) as Any, range: range)
            att.addAttribute(.foregroundColor, value: UIColor(red: rClolr / 255.0, green: gColor / 255.0, blue: bColor / 255.0, alpha: 1.0), range: range)
        }

        return att
    }
    
    func DecimalComma(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
            
        return result
    }
    
    func nowDate() -> String{
        let now = Date()
        
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return date.string(from: now)
    }
    
    func nowDetailTime() -> String{
        let now = Date()
        
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "HH:mm:ss"
        
        return date.string(from: now)
    }
    
    // E-mail address validation
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
    var apiControl:ApiControl {
        get {
            return ApiControl.shared
        }
    }
}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [
            UIColor.green.cgColor,
            UIColor.orange.cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            layer.shadowOffset = CGSize(width: 2, height: 2)
            layer.shadowOpacity = 0.2
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIButton {
    
    @IBInspectable override var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
}

