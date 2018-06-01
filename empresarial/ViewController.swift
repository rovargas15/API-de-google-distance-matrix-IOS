//
//  ViewController.swift
//  empresarial
//
//  Created by Rafael Vargas on 31/05/18.
//  Copyright © 2018 Rafael vargas. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController, UISearchDisplayDelegate {
    
    var searchOrigenController: UISearchController?
    var searchDestinoController: UISearchController?
    var Origen: CLLocation?
    var Destino: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        init_searchController()
    }
    
    func init_searchController() {
        let resultsOrigenViewController = GMSAutocompleteResultsViewController()
        resultsOrigenViewController.delegate = self
        
        searchOrigenController = UISearchController(searchResultsController: resultsOrigenViewController)
        searchOrigenController?.searchResultsUpdater = resultsOrigenViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 80.0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchOrigenController?.searchBar)!)
        view.addSubview(subView)
        searchOrigenController?.searchBar.sizeToFit()
        searchOrigenController?.hidesNavigationBarDuringPresentation = false
        
        
        let resultsViewDestinoController = GMSAutocompleteResultsViewController()
        resultsViewDestinoController.delegate = self
        
        searchDestinoController = UISearchController(searchResultsController: resultsViewDestinoController)
        searchDestinoController?.searchResultsUpdater = resultsViewDestinoController
        
        let subView2 = UIView(frame: CGRect(x: 0, y: 160.0, width: 350.0, height: 45.0))
        
        subView2.addSubview((searchDestinoController?.searchBar)!)
        view.addSubview(subView2)
        searchDestinoController?.searchBar.sizeToFit()
        searchDestinoController?.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
    }
    
    
    @IBAction func btnCal(_ sender: UIButton) {
         if  Util.isConnectedToNetwork() == true {
            
            let origenLat:String = String(format:"%f",(Origen?.coordinate.latitude)!)
            let origenLong:String = String(format:"%f",(Origen?.coordinate.longitude)!)
      
            let destinoLat:String = String(format:"%f",(Destino?.coordinate.latitude)!)
            let destinoLong:String = String(format:"%f",(Destino?.coordinate.longitude)!)
            
            let origin:String = "&origins=\(origenLat),\(origenLong)"
            let destination:String = "&destinations=\(destinoLat),\(destinoLong)"
            let key:String = "&key=AIzaSyAQBSiBxEt3Gjg4r6E2cNqHrNP9HLBptgI"
            let language:String = "&language=es";
            
            let url:String =  origin + destination + key + language;
            
            APIManager.sharedInstance.getArray(endpoint: url,onSuccess: { json in
                DispatchQueue.main.async {
                    if let data = DataModel(json: json) {
                        DispatchQueue.main.async {
                            self.alert(message: data.rows[0].elements[0].distance.text)
                        }
                    }
                }
                
            }, onFailure: { error in
              
            })
        
         }else{
            let alert = UIAlertController(title: "Error", message: "Sin conexion.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func alert(message:String){
        let alert = UIAlertController(title: "Distancia", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_limpiar(_ sender: UIButton) {
        searchOrigenController?.searchBar.text = ""
        searchDestinoController?.searchBar.text = ""
    }
    
    
}
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        
        if (searchOrigenController?.isActive)!{
            searchOrigenController?.isActive = false
            searchOrigenController?.searchBar.text = place.name
            Origen = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }else{
            searchDestinoController?.isActive = false
            searchDestinoController?.searchBar.text = place.name
            Destino = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
       
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: ", error.localizedDescription)
    }
    
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
