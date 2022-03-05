//
//  user.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import Foundation

// source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable{
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let test: String
}
