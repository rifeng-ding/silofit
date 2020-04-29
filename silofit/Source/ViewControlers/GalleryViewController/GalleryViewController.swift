//
//  GalleryViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-28.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class GalleryViewController: BaseViewController {
    
    let viewModel: GalleryViewModel
    private var pageNumberBeforeRotation: Int?
    private var previousPage = 0
    
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GalleryImageCell.self, forCellWithReuseIdentifier: GalleryImageCell.reuseIdentifer)

        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = StyleColor.theme
        pageControl.pageIndicatorTintColor = StyleColor.theme.highlightedColor()
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        return pageControl
    }()

    init(viewModel: GalleryViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        
        self.title = self.viewModel.title
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.addSubview(self.pageControl)
        NSLayoutConstraint.activate([
            self.pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        self.pageControl.numberOfPages = self.viewModel.imageURLs.count
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = nil
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .allButUpsideDown
    }
    
    override var shouldAutorotate: Bool {
        
        return true
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.pageNumberBeforeRotation = self.currentPageNumber()
    }
    
    override func viewDidLayoutSubviews() {
        
        // TODO: this re-layout is not perfect.
        // The transition is not smooth.
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
        DispatchQueue.main.async {
            self.scroll(ToPage: self.pageNumberBeforeRotation ?? 0, animated: false)
        }
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
     
        self.scroll(ToPage: sender.currentPage)
    }
    
    private func currentPageNumber() -> Int {
        
        guard self.collectionView.frame.size.width > 0 else {
            return 0
        }
        
        return self.pageNumber(forContentOffsetX: self.collectionView.contentOffset.x)
    }
    
    private func pageNumber(forContentOffsetX contentOffsetX: CGFloat) -> Int {
        
         return Int(contentOffsetX / self.collectionView.frame.size.width)
    }
    
    private func scroll(ToPage pageNumber: Int, animated: Bool = true) {
        
        guard pageNumber < self.viewModel.numberOfCells() else {
            return
        }
        self.collectionView.scrollToItem(at: IndexPath(item: pageNumber, section: 0),
                                         at: .centeredHorizontally,
                                         animated: animated)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryImageCell.reuseIdentifer, for: indexPath) as! GalleryImageCell
        
        cell.imageView.loadImage(from: self.viewModel.imageURL(for: indexPath))
        cell.size = collectionView.frame.size
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        if let cell = self.collectionView.cellForItem(at: IndexPath(item: self.previousPage, section: 0)) as? GalleryImageCell {
            cell.resetImageZoom()
        }
        self.previousPage = self.pageControl.currentPage
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let previousPage = self.pageControl.currentPage
        if let cell = self.collectionView.cellForItem(at: IndexPath(item: previousPage, section: 0)) as? GalleryImageCell {
            cell.resetImageZoom()
        }
        self.pageControl.currentPage = self.currentPageNumber()
        self.previousPage = self.pageControl.currentPage
    }
}
