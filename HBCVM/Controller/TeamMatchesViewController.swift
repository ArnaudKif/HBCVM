//
//  TeamMatchesViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//
import UIKit

class TeamMatchesViewController: UIViewController {
    // MARK: - Properties
    let matchService = MatchService.matchService
    var matchSelected: Match?
    var matchDBArray: [Match]?
    var isLoadingMatch = false
    var teamList = ["U13M", "U15M", "SeniorF", "SeniorM"]

    // MARK: - IBOutlets
    @IBOutlet weak var teamMatchTableView: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var teamPicker: UIPickerView!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        switchLoadingActivity(in: true)
        teamPicker.delegate = self
        teamPicker.dataSource = self
        teamMatchTableView.delegate = self
        teamMatchTableView.dataSource = self
        registerTableViewCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadFirstMatch()
        teamMatchTableView.reloadData()
    }

    // MARK: - Methods
    /// Configures the tableViewCell
    private func registerTableViewCells() {
        let nibName = UINib(nibName: "MatchTableViewCell", bundle: nil)
        teamMatchTableView.register(nibName, forCellReuseIdentifier: "MatchTableViewCell")
    }

    /// Change the activity indicator
    func switchLoadingActivity(in state: Bool) {
        self.activityIndicator.isHidden = !state
        self.isLoadingMatch = state
    }
    /// Load the first matches when the page is launched
    func loadFirstMatch(){
        isLoadingMatch = true
        switchLoadingActivity(in: true)
        let index = teamPicker.selectedRow(inComponent: 0)
        let teamName = teamList[index]
        getMatches(with: "\(teamName)")
    }

    /// Start the network call to retrieve the matches
    func getMatches(with team: String) {
        matchService.getMatchWithTeam(team: team) { result in
            print("appel lancé")
            if result?.error != nil {
                self.createAlert(message: "Erreur réseau. Pas de connection avec la base !")
                self.switchLoadingActivity(in: false)
            }
            guard let matchFromDB = result?.value,
                  matchFromDB.count != 0
            else {
                print("Pas de match dans la BDD")
                self.createAlert(message: "Pas de matches programmés !")
                self.switchLoadingActivity(in: false)
                return
            }
            self.matchDBArray = matchFromDB
            print("Nbre de match trouvés pour l'équipe : \(matchFromDB.count)")
            self.switchLoadingActivity(in: false)
            self.teamMatchTableView.reloadData()
        }
    }
}


extension TeamMatchesViewController : UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if matchDBArray == nil {
            return 0
        } else {
            return matchDBArray!.count
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let index = teamPicker.selectedRow(inComponent: 0)
        let teamName = teamList[index]
        let title = "Equipe \(teamName)"
        return title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        // Configure the cell...
        let match = matchDBArray![indexPath.row]
        guard let sc1 = match.team1Score , let sc2 = match.team2Score else {
            cell.commonInit(with: match.teamName, team2: match.adversaryTeamName, date: match.date.strDateForDisplay(), isOnHome: match.isInHome, scoreT1: 0, scoreT2: 0)
            return cell
        }
        cell.commonInit(with: match.teamName, team2: match.adversaryTeamName, date: match.date.strDateForDisplay(), isOnHome: match.isInHome, scoreT1: sc1, scoreT2: sc2)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        matchSelected = matchDBArray![indexPath.row]
        performSegue(withIdentifier: "ListToDetailMatch", sender: nil)
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let matchToDelete = matchDBArray![indexPath.row]
        let req = matchService.createDeleteRequest(withMatch: matchToDelete)
        matchService.load(request: req) { result in
            if result?.response?.statusCode == 200 {
                print("Suppression OK)")
                self.matchDBArray?.remove(at: indexPath.row)
                self.teamMatchTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "ListToDetailMatch" {
            // Pass the selected object to the new view controller.
            let detailVC = segue.destination as! MatchViewController
            detailVC.match = matchSelected
        }
    }

}

// MARK: - PickerView Components
extension TeamMatchesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        // récupération des données selectionnées
        // TODO: - Changer les matchs pour l'equipe selectionnée
        isLoadingMatch = true
        switchLoadingActivity(in: true)
        getMatches(with: teamList[row])
    }

}
