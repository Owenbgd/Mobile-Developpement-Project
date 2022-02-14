//
//  Request.swift
//  PearEvent
//
//  Created by goldorak on 07/02/2022.
//
import UIKit
import Foundation

protocol RequestFactoryProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params:
    [String]?) -> URLRequest
    func getInformationList(callback: @escaping (Dictionary<String, Any>) -> Void)
    func deleteInformation(with id: String, callback: @escaping ((errorType:
                                                                    CustomError?, errorMessage: String?), Response?) -> Void)
    func convertStringToDictionary(text: String) -> [String:AnyObject]?
}
private let informationUrlStr =
"https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule?view=Full%20schedule"

class RequestFactory: RequestFactoryProtocol {
    internal func createRequest(urlStr: String, requestType: RequestType, params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
        if let params = params {
            var urlParams = urlStr
            for param in params {
                urlParams = urlParams + "/" + param
            }
            url = URL(string: urlParams)!
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        request.httpMethod = requestType.rawValue
        
        let accessToken = "keyVfedOLvj65TTQS"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization")
        return request
    }
    func getInformationList(callback: @escaping (Dictionary<String, Any>) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: informationUrlStr, requestType: .get, params: nil)) {
            data, response, error in
            guard
                error == nil,
                let data = data
            else {
                print(error ?? "Autre erreur")
                return
            }
            
            guard
                let responseHttp = response as? HTTPURLResponse,
                (200 ..< 300) ~= responseHttp.statusCode
            else {
                print("Requête impossible, statusCode ≠ 200")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                callback(json as! Dictionary<String, Any>)
            } catch _ {
                print("Erreur dans la sérialisation du retour JSON")
                return
            }
        }
        task.resume()
    }
    func deleteInformation(with id: String, callback: @escaping ((errorType: CustomError?, errorMessage: String?), Response?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: informationUrlStr, requestType: .delete, params: [id])) { (data, response, error) in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try?
                            JSONDecoder().decode(Response.self, from: data) {
                            callback((nil, nil), response)
                        }
                        else if let response = try?
                                    JSONDecoder().decode(ErrorResponse.self, from:
                                                            data) {
                            callback((CustomError.requestError,
                                      response.error), nil)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError,
                          error.debugDescription), nil)
            }
        }
        task.resume()
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}




