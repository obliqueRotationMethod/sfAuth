//
//  SFOAuthService.swift
//  Learning2
//
//  Created by Max Burkhardt on 24.12.18.
//  Copyright © 2018 Max Burkhardt. All rights reserved.
//

import Foundation

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

class SFOAuthService {
    
    func SFSAML (userID: String, password: String, tenant: Tenants, completion: @escaping (Result<String>) -> ()) {
        
        let baseUrl = URL(string: tenant.rawValue)!
        let tokenURL = baseUrl.appendingPathComponent("oauth/idp")
//        let combinedUserCredentials: String = "\(userID)@\(company):\(password)"

    // TOKEN
        let SFPrivateToken: String =  "TUlJRXZBSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS1l3Z2dTaUFnRUFBb0lCQVFDbU5aUHN4bEpSdmxpVW4yNndxUUpWK0ZQOCtzTnp4amxtYytBU0pPRnFSQi9HVzA2ZTRMdEs1bUZQMlc5cy85RzRIem1Hejg2SHhwRkxvTWxPd1pSUWs4NjZ5bi9LR2pnTXpoY0hacUNHNGEzY0wrRGIvcnVNRVN5VXZzaHE5WUV4QlhFYm15YTZoWVVQM2pZK2FrNmY2c2JpRlFiMUhlcExoandQSVlBUmlGR0xKQjRSRDU5azh6Zk9YMUhFS2ZhSnF2L3hZNXNDa0dWbzc4K3FsOEowbUwyd2JRVUd1WGovMzEvM1dubC9TdHBmMjg0U2U5TzNzNmxIMER0Yi9TVG1CaVN2azJZS0E4N2E2OWQxTW1ZZDZ4VEdieWpMVkZuYzNkbWRJd3R2MU1EREg3OVdMTXdZWTI3OVA0MEtwYTgzb1R1K0JFQXU1blNncyt1Z2hIUkxBZ01CQUFFQ2dnRUFaU3o4TFFmVW1IbjhSZ3gvUHY3Q3N6NkZNZHdjR2wreUZWRzROcE5JdkgxWHNsRm1uSVJFdnFWYTIxYUs0NWtlT3F5WFFoOUJvNWtXWFNrMUljSG8zTnY4M2V2aXVrNFhqSVB2dE11ZU1EMDBybkpldU14cHNpdktMWW10U3A3RDArbHlIdEhsVTJsdnhHY0tNaGhZWURSMGVLOUFHdm5vNDZ5RTV0a0hzcU9DYjYzeDN2ZFo0R05Dbk1kNm04MG8yZWp4THdEaVFRZ0sxSW04elJHK2w0V3c3WUY2U3ozZHZKSUQ5bEo1eEd1SlNpbXFVZjB5SjNGYklWNTVKMHc5cytUcDJhS2JocldWclFzRmc1Z1ZMUndmUnBSNEFnRVBEaFB3SUMxajZhTTk5SVI4bW9ZQVNiMGpsNytscWJBUE1TblJhUm5CUTdXS1BMWmdTcUpuVVFLQmdRRGlxM3lQWjQ3N01mY0ExU29HdE45NlVlNWxzZTljblE0STRyY2ZYVnpONmhoSTRnT1ZDSkFVMFlsV3Z1YnZ6Sy96aytUcVptZUJ6dStnRHgya3Nqc2JVc2Z1UW1lOEZpcU41cGNpallNcDBhTS96dThRSWpCVEw0cVh6WUQvczlnUjZtYVEraGRDY1ZJWE5Pc0thaHlWVlRrUyttUC9PSWJ1WEdLMm9aSUtaUUtCZ1FDN3QxQ1ZoY0IvZnQyTVFWV3dyeDFIbDJjYnNTbTRyZlNQTUhLM0thYWlmM1owcUU0YU1WNU10N2FCZjZvWVBVRmZsRnlCaFJlKzU0WWxrVERPd3hWV0o2T0RXWmlEdGlsSXZab3BKc3E3MzRyakd2bW9BM2owYTNleEI2VEtyMW5aQWdIdURnbGc4ZDQzYkJ3Ynl0MG9nZUEwY3phajdjdDhDVnFWRFUzQTd3S0JnRFgvL3F1M1V5UGEwbXA3WGdpOC9HU0tzazI5NXpWY0lTVFN4aWVOdVhkQTVzb3VOZ1pDUlBrQXRrUlpOSEU2aFV4MUZsc1ZUR0ZyYUVEc2VQWnNrNUk5MVcyWW1sZi91K0dVWnJzUGxZalg3WmxjOWkwVXlBaDVVZjQ2TWhvNHdTZjdmTFhiTHNGZ2Q5c1plMGsrNEZKZlBEcWVOa1p1TkE4REtXMHk3clRWQW9HQUhTd3pDTm05ZmRMd2lXQ0orYWh0UzNmN0hUR2VRMFk5a0pjOTdMczdXMXVseENGMzZkZ3NTSTN3ZmhXaUVKeE1jWmN6L1NqNjlMODBlTmdrbHExNHZtZndvSFFuSUtrSnAzVlg1UGRUWUhrd00zVTR3V1N3d29PRkdXMFByalFzS1c2SGNFQ2NNb1hFUENiQUE0MjJheG9zQnRxMDdpc0JpYWhHZkkyUnZOOENnWUExN0IxQ1FCdXN5RXhtNHdpUy9hc2pTdHg1N2Vvdk1EUWdSNVRnNUZWa2lBMVVhaytWTDBnaldhbklGUWdKbitjeHV6LzdPVWZmQjFkckF4ZktyT0xORDdKeE9obVRxUUNCRUJVUytyeURISVExejZMbUdHTUwvZmdYV2VLMzZzbHFDcVlPZm9DQjlDWVpPWkk5VnRoUnVsbGZIMzFLT2RmNCtsZGUxSnVmRkE9PSMjI2FsZGlzdWVkVGVzdA=="
    
        let clientId = "YjhhOTQ2YzljMDYyOWJmYmZjZDU1M2FmMWFkNQ" //API Key in SF
        let token_url = "\(tenant.rawValue)oauth/token" //Application URL aus SF?!?!?!?!?
        let stringBody = "user_id=\(userID)&client_id=\(clientId)&token_url=\(token_url)&private_key=\(SFPrivateToken.fromBase64() ?? "")"
        
        let dataBody = stringBody.data(using: .utf8)

        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("Basic \(combinedUserCredentials)", forHTTPHeaderField: "Authorization")
        request.httpBody = dataBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {return completion(.Error(error!.localizedDescription))}
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else { return completion(.Error("StatusCode = \(response.statusCode)")) }
            
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "data im Call war leer")) }

            do {
                if let result = String(data: data, encoding: .utf8){
                    DispatchQueue.main.async {
                        completion(.Success(result))}
                }
            }
            catch let error { return completion(.Error(error.localizedDescription)) }
            }.resume()
        }
    
    
    func SFToken(userID: String, password: String, assertion: String, tenant: Tenants, completion: @escaping (Result<[String: AnyObject]>) -> ()) {
            var company: String = ""
        if tenant == .SFPRD {
            company = "aldisued" }
        else if tenant == .SFTST {
                company = "aldisuedTest"
        } else {}
            
            let baseUrl = URL(string: tenant.rawValue)!
            let tokenURL = baseUrl.appendingPathComponent("oauth/token")
//        let combinedUserCredentials: String = "\(userID)@\(company):\(password)"
        
            // TOKEN
        
            let clientId = "YjhhOTQ2YzljMDYyOWJmYmZjZDU1M2FmMWFkNQ" //API Key in SF
            let stringBody = "company_id=\(company)&client_id=\(clientId)&grant_type=urn:ietf:params:oauth:grant-type:saml2-bearer&assertion=\(assertion)"
        
            print("Der SFToken Call Body ist: \(stringBody)")
        
            let dataBody = stringBody.data(using: .utf8)
            
            var request = URLRequest(url: tokenURL)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.setValue("Basic \(combinedUserCredentials)", forHTTPHeaderField: "Authorization")
            request.httpBody = dataBody
        
        
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard error == nil else {return completion(.Error(error!.localizedDescription))}
                guard let response = response as? HTTPURLResponse else { return }
                let string = String(data: data!, encoding: .utf8)
                print(string!)
                
                guard response.statusCode == 200 else { return completion(.Error("StatusCode = \(response.statusCode)"))}

                guard let data = data else { return completion(.Error(error?.localizedDescription ?? "data im Call war leer")) }
                
                do {
                    if let result = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject]{
                        
                        DispatchQueue.main.async {
                            completion(.Success(result))}
                    }
                }
                catch let error { return completion(.Error(error.localizedDescription)) }
                }.resume()
            }
        }
