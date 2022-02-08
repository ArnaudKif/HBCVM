//
//  UpdateMatchViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit
import Alamofire

class UpdateMatchViewController: UIViewController {
    // MARK: - Properties
    let matchService = MatchService.matchService
    var newMatch: Match?
    var matchToUpdate: Match?
    var teamList = ["U13M", "U15M", "SeniorF", "SeniorM"]
    var scoreArray: [Int] = []
    // components for the creation of a match
    var _teamName: String = "U13M"
    var _adversaryTeamName: String?
    var _date: String?
    var _isInHome : Bool = true
    var _matchAdress: String?
    var _comment : String?
    var _team1Score: Int?
    var _team2Score: Int?

    // to store the current active textfield
    var activeTextField : UITextField? = nil

    // MARK: - IBOutlets
    @IBOutlet weak var teamPickerView: UIPickerView!
    @IBOutlet weak var adversaryTeamTextField: UITextField!
    @IBOutlet weak var dateViewPicker: UIDatePicker!
    @IBOutlet weak var isInHomeSegment: UISegmentedControl!
    @IBOutlet weak var team1ScorePicker: UIPickerView!
    @IBOutlet weak var team2ScorePicker: UIPickerView!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerFirstLoad()
        firstLoad()
        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - IBActions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        adversaryTeamTextField.resignFirstResponder()
        adressTextField.resignFirstResponder()
        commentTextField.resignFirstResponder()
    }

    @IBAction func UpdateButton() {
        buttonTaped()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func segmentChanged() {
        homeSegmentTouched()
    }

    // MARK: - Methods
    /// Configure the first loading
    func firstLoad() {
        scoreArray.removeAll()
        var index = 0
        while index < 61 {
            scoreArray.append(index)
            index += 1
        }
        if matchToUpdate != nil {
            adversaryTeamTextField.text = matchToUpdate!.adversaryTeamName
            adressTextField.text = matchToUpdate!.matchAdress
            commentTextField.text = matchToUpdate!.comment
            dateViewPicker.date = matchToUpdate!.date.strToDate()
            
            _isInHome = matchToUpdate!.isInHome
            _team1Score = matchToUpdate!.team1Score
            _team2Score = matchToUpdate!.team2Score
            team1ScorePicker.selectRow(pickerStartIndex(with: matchToUpdate?.team1Score), inComponent: 0, animated: true)
            team2ScorePicker.selectRow(pickerStartIndex(with: matchToUpdate?.team2Score), inComponent: 0, animated: true)
            if matchToUpdate!.isInHome == false {
                isInHomeSegment.selectedSegmentIndex = 1
            }
            let indexRow:Int = teamList.firstIndex(of: matchToUpdate!.teamName) ?? 0
            teamPickerView.selectRow(indexRow, inComponent: 0, animated: true)
            _teamName = teamList[indexRow]
        }
    }

    /// Create the match to be updated and launch the request to modify it in the DB
    func buttonTaped() {
        chargeMatchItem()
        guard _adversaryTeamName != nil else {
            createAlert(message: "Veuillez remplir l'équipe adversaire !")
            return
        }
        guard _date != nil else {
            createAlert(message: "Veuillez choisir le jour du match !")
            return
        }
        guard _matchAdress != nil else {
            createAlert(message: "Veuillez indiquer le lieu du match !")
            return
        }
        guard _comment != nil else {
            createAlert(message: "Veuillez remplir un commentaire")
            return
        }
        let createdMatch = Match(id: matchToUpdate!.id, teamName: _teamName, adversaryTeamName: _adversaryTeamName!, date: _date!, isInHome: _isInHome, matchAdress: _matchAdress!, comment: _comment!, team1Score: _team1Score, team2Score: _team2Score)
        print(createdMatch)
        newMatch = createdMatch
        let req = matchService.createUpdateRequest(match: createdMatch)
        matchService.load(request: req) { result in
            if result?.error != nil {
                print(result!.error!.errorDescription!)
                self.createAlert(message: "Erreur lors du chargement dans la base !")
            }
            guard let matchReturned = result?.value else {
                self.createAlert(message: "Erreur, pas de retour de la base !")
                return
            }
            print("---- OK ---- : Match mis à jour ->")
            print(matchReturned)
        }
    }
    /// loads the elements of the textField and picker in the properties
    func chargeMatchItem() {
        if adversaryTeamTextField.hasText {
            _adversaryTeamName = adversaryTeamTextField.text
        }
        if commentTextField.hasText {
            self._comment = commentTextField.text
        }
        if adressTextField.hasText {
            self._matchAdress = adressTextField.text
        }
        _date = dateViewPicker.date.ISO8601Format()
    }

    /// loads the elements of the segment
    func homeSegmentTouched() {
        let index = isInHomeSegment.selectedSegmentIndex
        if index == 0 { _isInHome = true }
        if index == 1 { _isInHome = false }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "exitUpdateToMatchVC" {
            let matchUpdated = segue.destination as! MatchViewController
            matchUpdated.match = newMatch
        }
    }

}

//MARK: - PickerView Management
extension UpdateMatchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerFirstLoad() {
        teamPickerView.delegate = self
        teamPickerView.dataSource = self
        team1ScorePicker.dataSource = self
        team1ScorePicker.delegate = self
        team2ScorePicker.dataSource = self
        team2ScorePicker.delegate = self
    }

    func pickerStartIndex(with score: Int?) -> Int {
        var defaultRow: Int
        if let score1 = score {
            defaultRow = score1
        } else {
            defaultRow = 0
        }
        return defaultRow
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == teamPickerView {
            return teamList.count
        } else { return scoreArray.count }
    }

    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == teamPickerView {
            return teamList[row]
        } else { return "\(scoreArray[row])" }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == teamPickerView {
            _teamName = teamList[row]
        }
        if pickerView == team1ScorePicker {
            _team1Score = scoreArray[row]
            print("Score T1 = \(_team1Score!)")
        }
        if pickerView == team2ScorePicker {
            _team2Score = scoreArray[row]
            print("Score T2 = \(_team2Score!)")
        }
    }
    
}

//MARK: - Keyboard Management
extension UpdateMatchViewController : UITextFieldDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    // when user select a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // set the activeTextField to the selected textfield
        self.activeTextField = textField
    }

    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
