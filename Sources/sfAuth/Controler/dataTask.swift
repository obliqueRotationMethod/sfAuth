//
//  File.swift
//  Learning
//
//  Created by Max Burkhardt on 23.09.18.
//  Copyright © 2018 Max Burkhardt. All rights reserved.
//

import Foundation

class ODataService {
    func ODataCall(request: URLRequest, system: System, completion: @escaping (Result<[[String: AnyObject]]>) -> (Void)) {
        
        var anticipatedStatusCode = 0
        var neededJson = ""
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {return completion(.Error(error!.localizedDescription))}
            
            let dataString = String(data: data!, encoding: .utf8)
            print(dataString ?? "keine Daten in URLSession angekommen")
            
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == anticipatedStatusCode else {
                return completion(.Error("StatusCode = \(response.statusCode) Bitte melden Sie diesen Fehlercode der IT"))}
            
                guard let data = data else {return completion(.Error(error?.localizedDescription ?? "data im Call war leer"))}
            let string = String(data: data, encoding: .utf8)
            print(string ?? "kam keine data an")

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                        guard let studentJson = json[neededJson] as? [[String: AnyObject]] else {
                            return completion(.Error(error?.localizedDescription ?? "JSON Parsing LMS des Calls war nicht möglich"))
                        }
                        DispatchQueue.main.async { completion(.Success(studentJson)) }
                    }
                }
                catch let error { return completion(.Error(error.localizedDescription)) }

            }.resume()
        }
    }

enum Result <T> {
    case Success(T)
    case Error(String)
}

enum System: String {
    case SF
    case LMS
}
