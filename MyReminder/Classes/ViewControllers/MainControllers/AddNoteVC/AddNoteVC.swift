//
//  DetailsNoteVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit

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

    viewPriority.layer.shadowColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 0.3).CGColor
    viewPriority.layer.shadowOffset = CGSize(width: 0, height: -2)
    viewPriority.layer.shadowOpacity = 0.7
    viewPriority.layer.shadowRadius = 2.0
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
  // MARK: - Public methods

  // MARK: - Private methods

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
}
