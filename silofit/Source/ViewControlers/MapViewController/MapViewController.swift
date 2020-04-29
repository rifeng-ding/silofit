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

    var viewModel: MapViewModel

    let locationManager = CLLocationManager()
    let defaultCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    private(set) var mapView: MKMapView = {

        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    init(viewModel: MapViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        
        self.title = self.viewModel.title

        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(logoutButtonTouchUpInside))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(listViewButtonTouchUpInside))
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
            self.loadSpaces()
        }
        self.mapView.showsUserLocation = true
    }
    
    private func loadSpaces() {
        
        self.viewModel.loadSpaces { [weak self] (result) in
            
            guard let weakSelf = self else {
                return
            }
            
            switch result {
            case .success:
                let oldAnnotations = weakSelf.viewModel.currentMapAnnotations
                let newAnnotations = weakSelf.viewModel.generateMapAnnotations()
                weakSelf.updateAnntations(from: oldAnnotations, to: newAnnotations)
                break
            case .failure(let error):
                let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
                    weakSelf.loadSpaces()
                }
                weakSelf.presentAlert(forError: error,
                                   withTitle: "Cannot load spaces...",
                                   action: retryAction)
            }
        }
    }
    
    private func logout() {
        
        self.viewModel.logout { [weak self] (result) in
            switch result {
            case .success:
                self?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                // TODO: not sure whether this is the correct error handling
                let action = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                    self?.dismiss(animated: true, completion: nil)
                }
                self?.presentAlert(forError: error, withTitle: "Please re-login", action: action)
            }
        }
    }
    
    func updateAnntations(from oldAnnotations: [MKAnnotation],
                          to newAnnotations: [MKAnnotation]) {
        
        self.mapView.removeAnnotations(oldAnnotations)
        for annotation in newAnnotations {
            self.mapView.addAnnotation(annotation)
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
        
        let viewModel = SpaceListViewModel(spaces: self.viewModel.spaces,
                                           currentCoordinate: self.mapView.userLocation.coordinate)
        let listViewController = SpaceListViewController(viewModel: viewModel)
        let navigationController = StyledNavigationController(rootViewController: listViewController)
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}
