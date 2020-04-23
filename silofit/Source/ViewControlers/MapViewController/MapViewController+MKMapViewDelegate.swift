//
//  MapViewController+MKMapViewDelegate.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {

    func updateAnntations(from oldAnnotations: [MKAnnotation],
                          to newAnnotations: [MKAnnotation]) {
        self.mapView.removeAnnotations(oldAnnotations)
        for annotation in newAnnotations {
            self.mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

        let region = MKCoordinateRegion(center: userLocation.coordinate,
                                        span: self.defaultCoordinateSpan)
        mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? SpacePointAnnotation else {
            return nil
        }

        // Since MKPinAnnotationView is used, the identifer is hard-coded here.
        let identifier = "annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        let tintColor = self.viewModel.annotationViewColor(forSpaceWithIdentifer: annotation.spaceIdentifer)
        (annotationView as? MKMarkerAnnotationView)?.markerTintColor = tintColor

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
}
