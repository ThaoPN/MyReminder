import Foundation
import UIKit

let appName = "Memo"

// MARK: - Collor
let navbarBgColor: UIColor = UIColor(red: 153/255.0, green: 72/255.0, blue: 222/255.0, alpha: 1)

struct MyColor {
  static let violet = UIColor(red: 153/255, green: 72/255, blue: 222/255, alpha: 1)
  static let violetLight = UIColor(red: 242/255, green: 227/255, blue: 255/255, alpha: 1)
  static let blackLight = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
  static let gray = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
}

// MARK: - Constant
struct KeyUser {
  static let userID = "ID"
  static let userName = "Username"
  static let userPassword = "Password"
  static let userNotes = "Notes"
  static let userSharedNote = "SharedNotes"
}

struct KeyNote {
  static let noteID = "ID"
  static let noteTitle = "Title"
  static let noteContent = "Content"
  static let notePriority = "Priority"
  static let noteCreatedAt = "CreatedAt"
  static let noteOwner = "Owner"
}

struct Priority {
  static let hard = "Hard"
  static let medium = "Medium"
  static let easy = "Easy"
}

// MARK: - Size Screen
let screenWidth   = UIScreen.mainScreen().bounds.size.width
let screenHeight  = UIScreen.mainScreen().bounds.size.height
