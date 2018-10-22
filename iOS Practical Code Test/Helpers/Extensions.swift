//
//  Extensions.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension UIColor {
    func fromHexValue(hex hexValue: String) -> UIColor {
        var hexString = hexValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return .clear
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)
        let green = CGFloat((rgbValue & 0x00FF00) >> 8)
        let blue = CGFloat(rgbValue & 0x0000FF)
        
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
}

extension String {
    private var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UIView {
    enum BorderSide {
        case top
        case bottom
    }
    
    func addBorder(side: BorderSide, color: UIColor, thickness: CGFloat) {
        let border = UIView()
        
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            border.autoresizingMask = .flexibleWidth
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: thickness)
        }
        
        border.backgroundColor = color
        self.addSubview(border)
    }
}

extension UIImageView {
    func loadImageFromUrlString(url urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
                guard error == nil else { return }
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    self.image = image
                }
            }
            task.resume()
        }
    }
}

extension Date {
    func toOrdinalDateString() -> String {
        let calendar = Calendar.current
        let date = self
        let dateComponents = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .ordinal
        
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM yyyy"
        let dateString = "\(day!) \(dateFormatter.string(from: date))"
        
        return dateString
    }
    
    func toTimeString() -> String {
        let date = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
