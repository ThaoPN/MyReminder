//
//  NoteCell.swift
//  MyReminder
//
//  Created by admin on 11/5/16.
//  Copyright © 2016 ThaoPN. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
// MARK: - Outlets
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblPriority: UILabel!
  @IBOutlet weak var lblContent: UILabel!

// MARK: - Variables
  let kColorHard = UIColor(red: 243/255, green: 13/255, blue: 41/255, alpha: 1)
  let kColorMedium = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
  let kColorLow = UIColor(red: 39/255, green: 177/255, blue: 10/255, alpha: 1)

// MARK: - Override methods
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    selectionStyle = .None
    lblPriority.layer.cornerRadius = 18/2
    lblPriority.layer.masksToBounds = true
  }
// MARK: - Public methods

// MARK: - Private methods

// MARK: - Actions

}
