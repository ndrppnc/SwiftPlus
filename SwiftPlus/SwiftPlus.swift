//
//  SwiftPlus.swift
//  SwiftPlus
//
//  Created by Andrei Papancea on 5/7/15.
//  Copyright (c) 2015 Andrei Papancea. All rights reserved.
//

import UIKit

extension UILabel {
    
    func boldSubstring(substring: String) {
        var text: NSString = NSString(string: self.text!)
        var range = text.rangeOfString(substring)
        self.boldRange(range)
    }
    
    func boldRange(range: NSRange) {
        if !self.respondsToSelector("setAttributedText:") {
            return
        }
        
        var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        
        attributedText.setAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(self.font.pointSize)], range: range)
        
        self.attributedText = attributedText
    }
    
}

extension String {
    func isValidPassword() -> Bool {
        return count(self) > 7
    }
}

extension String {
    func isEmail() -> Bool {
        let regex = NSRegularExpression(pattern: "^[[:alnum:]._%+-]+@[[:alnum:].-]+\\.[A-Z]+$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}

extension String {
    func isValidNumber() -> Bool {
        let regex = NSRegularExpression(pattern: "^[1-9][0-9]*$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}

extension String {
    func containsString(c: String) -> Bool {
        let regex = NSRegularExpression(pattern: c, options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

extension UIImage {
    
    func tintWithColor(color:UIColor)->UIImage {
        
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        
        // flip the image
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextTranslateCTM(context, 0.0, -self.size.height)
        
        // multiply blend mode
        CGContextSetBlendMode(context, kCGBlendModeMultiply)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        
        // create uiimage
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
}

extension UIImageView {
    func imageFromUIImageView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0)
        self.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image;
    }
}

extension UIImageView {
    func setIcyBackgroundWithImageName(image: String) {
        var bg = UIImage (named: image)!
        var visualEffectView = UIVisualEffectView(
            effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        
        self.image = bg
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
    }
    
    func setIcyBackgroundWithImage(image: UIImage) {
        var visualEffectView = UIVisualEffectView(
            effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        
        self.image = image
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
    }
}

extension UIImage {
    func scaleToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.drawInRect(CGRect(x: 0,y: 0,width: size.width,height: size.height))
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension Array {
    func serialize(separator: String = ", ") -> String {
        var result = ""
        var count = 0
        
        for i in self {
            if let s = i as? String {
                if count == 0 {
                    result += s
                } else {
                    result += "\(separator)\(s)"
                }
                count++
            }
        }
        
        return result
    }
}

extension NSArray {
    func serialize(separator: String = ", ") -> String {
        var result = ""
        var count = 0
        
        for i in self {
            if let s = i as? String {
                if count == 0 {
                    result += s
                } else {
                    result += "\(separator)\(s)"
                }
                count++
            }
        }
        
        return result
    }
}