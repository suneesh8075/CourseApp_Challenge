//
//  MainTableCellTableViewCell.swift
//  testApp
//
//  Created by Suneeshkumar K S on 29/04/2024.
//

import UIKit

class MainTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var instructorNameLabel: UILabel!
    @IBOutlet weak var courseDescriptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var likesView: UIView!
    @IBOutlet weak var likeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = selectedBackgroundView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
