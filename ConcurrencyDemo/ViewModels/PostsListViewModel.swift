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
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    
    @MainActor
    func fetchPosts() async {
        if let userId = userId {
            
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            
            isLoading.toggle()
            
            defer {
                isLoading.toggle()
            }
            
            do {
                posts = try await apiService.getJSON()
            } catch {
                showAlert = true
                errorMessage = error.localizedDescription
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

