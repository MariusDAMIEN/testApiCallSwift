//
//  ViewController.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 09/09/2021.
//

import UIKit

class ProfileController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var userViewModel = UserViewModel()
    private var albumViewModel = AlbumViewModel()

    private var defaultcell = "cell"
    private var album: Album?
        
    // Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
        loadAlbums()
        
    }
    
    private func loadUser() {
        userViewModel.fetchUserData { [weak self] in
            let user = self!.userViewModel.getUser()
            self?.name.text = user.name
            self?.address.text = user.address!.street! + ", " + user.address!.suite! + ", " + user.address!.city! + ", " + user.address!.zipcode!
        }
    }
    
    private func loadAlbums() {
        albumViewModel.fetchAlbumsData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is AlbumController {
            let vc = segue.destination as? AlbumController
            vc?.album = self.album
        }
    }
}

extension ProfileController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.defaultcell)
        
        cell?.textLabel?.text = albumViewModel.rowCell(i: indexPath).title
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return albumViewModel.rowNumbers(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.album = albumViewModel.rowCell(i: indexPath)
        performSegue(withIdentifier: "showAlbum", sender: self)
    }
}


