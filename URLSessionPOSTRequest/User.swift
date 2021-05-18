//
//  User.swift
//  URLSessionPOSTRequest
//
//  Created by ramil on 18.05.2021.
//

import Foundation

struct User: Codable {
    var name: String
    var job: String
    var id: String?
    var dateCreated: Date?
    
    var modifiedID: String {
        if let newId = id {
            return newId
        } else {
            return "*****"
        }
    }
    
    var modifiedDateCreated: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let newDate = dateCreated {
            return dateFormatter.string(from: newDate)
        } else {
            return "******"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case job
        case id
        case dateCreated = "createdAt"
    }
}
