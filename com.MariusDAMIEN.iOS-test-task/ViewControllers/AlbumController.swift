//
//  AlbumController.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 10/09/2021.
//

import UIKit

class AlbumController: UIViewController {
    
    // INIT ID
    var album: Album?
    
    var filter: [Photo]!

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private var photoViewModel = PhotoViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let num = 3
        let width = (self.view.frame.size.width / CGFloat(num))
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        loadAlbums()
    }
    
    private func loadAlbums() {
        photoViewModel.fetchPhotosData(id: String(album!.id)) { [weak self] in
            self!.navBar.title = self!.album?.title
            self?.filter = self?.photoViewModel.getPhotos()
            self?.collectionView.dataSource = self
            self?.collectionView.delegate = self
            self?.collectionView.reloadData()
        }
    }
    

}

extension AlbumController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.setImage(from: photoViewModel.photoCell(i: indexPath, filter: filter).url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
}

extension UIImageView {
    
    func setImage(from: String) {
        guard let imageUrl = URL(string: from) else { return }
        DispatchQueue.global().async {
        guard let imageData = try? Data(contentsOf: imageUrl) else { return }
        
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            self.image = image
            }
        }
    }
}

extension AlbumController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = []
        let photos = photoViewModel.getPhotos()

        if searchText == "" {
             filter = photos
        }
        for photo in photos {
            if photo.title.uppercased().contains(searchText.uppercased()) {
                filter.append(photo)
            }
        }
        self.collectionView.reloadData()
    }
}
