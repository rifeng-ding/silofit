//
//  GalleryViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-28.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

class GalleryViewModel {
    
    let title: String?
    let imageURLs: [URL]
    
    init(title: String?, imageURLs: [URL]) {
        
        self.title = title
        self.imageURLs = imageURLs
    }
    
    func numberOfCells() -> Int {
        
        return self.imageURLs.count
    }
    
    func imageURL(for indexPath: IndexPath) -> URL {
        
        return self.imageURLs[indexPath.row]
    }
}
