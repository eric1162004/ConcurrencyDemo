//
//  UsersListViewModel.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import Foundation

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    func fetchUsers() {
        
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        
        isLoading.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            apiService.getJSON { (result: Result<[User], APIError>) in
                
                // code in the defer block will be run
                // after data have been retrieved
                defer {
                    // since we are in a background thread,
                    // we need to switch to the main thread
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                
                switch result {
                case .success(let users):
                    DispatchQueue.main.async {
                        self.users = users
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
        
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false){
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}
