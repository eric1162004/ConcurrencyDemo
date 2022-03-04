//
//  MockData.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import Foundation

extension User {
    
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    
    static var mockingSingleUser: User {
        Self.mockUsers[0]
    }
}

extension Post {
    
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    
    static var mockingSinglePost: Post {
        Self.mockPosts[0]
    }
    
    static var mockSingleUserPostsArray: [Post] {
        Self.mockPosts.filter { $0.id == 1 }
    }
}
