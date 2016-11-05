//
//  CustomSwipeCardView.swift
//  Pack
//
//  Created by admin on 5/18/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit

class CustomSwipeCardView: UIView {

  //MARK: - Outlets
  @IBOutlet weak var viewContent: UIView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var lblOwner: UILabel!
  @IBOutlet weak var lblContent: UILabel!
  @IBOutlet weak var btnShare: UIButton!


  //MARK: - Publics
  override func awakeFromNib() {
    layer.cornerRadius = 3

    backgroundColor = UIColor.clearColor()
    layer.shadowColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 28).CGColor
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowOpacity = 0.7
    layer.shadowRadius = 2.0

    viewContent.layer.cornerRadius = 3
    viewContent.layer.masksToBounds = true
    viewContent.layer.borderWidth = 0.3
    viewContent.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).CGColor

  }

  internal func setupCard(user: User) {

  }

  //MARK: - Privates
  private func getWidthText(str: String, font: UIFont) -> CGFloat {
    let lbl = UILabel()
    lbl.font = font
    lbl.text = str
    return lbl.sizeThatFits(CGSize(width: 10000, height: 40)).width
  }

  @IBAction func tapToShare(sender: AnyObject) {

  }
}
