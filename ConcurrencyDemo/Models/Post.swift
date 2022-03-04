//
//  Post.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import Foundation

// source: https://jsonplaceholder.typicode.com/posts
// Single user's Posts:https://jsonplaceholder.typicode.com/users/1/posts

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}





