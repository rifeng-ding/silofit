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

    var viewModel = MapViewControllerViewModel(spaces: [])

    private let mapView: MKMapView = {

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


    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        if !self.viewModel.isValid {
            self.loadSpaces { (spaces) in
                self.viewModel = MapViewControllerViewModel(spaces: spaces)
            }
        }
    }

    // MARK: - Data Fetching
    func loadSpaces(completion: @escaping ([Space]) -> Void ) {

        DataManager.fetchAllSpaces { (result) in
            switch result {
            case .success(let spaces):
                completion(spaces ?? [])
            case .failure(let error):
                let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
                    self.loadSpaces(completion: completion)
                }
                self.presentAlert(forError: error,
                                  withTitle: "Cannot load spaces...",
                                  action: retryAction)
                completion([])
            }
        }

    }

    // MARK: - Bar Button Actions
    @objc private func logoutButtonTouchUpInside() {

        AuthenticationManager.shared.logout { (error) in
            guard let error = error else {
                self.dismiss(animated: true, completion: nil)
                return
            }
            print("Logout failed: \(error.localizedDescription)")
            // TODO: do a alert then dismiss
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc private func listViewButtonTouchUpInside() {
        
        print("Switch to list view")
    }
}
