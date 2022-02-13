//
//  AdressMapViewController.swift
//  HBCVM
//
//  Created by arnaud kiefer on 02/02/2022.
//

import UIKit
import MapKit

/*
 WARNING: This Controller is not yet developed. It is a draft VC

 */
// TODO: - It will be necessary to transform the address received from the previous VC into a POI (with latitude and longitude, via an API?) then display this point on the map.

class AdressMapViewController: UIViewController, MKMapViewDelegate {
    // MARK: - Properties
    var adressLabel: String?
    let defaultPosition = CLLocationCoordinate2D(latitude: 47.443555, longitude: 6.822343)

    // MARK: - IBOutlets
    @IBOutlet weak var ui_map: MKMapView!
    @IBOutlet weak var mapTypeSegmet: UISegmentedControl!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_map.delegate = self
        // Do any additional setup after loading the view.
        initMapConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(adressLabel!)
    }

    // MARK: - IBActions
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func ChangeMapTypeButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 : ui_map.mapType = MKMapType.standard
        case 1 : ui_map.mapType = .satellite
        case 2 : ui_map.mapType = .hybrid
        default: break
        }

    }

    // MARK: - Methods
    func initMapConfiguration() {
        ui_map.setRegion(MKCoordinateRegion(center: defaultPosition, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: false)

        let poi = MKPointAnnotation()
        poi.coordinate = defaultPosition
        poi.title = "Mandeure"
        poi.subtitle = "Gymnase du Club"
        ui_map.addAnnotation(poi)
    }

}
