//
//  FlickerViewModel.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 2.02.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import Foundation

protocol FlickerViewModelDelegate {
    func requestCompleted()
}

class FlickerViewModel {
    var allPhotos = [Photo]()
    var delegate: FlickerViewModelDelegate?
    var pageNumber = 0
    let apiClient = APIClient()
}

extension FlickerViewModel {
    
    func getValues() {
        self.pageNumber+=1
        apiClient.getRecentPhotos(pageNumber: pageNumber) { (Photos) in
            for photo in Photos.photos.photo {
                self.allPhotos.append(photo)
            }
            self.delegate?.requestCompleted()
        }
    }
}
