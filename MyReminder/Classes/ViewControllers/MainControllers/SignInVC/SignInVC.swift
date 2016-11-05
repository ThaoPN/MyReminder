//
//  SignInVC.swift
//  MyReminder
//
//  Created by admin on 11/3/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var txfEmail: UITextField!
  @IBOutlet weak var txfPassword: UITextField!
  @IBOutlet weak var btnSignUp: UIButton!
  @IBOutlet weak var consTopTitle: NSLayoutConstraint!

  // MARK: - Variables
  private var ref: FIRDatabaseReference!
  private var _refHandle: FIRDatabaseHandle!

  // MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "SignInVC", bundle: nibBundleOrNil)
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

    configureFirebase()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.hidden = true
    (navigationController as? GGNavigationController)?.naviBar?.hidden = true

    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.navigationBarHidden = true
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
  private func configureFirebase() {
    ref = FIRDatabase.database().reference()

  }

  // MARK: - Actions
  @IBAction func tapToSignin(sender: AnyObject) {
    view.endEditing(true)

//    if txfEmail.text?.characters.count == 0 || txfPassword.text?.characters.count == 0 {
//      Common.showAlertWithHUD("Please input Email or Password")
//      return
//    }
//
//    ref.child("Users").queryOrderedByChild(KeyUser.userEmail).queryEqualToValue(txfEmail.text!).observeSingleEventOfType(.Value, withBlock: {[weak self] (snapshot) in
//      guard let strongSelf = self else {return}
//      print(snapshot.value)
//      if snapshot.childrenCount > 0 {
//        for d in snapshot.children.allObjects as! [FIRDataSnapshot] {
//          if d.value![KeyUser.userPassword] as! String == strongSelf.txfPassword.text! {
//            print("login ok")
//            return
//          }
//        }
//        Common.showAlertWithHUD("Email or Password is incorrect!")
//      } else {
//        Common.showAlertWithHUD("Email or Password is incorrect!")
//      }
//    })


    let vc = MainScreenVC()
    let navi = GGNavigationController(rootViewController: vc)

    UIView.transitionWithView(AppDelegate.shareInstance().window!,
                              duration:0.5,
                              options: UIViewAnimationOptions.TransitionCrossDissolve,
                              animations: {
                                let oldState: Bool = UIView.areAnimationsEnabled()
                                UIView.setAnimationsEnabled(false)
                                AppDelegate.shareInstance().window?.rootViewController = navi

                                UIView.setAnimationsEnabled(oldState)
      },
                              completion: {
                                finished in

    })
  }

  @IBAction func tapToSignUp(sender: AnyObject) {
    let vc = SignUpVC()
    presentViewController(vc, animated: true, completion: nil)
  }
}
