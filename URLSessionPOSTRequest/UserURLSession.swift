//
//  UserURLSession.swift
//  URLSessionPOSTRequest
//
//  Created by ramil on 18.05.2021.
//

import Foundation

class UserURLSession {
    static let shared = UserURLSession()
    
    func userPostRequest(completionHandler: @escaping (User) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reqres.in"
        components.path = "/api/users"
        
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let firstUser = User(name: "morpheus", job: "leader", id: nil, dateCreated: nil)
        
        guard let httpBody = try? JSONEncoder().encode(firstUser) else {
            print("Invalid httpBody")
            return
        }
        
        let secondUser = ["name" : "morpheus", "job" : "leader"]
        guard (try? JSONSerialization.data(withJSONObject: secondUser, options: [])) != nil else {
            return
        }
        
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
                    let user = try decoder.decode(User.self, from: data)
                    completionHandler(user)
                } catch(let error) {
                    print(error.localizedDescription)
                }
            } else {
                print("No Data")
            }
        }.resume()
    }
}

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_us_POSIX")
        return formatter
    }()
}
