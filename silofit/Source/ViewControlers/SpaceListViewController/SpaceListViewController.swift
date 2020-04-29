//
//  SpaceListViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit
import CoreLocation

class SpaceListViewController: BaseViewController {

    private let collectionView: UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Spacing.large
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = StyleColor.scrollViewBackground
        collectionView.register(SpaceListCell.self, forCellWithReuseIdentifier: SpaceListCell.reuseIdentifer)
        return collectionView
    }()

    let viewModel: SpaceListViewModel

    init(viewModel: SpaceListViewModel) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {

        self.view.backgroundColor = StyleColor.background
        self.title = "Spaces Near You"

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(mapViewButtonTouchUpInside))
    }

    // MARK: Selector Methods
    @objc func mapViewButtonTouchUpInside() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SpaceListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.viewModel.numberOfCells()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpaceListCell.reuseIdentifer,
                                                      for: indexPath) as! SpaceListCell
        cell.nameLabel.text = self.viewModel.nameLabel(for: indexPath)
        cell.infoLabel.text = self.viewModel.basicInfoLabel(for: indexPath)
        cell.distanceLabel.text = self.viewModel.distanceLabel(for: indexPath)
        cell.imageView.loadImage(from: self.viewModel.imageURL(for: indexPath))
        cell.width = collectionView.frame.width

        return cell
    }
}

extension SpaceListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let imageURLs = self.viewModel.imageURLs(for: indexPath)
        let title = self.viewModel.title(for: indexPath)
        let viewModel = GalleryViewModel(title: title, imageURLs: imageURLs)
        let galleryViewController = GalleryViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(galleryViewController, animated: true)
    }
}
