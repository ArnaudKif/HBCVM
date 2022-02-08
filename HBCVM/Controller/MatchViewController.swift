//
//  MatchViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit

class MatchViewController: UIViewController {
    // MARK: - Properties
    var match: Match?

    // MARK: - IBOutlets
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var adressTextView: UITextView!
    @IBOutlet weak var commentLabel: UITextView!
    @IBOutlet weak var HomeLabel: UILabel!
    @IBOutlet weak var ExtLabel: UILabel!
    @IBOutlet weak var scTeam1Name: UILabel!
    @IBOutlet weak var scTeam2Name: UILabel!
    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    // MARK: - IBActions
    @IBAction func unwindToMatchVC(segue:UIStoryboardSegue) {
        initView()
    }

    // MARK: - Methods
    /// Configure the first loading
    func initView() {
        guard match != nil else {
            return
        }
        team1Label.text = "HBCVM \(match!.teamName)"
        team2Label.text = match?.adversaryTeamName
        dateTextView.text = match?.date.strDateForDisplay()
        adressTextView.text = match?.matchAdress
        commentLabel.text = match?.comment
        scTeam1Name.text = match?.teamName
        scTeam2Name.text = match?.adversaryTeamName
        isHome(state: match?.isInHome ?? true)
        guard let score1 = match?.team1Score, let score2 = match?.team2Score else {
            score1Label.text = "--"
            score2Label.text = "--"
            print("NO SCORE")
            return
        }
        print("SCORE : \(score1) - \(score2)")
        score1Label.text = "\(score1)"
        score2Label.text = "\(score2)"
    }

    /// Displays homeLabel or ExtLabel depending on status
    func isHome(state: Bool) {
        HomeLabel.isHidden = !state
        ExtLabel.isHidden = state
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "matchToMap" {
            // Pass the selected object to the new view controller.
            let adressMapVC = segue.destination as! AdressMapViewController
            adressMapVC.adressLabel = adressTextView.text
        }
        if segue.identifier == "matchVCToUpdateVC" {
            let matchToUpdate = segue.destination as! UpdateMatchViewController
            matchToUpdate.matchToUpdate = self.match
        }
    }

}
