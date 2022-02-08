//
//  AddMatchViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit

class AddMatchViewController: UIViewController {
    // MARK: - Properties
    let matchService = MatchService.matchService
    let teamList = ["U13M", "U15M", "SeniorF", "SeniorM"]
    var teamName: String = "HBCVM U13M"
    var adversaryTeamName: String?
    var date: String?
    var isInHome : Bool = true
    var matchAdress: String?
    var comment : String?
    var activeTextField : UITextField? = nil

    // MARK: - IBOutlets
    @IBOutlet weak var TeamPicker: UIPickerView!
    @IBOutlet weak var AdversaryTextField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var HomeExtSegmentedControl: UISegmentedControl!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        TeamPicker.delegate = self
        TeamPicker.dataSource = self
        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - keyboard control
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        AdversaryTextField.resignFirstResponder()
        commentTextField.resignFirstResponder()
        adressTextField.resignFirstResponder()
    }

    // MARK: - IBAction
    @IBAction func datePickerSelected(_ sender: Any) {
        datePickerChanged()
    }

    @IBAction func addMatchButton() {
        addButtonTaped()
        navigationController?.popViewController(animated: true)
    }

    @IBAction func homeSegmentTouched(_ sender: Any) {
        let index = HomeExtSegmentedControl.selectedSegmentIndex
        if index == 0 { isInHome = true }
        if index == 1 { isInHome = false }
    }

    // MARK: - Methods
    /// Create the match to be created and launch the request to add it in the DB
    func addButtonTaped() {
        datePickerChanged()
        advTeamAdded()
        adressTextAdded()
        commentAdded()
        guard adversaryTeamName != nil else {
            createAlert(message: "Veuillez remplir l'équipe adversaire !")
            return
        }
        guard date != nil else {
            createAlert(message: "Veuillez choisir le jour du match !")
            return
        }
        guard matchAdress != nil else {
            createAlert(message: "Veuillez indiquer le lieu du match !")
            return
        }
        guard comment != nil else {
            createAlert(message: "Veuillez remplir un commentaire")
            return
        }
        let createdMatch = Match(id: UUID(), teamName: teamName, adversaryTeamName: adversaryTeamName!, date: date!, isInHome: isInHome, matchAdress: matchAdress!, comment: comment!, team1Score: nil, team2Score: nil)
        let req = matchService.createPostRequest(match: createdMatch)
        matchService.load(request: req) { result in
            if result?.error != nil {
                print(result!.error!.errorDescription!)
                self.createAlert(message: "Erreur lors du chargement dans la base !")
            }
            guard let matchReturned = result?.value else {
                self.createAlert(message: "Erreur, pas de retour de la base !")
                return
            }
            print(matchReturned)
        }
    }

    /// Assigns the text of the adversaryTextField in the property adversaryTeamName
    func advTeamAdded() {
        if AdversaryTextField.hasText {
            adversaryTeamName = AdversaryTextField.text
        }
    }

    /// Assigns the text of the commentTextField in the property comment
    func commentAdded() {
        if commentTextField.hasText {
            self.comment = commentTextField.text
        }
    }

    /// Assigns the text of the adressTextField in the property matchAdress
    func adressTextAdded() {
        if adressTextField.hasText {
            self.matchAdress = adressTextField.text
        }
    }

    /// Format the datePicker in ISO8601Format
    func datePickerChanged() {
        date = DatePicker.date.ISO8601Format()
        print(date!)
    }
}

// MARK: - PickerView Management
extension AddMatchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teamList.count
    }

    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teamList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teamName = teamList[row]
    }

}

//MARK: - Keyboard Management
extension AddMatchViewController : UITextFieldDelegate {
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
}
