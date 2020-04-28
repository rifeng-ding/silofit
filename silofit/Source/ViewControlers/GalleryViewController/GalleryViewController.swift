//
//  GalleryViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-28.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class GalleryViewController: BaseViewController {
    
    private(set) var viewModel = GalleryViewModel(imageURLs: [])
    
    private let collectionView: UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = StyleColor.scrollViewBackground
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(GalleryImageCell.self, forCellWithReuseIdentifier: GalleryImageCell.reuseIdentifer)

        return collectionView
    }()
    
    init(imageURLs: [URL]) {
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = GalleryViewModel(imageURLs: imageURLs)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .allButUpsideDown
    }
    
    override var shouldAutorotate: Bool {
        
        return true
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
    }
    
    override func setupUI() {
        
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryImageCell.reuseIdentifer, for: indexPath) as! GalleryImageCell
        
        cell.imageView.loadImage(from: self.viewModel.imageURL(at: indexPath))
        cell.size = collectionView.frame.size
        return cell
    }
}
