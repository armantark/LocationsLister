//
//  TextViewViewController.swift
//  LocationsLister
//
//  Created by Arman Tarkhanian on 7/3/15.
//  Copyright (c) 2015 Arman Tarkhanian. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TextViewViewController: UIViewController {
    @IBOutlet weak var searchResultsText: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    override func viewDidLoad(){
        search()
    }
    @IBAction func searchButton(sender: UIBarButtonItem) {
        search()
    }
    
    
    func search(){
        
        matchingItems.removeAll()
        var center = CLLocationCoordinate2D(latitude: 42.00, longitude: -117.00)
        var span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
        var region = MKCoordinateRegionMake(center, span)
        var request = MKLocalSearchRequest()
        var counter = 0
        request.naturalLanguageQuery = "Pizza"
        
        mapView.region.center.latitude = 42.00
        mapView.region.center.longitude = -117.00
        mapView.region.span = span
        
        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({(response:
            MKLocalSearchResponse!,
            error: NSError!) in
            
            if error != nil {
                println("Error occured in search: \(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                println("No matches found")
            } else {
                println("Matches found")
                for item in response.mapItems as [MKMapItem] {
                    println("Name = \(item.name)")
                    println("Phone = \(item.phoneNumber)")
                    self.matchingItems.append(item as MKMapItem)
                    println("Matching items = \(self.matchingItems.count)")
                    
                    var annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
            if !response.mapItems.isEmpty {
            }
        })
        
    }
}


