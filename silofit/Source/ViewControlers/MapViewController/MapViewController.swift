//
//  MapViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    var viewModel = MapViewControllerViewModel(spaces: []) {
        
        didSet {
            self.updateAnntations(from: oldValue.mapAnnotations,
                                  to: self.viewModel.mapAnnotations)
        }
    }

    let locationManager = CLLocationManager()
    let defaultCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    private(set) var mapView: MKMapView = {

        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override func setupUI() {

        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        let logoutButton = UIBarButtonItem(title: "Logout",
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutButtonTouchUpInside))
        self.navigationItem.leftBarButtonItem = logoutButton

        let listViewButton = UIBarButtonItem(title: "List",
                                           style: .plain,
                                           target: self,
                                           action: #selector(listViewButtonTouchUpInside))
        self.navigationItem.rightBarButtonItem = listViewButton
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        if !self.viewModel.isValid {
            self.loadSpaces { (spaces) in
                self.viewModel = MapViewControllerViewModel(spaces: spaces)
            }
        }
        self.mapView.showsUserLocation = true
    }

    // MARK: - Data Fetching
    func loadSpaces(completion: @escaping ([Space]) -> Void ) {

        DataManager.fetchAllSpaces { [weak self] (result) in
            switch result {
            case .success(let spaces):
                completion(spaces ?? [])
            case .failure(let error):
                let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
                    self?.loadSpaces(completion: completion)
                }
                self?.presentAlert(forError: error,
                                  withTitle: "Cannot load spaces...",
                                  action: retryAction)
                completion([])
            }
        }

    }

    private func logout() {
        switch AuthenticationManager.shared.logout() {
        case .success(_):
            self.dismiss(animated: true, completion: nil)
        case .failure(let error):
            // TODO: not sure whether this is the correct error handling
            let action = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            }
            self.presentAlert(forError: error, withTitle: "Please re-login", action: action)
        }
    }

    // MARK: - Bar Button Actions
    @objc private func logoutButtonTouchUpInside() {

        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { [weak self] (_) in
            self?.logout()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @objc private func listViewButtonTouchUpInside() {
        
        print("Switch to list view")
    }
}
