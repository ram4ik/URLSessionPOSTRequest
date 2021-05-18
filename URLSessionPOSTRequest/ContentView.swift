//
//  ContentView.swift
//  URLSessionPOSTRequest
//
//  Created by ramil on 18.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State var user = User(name: "*****", job: "*****", id: nil, dateCreated: nil)
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    Section(header: Text("Our Data")) {
                        Text("Name: \(user.name)")
                        Text("Job: \(user.job)")
                        Text("ID: \(user.modifiedID)")
                        Text("Date created: \(user.modifiedDateCreated)")
                    }
                }
                .listStyle(GroupedListStyle())
                Button(action: {
                    DispatchQueue.main.async {
                        UserURLSession.shared.userPostRequest { newUser in
                            user = newUser
                        }
                    }
                }, label: {
                    Text("POST Request")
                })
                .padding()
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(8)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("POST Request")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
