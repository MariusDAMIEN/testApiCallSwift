//
//  PhotoViewModel.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 10/09/2021.
//

import Foundation

class PhotoViewModel {
    
    private var api = Api()
    private var photos = [Photo]()


    func fetchPhotosData(id: String, completion: @escaping () -> ()) {
        
        api.getPhotosData(id: id) { [weak self] (result) in
            switch result {
            case .success(let photoList):
                self?.photos = photoList
                completion()
            case .failure(let error):
                print("Error json data: \(error)")
            }
        }
    }
    
    func getPhotos() -> [Photo] {
        return self.photos
    }
    
    

    func photoNumbers(section: Int) -> Int {
        return photos.count != 0 ?  photos.count : 0
    }
    
    func photoCell(i: IndexPath, filter: [Photo]) -> Photo {
        return filter[i.row]
    }
    
}
