//
//  UsesListView.swift
//  ConcurrencyDemo
//
//  Created by eric on 2022-03-04.
//

import SwiftUI

struct UsesListView: View {
    
    #warning("remove the forPreview argument or set it to false before shipping")
    @StateObject var vm = UsersListViewModel(forPreview: false)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.users) { user in
                    
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                            Text(user.email)
                        }
                    }
                    
                }
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView()
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear {
                vm.fetchUsers()
            }
        }
    }
    
}

struct UsesListView_Previews: PreviewProvider {
    static var previews: some View {
        UsesListView()
    }
}
