//
//  ViewController.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import UIKit
import MapKit
import SwiftSpinner
import SHSnackBarView

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    private var mapviewViewModel : MapViewViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centerMapOnLocation(regionRadius: CLLocationDistance, location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController : MapView {
    
    func annotateRegions(regions: [PSIRegion]?) {
        
        DispatchQueue.main.async {
            guard let regions = regions else {
                return
            }
            
            let previousAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(previousAnnotations)
            
            for region in regions {
                
                guard let latitude = region.label_location?.latitude else {
                    continue
                }
                
                guard let longitude = region.label_location?.longitude else {
                    continue
                }
                
                let regionAnnotation = MKPointAnnotation()
                
                if let name = region.name {
                    regionAnnotation.title = name
                    regionAnnotation.subtitle = self.mapviewViewModel.getReadings(of: name).toString()
                }
                regionAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.mapView.addAnnotation(regionAnnotation)
            }
        }
    }
    
    func showRegionPSI(readings: PSIReadings?) {
        
        
    }
    
    func showRegionPSIDetailts(region: PSIRegion) {
        
    }

    func loadContent() {
        
        showLoading(show: true)
        
        if (self.mapviewViewModel == nil) {
            mapviewViewModel = MapViewViewModel(with: "https://api.data.gov.sg/v1/environment/psi", apiKey: "B5FywOte5AKpgldqG1Hgvutk3l3XMzmh")
        }
        
        mapviewViewModel.getPSIRegions(date: Date()) { (psiRegions, error) in
            
            self.showLoading(show: false)
            if let regions  = psiRegions {
                self.annotateRegions(regions: regions)
            }
            else {
                self.showError(message: "Failed to retrieve the psi readings!")
            }
        }
    }
    
    func showLoading(show: Bool) {
        
        DispatchQueue.main.async {
            if show {
                SwiftSpinner.show("Loading..")
            }
            else {
                SwiftSpinner.hide()
            }
        }
    }
    
    func showError(message: String) {
        
        DispatchQueue.main.async {
            let snackbarView = snackBar()
            snackbarView.showSnackBar(view: self.view, bgColor: UIColor.red, text: message, textColor: UIColor.white, interval: 5)
        }
    }
}

extension ViewController : MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        loadContent()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else{
            return nil
        }
        
        let annotationViewIdentifier = "ANNOTATIONS_VIEW_IDENTIFIER"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewIdentifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationViewIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}

