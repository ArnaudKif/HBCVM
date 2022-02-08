//
//  MatchTableViewCell.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team2NameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var HomeStatusLabel: UILabel!
    @IBOutlet weak var ExtStatusLabel: UILabel!

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// Configure the cell with match elements
    func commonInit(with team1: String, team2: String, date: String, isOnHome: Bool, scoreT1: Int?, scoreT2: Int? ) {
        if isOnHome{
            team1NameLabel.text = team1
            team2NameLabel.text = team2
        } else {
            team1NameLabel.text = team2
            team2NameLabel.text = team1
        }
        if scoreT1 != nil && scoreT1 != 0 {
            team1Score.text = "\(scoreT1!)"
        } else {
            team1Score.text = "-"
        }
        if scoreT2 != nil && scoreT2 != 0 {
            team2Score.text = "\(scoreT2!)"
        } else {
            team2Score.text = "-"
        }
        homeOrExt(onHome: isOnHome)
        dateLabel.text = date
    }

    /// Displays homeLabel or ExtLabel depending on status
    func homeOrExt(onHome: Bool) {
        HomeStatusLabel.isHidden = !onHome
        ExtStatusLabel.isHidden = onHome
    }

}
