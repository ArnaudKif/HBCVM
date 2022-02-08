//
//  AdressMapViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit

/*
 WARNING: This Controller is not yet developed. It is a draft VC

 */
// TODO: - It will be necessary to transform the address received from the previous VC into a POI (with latitude and longitude, via an API?) then display this point on the map.

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


}
