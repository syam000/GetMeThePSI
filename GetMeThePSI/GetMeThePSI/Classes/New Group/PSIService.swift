//
//  PSIService.swift
//  GetMeThePSI
//
//  Created by SYAM SASIDHARAN on 26/12/17.
//  Copyright © 2017 syam00. All rights reserved.
//

import UIKit

//Constants
let API_KEY_HEADER_FIELD = "api-key"

//MARK: *****************************************************************************************************************************
//MARK: To make this component testable extending session and session task
//MARK: *****************************************************************************************************************************
typealias FetchTaskCompletionBlock = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionTask: URLSessionDataTaskProtocol { }

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping FetchTaskCompletionBlock) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping FetchTaskCompletionBlock) -> URLSessionDataTaskProtocol {
        let task:URLSessionDataTask = dataTask(with: request, completionHandler: {
            (data:Data?, response:URLResponse?, error:Error?) in completionHandler(data,response,error) }) as URLSessionDataTask
        return task
    }
}

public class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

public class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    
    private (set) var lastURLRequest: URLRequest?
    private (set) var lastURL: String?
    private (set) var lastApiKey: String?

    public var nextData: Data?
    public var nextError: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) -> URLSessionDataTaskProtocol {
        lastURL = request.url?.absoluteString
        lastURLRequest = request
        lastApiKey = request.value(forHTTPHeaderField: API_KEY_HEADER_FIELD)
        
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
}
//MARK: *****************************************************************************************************************************

//Custom errors
enum ServiceError : Error {
    
    case invalidApiKey
    case unsupportedUrl
    case unknownError

    static func getError(with code: Int) -> ServiceError {
        switch code {
        case 1000:
            return .unsupportedUrl
        case 1001:
            return .invalidApiKey
        default:
            return .unknownError
        }
    }
}

//Service implementation
class PSIService: NSObject {

    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func getTheCurrentPSIReadings(url: String?, apiKey: String?, completion: @escaping (Data?, Error?) -> Swift.Void) {
        
        guard let url = url, let serviceUrl = URL(string: url) else {
            completion(nil, ServiceError.getError(with: 1000))
            return
        }
        
        guard let apiKey = apiKey else {
            completion(nil, ServiceError.getError(with: 1001))
            return
        }
        
        var request = URLRequest(url: serviceUrl)
        request.addValue(apiKey, forHTTPHeaderField: API_KEY_HEADER_FIELD)
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            
            if let _ = error {
                completion(nil, error)
            }
            else {
                completion(data, error)
            }
        }
        task.resume()
    }
}
