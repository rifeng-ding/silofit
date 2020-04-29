//
//  GalleryImageCell.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-28.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class GalleryImageCell: UICollectionViewCell {
    
    private static let defaultSize = CGSize(width: 320, height: 260)
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    var size: CGSize {
        
        didSet {
            self.widthConstraint?.constant = self.size.width
            self.heightConstraint?.constant = self.size.height
        }
    }
    
    let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = StyleColor.scrollViewBackground
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()

        scrollView.minimumZoomScale = ImageZoomScale.minimum
        scrollView.maximumZoomScale = ImageZoomScale.maximum
        return scrollView
    }()
    
    override init(frame: CGRect) {
        
        self.size = Self.defaultSize
        
        super.init(frame: frame)
        self.scrollView.delegate = self
        self.contentView.addSubview(self.scrollView)
        self.scrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.heightConstraint = self.scrollView.heightAnchor.constraint(equalToConstant: Self.defaultSize.height)
        self.heightConstraint?.isActive = true
        self.widthConstraint = self.scrollView.widthAnchor.constraint(equalToConstant: Self.defaultSize.width)
        self.widthConstraint?.isActive = true

        self.scrollView.addSubview(self.imageView)
        self.imageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetImageZoom() {
        
        self.scrollView.zoomScale = 1
    }
}

extension GalleryImageCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.imageView
    }
}
