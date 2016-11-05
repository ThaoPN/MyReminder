//
//  ShareForVC.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit
import pop
import Async

class ShareForVC: UIViewController {
  // MARK: - Outlets
  @IBOutlet var viewFinishedShare: UIView!
  @IBOutlet weak var imvCheck: UIImageView!
  @IBOutlet weak var lblShared: UILabel!
  @IBOutlet weak var txfSearch: UITextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var consHeightViewFinished: NSLayoutConstraint!
  @IBOutlet weak var consWidthViewFinished: NSLayoutConstraint!

  // MARK: - Variables
  private var users = [User]()
  private var isShowFinished = false

  // MARK: - Init methods
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: "ShareForVC", bundle: nibBundleOrNil)
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

    tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")

    txfSearch.layer.cornerRadius = txfSearch.frame.size.height/2
    let leftViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: txfSearch.frame.size.height))
    txfSearch.leftView = leftViewEmail
    txfSearch.leftViewMode = .Always

    consWidthViewFinished.constant = 1
    consHeightViewFinished.constant = 1
    viewFinishedShare.layer.masksToBounds = true
    viewFinishedShare.layer.cornerRadius = 3

    fakeData()
  }

  // MARK: - Public methods

  // MARK: - Private methods
  private func fakeData() {
    for _ in 1...10 {
      let u = User()
      u.uFullName = "abc"
      users.append(u)
    }
    tableView.reloadData()
  }

  private func showFinishedView() {
    if isShowFinished {
      return
    }
    isShowFinished = true
    viewFinishedShare.alpha = 1
    consWidthViewFinished.constant = 175
    consHeightViewFinished.constant = 175

    UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in

      self.viewFinishedShare.setNeedsLayout()
      self.viewFinishedShare.layoutIfNeeded()
    }) { (finish) -> Void in
      UIView.animateWithDuration(0.3, animations: {
        self.imvCheck.alpha = 1
        self.lblShared.alpha = 1
      })
      //Animation DONE
    }

    Async.main(after: 2) {
      self.hideFinishedView()
    }
  }

  private func hideFinishedView() {
    viewFinishedShare.alpha = 0
    consWidthViewFinished.constant = 0
    consHeightViewFinished.constant = 0
    imvCheck.alpha = 0
    lblShared.alpha = 0
    isShowFinished = false
  }

  // MARK: - Actions
  @IBAction func tapToBack(sender: AnyObject) {
    view.endEditing(true)
    navigationController?.popViewControllerAnimated(true)
  }
}

extension ShareForVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell")

    let u = users[indexPath.row]
    cell?.textLabel?.text = u.uFullName

    let checkImv = UIImageView(image: UIImage(named: "ic_check"))
    if u.isSelected {
      cell?.accessoryView = checkImv
    } else {
      cell?.accessoryView = nil
    }
    cell?.selectionStyle = .None

    return cell!
  }
}

extension ShareForVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    users[indexPath.row].isSelected = true
    tableView.reloadData()
    showFinishedView()
  }
}
