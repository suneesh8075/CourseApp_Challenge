//
//  HCategoryCollectionViewCell.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import UIKit

class HCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var courseDetails: UILabel!
    @IBOutlet weak var courseInstructor: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseDurationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
