//
//  GalleryViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-28.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

struct GalleryViewModel {
    
    let imageURLs: [URL]
    
    init(imageURLs: [URL]) {
        
        self.imageURLs = imageURLs
    }
    
    func numberOfCells() -> Int {
        
        return self.imageURLs.count
    }
    
    func imageURL(at indexPath: IndexPath) -> URL {
        
        return self.imageURLs[indexPath.row]
    }
}
