//
//  RemoteAPI.swift
//  E-testing
//
//  Created by tom on 20.12.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import Foundation

class RemoteAPI {
    
    static let sharedInstance = RemoteAPI()
    
    var authorizationHeader = String()
    let baseUri = "http://mobileapi-test.patria-direct.cz/"
    
    
    func makeGetRequest(url : String, headers: [String : String] = ["" : ""], completionHandler: (statusCode: Int?, responseError: NSError?, responseData: NSData?) -> ())
    {
        let requestedUrl = NSURL(string: self.baseUri+url)
        let request = NSMutableURLRequest(URL: requestedUrl!)
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            if let httpResponse = response as? NSHTTPURLResponse {
                completionHandler(statusCode: httpResponse.statusCode, responseError: error, responseData: data)
            }
            
        }
        task.resume()
        
    }
    
    
    func makePostRequest(url : String, jsonData: String? = nil, headers: [String : String] = ["" : ""], completionHandler: (statusCode: Int?, responseError: NSError?, responseData: NSData?) -> ())
    {
        let requestedUrl = NSURL(string: self.baseUri+url)
        let request = NSMutableURLRequest(URL: requestedUrl!)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        if let json = jsonData{
            request.HTTPBody = json.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            let httpResponse = response as! NSHTTPURLResponse
            completionHandler(statusCode: httpResponse.statusCode, responseError: error, responseData: data)
        }
        task.resume()
        
    }
    
    func makePutRequest(url : String, jsonData: String? = nil, headers: [String : String] = ["" : ""], completionHandler: (statusCode: Int?, responseError: NSError?, responseData: NSData?) -> ())
    {
        let requestedUrl = NSURL(string: self.baseUri+url)
        let request = NSMutableURLRequest(URL: requestedUrl!)
        request.HTTPMethod = "PUT"
        request.allHTTPHeaderFields = headers
        
        if let json = jsonData{
            request.HTTPBody = json.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let task = session.dataTaskWithRequest(request){
            data, response, error in
            let httpResponse = response as! NSHTTPURLResponse
            completionHandler(statusCode: httpResponse.statusCode, responseError: error, responseData: data)
        }
        task.resume()
        
    }
    
}