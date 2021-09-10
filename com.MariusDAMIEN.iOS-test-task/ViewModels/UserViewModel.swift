//
//  UserViewModel.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 09/09/2021.
//

import Foundation

class UserViewModel {
    
    private var api = Api()
    private var user = [User]()
    
    
    
    func fetchUserData(completion: @escaping () -> ()) {
        
        // weak self - prevent retain cycles
        api.getUserData { [weak self] (result) in
            switch result {
            case .success(let ret):
                self?.user.append(ret)
                completion()
            case .failure(let error):
                print("Error json data: \(error)")
            }
        }
    }

    
    func getUser() -> User {
        return self.user[0]
    }
    

    
}
