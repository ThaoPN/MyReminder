//
//  DetailsNoteVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase

class AddNoteVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var viewPriority: UIView!
  @IBOutlet weak var btnHight: UIButton!
  @IBOutlet weak var btnMedium: UIButton!
  @IBOutlet weak var btnLow: UIButton!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var txvContent: UITextView!

  // MARK: - Variables

  // MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "AddNoteVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()

    btnHight.layer.cornerRadius = 45/2
    btnHight.layer.borderColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1).CGColor
    btnHight.layer.borderWidth = 1
    btnHight.layer.masksToBounds = true

    btnMedium.layer.cornerRadius = 45/2
    btnMedium.layer.borderColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1).CGColor
    btnMedium.layer.borderWidth = 1
    btnMedium.layer.masksToBounds = true

    btnLow.layer.cornerRadius = 45/2
    btnLow.layer.borderColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1).CGColor
    btnLow.layer.borderWidth = 1
    btnLow.layer.masksToBounds = true

    btnMedium.selected = true

    viewPriority.layer.shadowColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 0.3).CGColor
    viewPriority.layer.shadowOffset = CGSize(width: 0, height: -2)
    viewPriority.layer.shadowOpacity = 0.7
    viewPriority.layer.shadowRadius = 2.0

    let toolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
    toolbar.barStyle = UIBarStyle.Default
    toolbar.items = [
      UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
      UIBarButtonItem(title: "Hide", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(hideKeyboard))]
    toolbar.sizeToFit()
    txvContent.inputAccessoryView = toolbar
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    if let _ = NSUserDefaults.standardUserDefaults().objectForKey(kTutorialAddNote) {

    } else {
      NSUserDefaults.standardUserDefaults().setValue("1", forKey: kTutorialAddNote)
      let vc = TutorialVC(isAddNote: true)
      presentViewController(vc, animated: true, completion: nil)
    }
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    txvContent.becomeFirstResponder()
  }
  // MARK: - Public methods
  func hideKeyboard() {
    txvContent.resignFirstResponder()
  }

  // MARK: - Private methods
  private func getPriority() -> String {
    var strPriority = "medium"

    if btnHight.selected == true {
      strPriority = Priority.hard
    }

    if btnMedium.selected == true {
      strPriority = Priority.medium
    }

    if btnLow.selected == true {
      strPriority = Priority.easy
    }

    return strPriority
  }

  private func postNote(contentNote: String) {

    let UUID = NSUUID().UUIDString
    var lent = 50
    if contentNote.characters.count < 50 {
      lent = contentNote.characters.count
    }
    let strNoteTitle = (contentNote as NSString).substringToIndex(lent)
    let strCreateAt = Common.convertDateToString(NSDate())
    let info = [KeyNote.noteContent: contentNote,
                KeyNote.noteID: UUID,
                KeyNote.notePriority: getPriority(),
                KeyNote.noteTitle: strNoteTitle,
                KeyNote.noteCreatedAt: strCreateAt]

    DHIndicator.show()
    if let currentUser = AppDelegate.shareInstance().currentUser, ref = currentUser.uRef {
      ref.child("\(currentUser.uID)/\(KeyUser.userNotes)/\(UUID)").setValue(info, withCompletionBlock: {[weak self] (error, noteRef) in
        guard let strongSelf = self else { return }

        DHIndicator.hide()
        if let error = error {
          print("post note error: \(error.localizedDescription)")
          Common.showAlertWithHUD(error.localizedDescription)
        } else {
          strongSelf.navigationController?.popViewControllerAnimated(true)
        }
      })
    }
  }

  // MARK: - Actions
  @IBAction func tapToBack(sender: AnyObject) {
    navigationController?.popViewControllerAnimated(true)
  }

  @IBAction func tapToClosePriority(sender: AnyObject) {
    UIView.animateWithDuration(0.3) {
      self.viewPriority.alpha = 0
    }
  }
  @IBAction func tapToSetHight(sender: AnyObject) {
    btnHight.selected = true
    btnMedium.selected = false
    btnLow.selected = false
  }
  @IBAction func tapToSetMedium(sender: AnyObject) {
    btnHight.selected = false
    btnMedium.selected = true
    btnLow.selected = false
  }
  @IBAction func tapToSetLow(sender: AnyObject) {
    btnHight.selected = false
    btnMedium.selected = false
    btnLow.selected = true
  }
  @IBAction func tapToSetPriority(sender: AnyObject) {
    UIView.animateWithDuration(0.3) {
      self.viewPriority.alpha = 1
    }
  }
  @IBAction func tapToShare(sender: AnyObject) {
    let vc = ShareForVC()
    navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func tapToDone(sender: AnyObject) {
    hideKeyboard()
    if txvContent.text.characters.count == 0 {
      Common.showAlertWithHUD("Please fill content for this note")
      return
    }
    postNote(txvContent.text)
  }
}
