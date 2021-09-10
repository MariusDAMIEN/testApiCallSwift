//
//  AlbumViewModel.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 10/09/2021.
//

import Foundation

class AlbumViewModel {
    
    private var api = Api()
    private var albums = [Album]()



    func fetchAlbumsData(completion: @escaping () -> ()) {
        
        api.getAlbumsUser { [weak self] (result) in
            switch result {
            case .success(let albumsList):
                self?.albums = albumsList
                completion()
            case .failure(let error):
                print("Error json data: \(error)")
            }
        }
    }
    
    func rowNumbers(section: Int) -> Int{
        return albums.count != 0 ?  albums.count : 0
    }
    
    func rowCell(i: IndexPath) -> Album {
        return albums[i.row]
    }
    
}
