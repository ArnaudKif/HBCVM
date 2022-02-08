//
//  AdressMapViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit

class AdressMapViewController: UIViewController {

    var adressLabel: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(adressLabel!)
    }


    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
