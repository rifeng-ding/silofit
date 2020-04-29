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

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

        let region = MKCoordinateRegion(center: userLocation.coordinate,
                                        span: self.defaultCoordinateSpan)
        mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? SpacePointAnnotation else {
            return nil
        }

        let identifier = MKMarkerAnnotationView.reuseIdentifer
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
}
