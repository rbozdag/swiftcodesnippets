import Foundation
import UIKit

public extension UIColor {
    public convenience init<T>(rgbValue: T, alpha: CGFloat = 1) where T: BinaryInteger {
        guard rgbValue > 0 else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        
        guard rgbValue < 0xFFFFFF else {
            self.init(red: 1, green: 1, blue: 1, alpha: alpha)
            return
        }
        
        let r: CGFloat = CGFloat(((rgbValue & 0xFF0000) >> 16) / 0xFF)
        let g: CGFloat = CGFloat((rgbValue & 0x00FF00) >> 8 / 0xFF)
        let b: CGFloat = CGFloat((rgbValue & 0x0000FF) / 0xFF)
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

//Sample usages
let white = UIColor(rgbValue: 16777215)
let red = UIColor(rgbValue: 16711680)
let green = UIColor(rgbValue: 0x00FF00)
let blue = UIColor(rgbValue: 0x0000FF)
let yellow = UIColor(rgbValue: 0xFFFF00)
let black = UIColor(rgbValue: 0)

// Sample beyond range usages
let blackest = UIColor(rgbValue: -1)
let whitest = UIColor(rgbValue: 0xff000000)

