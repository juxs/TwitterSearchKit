//
//  TwitterSearchKitTests.swift
//  TwitterSearchKitTests
//
//  Created by Julian Gruber on 13/07/2017.
//  Copyright © 2017 Julian Gruber. All rights reserved.
//

import XCTest
import TwitterSearchKit

class TwitterSearchKitTests: XCTestCase {
    
    func testTweetsEndpoint0() {
        //test invalid api credentials response
        let ex = XCTestExpectation(description: "Empty tweet array returned due to invalid credentials")
        
        TwitterSearchKit.tokenCredentials = "randomwrongvalue"
        TwitterSearchKit.getTweets(withSearchTerm: "Radiohead") { (tweets) in
            XCTAssertNil(tweets)
            
            ex.fulfill()
        }
        
        self.wait(for: [ex], timeout: 10)
    }
    
    func testTweetsEndpoint1() {
        //test response with valid api credentials
        let ex = XCTestExpectation(description: "Valid but possibly empty tweet array returned")
        
        TwitterSearchKit.tokenCredentials = "R0l4N1ZoZ1J0Z1YzTjk5Z2VPOHVNZzFzNTpJR2lEUXhubmpXMExSNkVMSVVqNEo4T0VwSTZRbG12ZGJNWE9QVGNNS0Y5aDNBR3dIRA=="
        TwitterSearchKit.getTweets(withSearchTerm: "Radiohead") { (tweets) in
            XCTAssertNotNil(tweets)
            
            ex.fulfill()
        }
        
        self.wait(for: [ex], timeout: 10)
    }
    
}
