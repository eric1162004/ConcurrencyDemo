//
//  PostsListViewModel.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import Foundation

class PostsListViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    var userId: Int?
    
    @Published var isLoading = false
    
    func fetchPosts() {
        if let userId = userId {
            
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            
            isLoading.toggle()
            
            apiService.getJSON { (result: Result<[Post], APIError>) in
                
                defer {
                    DispatchQueue.main.async {
                        isLoading.toggle()
                    }
                }
                
                switch result {
                case .success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension PostsListViewModel {
    convenience init(forPreview: Bool = false){
        self.init()
        if forPreview {
            self.posts = Post.mockPosts
        }
    }
}

