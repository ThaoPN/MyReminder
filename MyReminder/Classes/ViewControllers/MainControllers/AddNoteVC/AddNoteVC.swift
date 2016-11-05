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
  }
  // MARK: - Public methods

  // MARK: - Private methods
  private func setHard() {
    btnHight.backgroundColor = UIColor.whiteColor()
    btnHight.setTitleColor(UIColor.blackColor(), forState: .Normal)
    btnMedium.backgroundColor = UIColor.whiteColor()
    btnLow.backgroundColor = UIColor.whiteColor()
    
  }
  
  private func setMedium() {
    
  }
  
  private func setLow() {
    
  }
  
  private func setPriority(index: Int) {
//    switch index {
//    case 0:
//      
//    default:
//      break;
//    }
  }

  // MARK: - Actions
  @IBAction func tapToBack(sender: AnyObject) {
    navigationController?.popViewControllerAnimated(true)
  }

  @IBAction func tapToClosePriority(sender: AnyObject) {
    viewPriority.hidden = true
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
    viewPriority.hidden = false
  }


}
