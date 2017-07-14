//
//  TwitterSearchKit.swift
//  TwitterSearchKit
//
//  Created by Julian Gruber on 13/07/2017.
//  Copyright © 2017 Julian Gruber. All rights reserved.
//

import UIKit

public class TwitterSearchKit: NSObject {
    
//MARK: - Constants
    
    private static let apiHostUrl:String = "https://api.twitter.com/"
    
//MARK: - Variables
    
    private static var bearerToken:String?
    
//MARK: - Private Methods
    
    //Twitter application-only authentication
    private static func getAccessToken(withCompletion completion:@escaping (_ token:String?) -> Void) {
        if let token = self.bearerToken {
            completion(token)
            return
        }
        
        self.authenticate { (token) in
            completion(token)
        }
    }
    
    //Twitter application-only authentication
    private static func authenticate(withCompletion completion:@escaping (_ token:String?) -> Void) {
        
        guard let url = URL(string: "\(apiHostUrl)oauth2/token") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url:url)
        
        let bodyString = "grant_type=client_credentials"
        request.httpBody = bodyString.data(using: .utf8)
        
        request.httpMethod = "POST"
        request.addValue("Basic \(tokenCredentials)", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                
                if let dataObj = try? JSONSerialization.jsonObject(with: data, options: []) {
                    
                    if let dataDict = dataObj as? [String:Any],
                        let accessToken = dataDict["access_token"] as? String {
                        
                        self.bearerToken = accessToken
                        
                        DispatchQueue.main.async {
                            completion(self.bearerToken)
                        }
                        return
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
            
        }.resume()
    }
    
    //Wrapper around requests
    private static func sendApplicationOnlyRequest(_ request:URLRequest, completion:@escaping (Data?, URLResponse?, Error?) -> Void) {
        self.getAccessToken { (token) in
            
            var request = request
            if let token = token { //if not available request response will return the error code
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                completion(data, response, error)
                
            }.resume()
        }
    }
    
//MARK: - API
    
    /**
     Twitter application-only credentials from dev.twitter.com. Format has to be base64 encoded consumerKey:consumerSecret
     NOTE: Since this framework only uses endpoints without user context, user specific login flow isn't necessary
     */
    public static var tokenCredentials:String = "" {
        didSet {
            self.bearerToken = nil //clear so it'll get fetched again
        }
    }
    
    /**
     Fetches tweets containing the search term (string of a hashtag)
     - parameter searchTerm: Hashtag string to filter tweets by. Spaces will be removed.
     - parameter completion: completion block returning an array of tweets (dictionaries), will be empty if none found. Will be nil if unsuccessful.
     NOTE: For this coding challenge the response is just the raw dictionary. In a more refined SDK it makes sense to define a custom class that holds all data relevant to a tweet. See TwitterKit.
     */
    public static func getTweets(withSearchTerm searchTerm:String, _ completion:@escaping (_ tweets:[[String:Any]]?) -> Void) {
        guard let searchTerm = searchTerm.replacingOccurrences(of: " ", with: "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "\(apiHostUrl)1.1/search/tweets.json?q=%23\(searchTerm)") else {
                completion(nil)
                return
        }
        
        var request = URLRequest(url:url)
        
        request.httpMethod = "GET"

        self.sendApplicationOnlyRequest(request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
    
                if let dataObj = try? JSONSerialization.jsonObject(with: data, options: []) {
    
                    if let dataDict = dataObj as? [String:Any],
                        let statuses = dataDict["statuses"] as? [[String:Any]] {
    
                        completion(statuses)
                        return
                    }
    
                }
            }
            
            completion(nil)
        }
    }

}
