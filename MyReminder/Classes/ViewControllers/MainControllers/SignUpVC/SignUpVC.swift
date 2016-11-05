//
//  SignUpVC.swift
//  MyReminder
//
//  Created by admin on 11/2/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
// MARK: - Outlets
  @IBOutlet weak var txfEmail: UITextField!
  @IBOutlet weak var txfPassword: UITextField!
  @IBOutlet weak var consTopTitle: NSLayoutConstraint!
  @IBOutlet weak var btnSignUp: UIButton!

// MARK: - Variables
  private var ref: FIRDatabaseReference!
  private let users = [User]()
  private var usersTmp = [FIRDataSnapshot]()
  private var _refHandle: FIRDatabaseHandle!

// MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "SignUpVC", bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }

  deinit {
    //ref.child("Users").removeObserverWithHandle(_refHandle)
  }

// MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()

    ref = FIRDatabase.database().reference()

//    DHIndicator.show()
//    _refHandle = ref.child("Users").queryOrderedByKey().observeEventType(.Value, withBlock: {[weak self] (snapshot) in
//      guard let strongSelf = self else { return }
//
//      strongSelf.usersTmp.append(snapshot)
//      print(strongSelf.usersTmp)
//      DHIndicator.hide()
//    })

    txfEmail.layer.cornerRadius = 45/2
    let leftViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: txfEmail.frame.size.height))
    txfEmail.leftView = leftViewEmail
    txfEmail.leftViewMode = .Always

    txfPassword.layer.cornerRadius = 45/2
    let leftViewPassword = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: txfPassword.frame.size.height))
    txfPassword.leftView = leftViewPassword
    txfPassword.leftViewMode = .Always

    btnSignUp.layer.borderWidth = 1
    btnSignUp.layer.borderColor = UIColor.blackColor().CGColor
    btnSignUp.layer.cornerRadius = 45/2
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }

// MARK: - Public methods
  func keyboardWillShow(notification: NSNotification) {
    consTopTitle.constant = 50

  }

  func keyboardWillHide(notification: NSNotification) {
    print("Keyboard hide")
    consTopTitle.constant = 162
  }
// MARK: - Private methods
  private func signUpWith(email: String, password: String) {
    let uuid = NSUUID().UUIDString

    let info = [KeyUser.userID: uuid,
                KeyUser.userEmail: email,
                KeyUser.userPassword: password]
    let path = "Users/\(uuid)"

    ref.child(path).setValue(info)
  }

// MARK: - Actions
  @IBAction func tapToSignUp(sender: AnyObject) {
    if txfEmail.text?.characters.count == 0 || txfPassword.text?.characters.count == 0 {
      Common.showAlertWithHUD("Please input Email or Password")
      return
    }

    ref.child("Users").queryOrderedByChild(KeyUser.userEmail).queryEqualToValue(txfEmail.text!).observeSingleEventOfType(.Value, withBlock: {[weak self] (snapshot) in
      guard let strongSelf = self else { return }

      if snapshot.childrenCount > 0 {
        Common.showAlertWithHUD("Your email is existed!")
      } else {
        strongSelf.signUpWith(strongSelf.txfEmail.text!, password: strongSelf.txfPassword.text!)
      }
    })
  }

  @IBAction func tapToClose(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
