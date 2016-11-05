
import Foundation
import UIKit

func createColorWithHex(hex: String) -> UIColor {
  var alpha: Float = 100
  var h = hex
  let hexLength = h.characters.count
  if !(hexLength == 7 || hexLength == 9) {
    // A hex must be either 7 or 9 characters (#GGRRBBAA)
    print("improper call to 'colorFromHex', hex length must be 7 or 9 chars (#GGRRBBAA)")
    //    return UIColor(white: 0, alpha: 1)
  }

  if hexLength == 9 {
    // Note: this uses String subscripts as given below
    alpha = h[7...8].floatValue
    h = h[0...6]
  }

  // Establishing the rgb color
  var rgb: UInt32 = 0
  let s: NSScanner = NSScanner(string: h)
  // Setting the scan location to ignore the leading `#`
  s.scanLocation = 1
  // Scanning the int into the rgb colors
  s.scanHexInt(&rgb)

  return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                 green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                 blue: CGFloat(rgb & 0x0000FF) / 255.0,
                 alpha: CGFloat(alpha / 100))
}

extension String {
  
  /**
   Returns the float value of a string
   */
  var floatValue: Float {
    return (self as NSString).floatValue
  }
  
  /**
   Subscript to allow for quick String substrings ["Hello"][0...1] = "He"
   */
  subscript (r: Range<Int>) -> String {
    get {
      let start = self.startIndex.advancedBy(r.startIndex)
      let end = self.startIndex.advancedBy(r.endIndex - 1)
      return self.substringWithRange(start..<end)
    }
  }
}