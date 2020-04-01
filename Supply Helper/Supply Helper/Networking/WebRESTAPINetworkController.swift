//
//  WebRESTAPINetworkController.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/31/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

enum WebAPIError: Error {
    case encodingError(Any)
    case decodingError(Any)
    case dataTaskResponse(Any)
    case dataTaskError(Error)
    case dataTaskData(Any)
    case responseNoToken(Any)
    case responseNoUserID(Any)
    case responseOther(String)
    case invalidUser
    case failedRegister(String)
}

class WebRESTAPINetworkController: ModelNetworkControllerProtocol  {

    //Set baseURL for API calls based on debug or not
    #if DEBUG
        private let baseURL: URL = URL(string:"https://supplyhelper-be-staging.herokuapp.com/api/")!
    #else
        private let baseURL: URL = URL(string:"https://supplyhelper-be-production.herokuapp.com/api/")!
    #endif
    
    init () {
        print("baseURL = \(baseURL)")
    }
}

extension WebRESTAPINetworkController: UserAUTHProtocol {
    
    func register(with user: User, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent("auth").appendingPathComponent("register")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        guard let username = user.username,
            let password = user.password else {
                completion(WebAPIError.invalidUser)
                return
        }
        let userSignInInfo = SignInInfo(email: username, password: password)
        do {
            let jsonEncoder = JSONEncoder()
            //jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
            request.httpBody = try jsonEncoder.encode(userSignInInfo)
        } catch {
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 && response.statusCode != 201 {
                completion(WebAPIError.failedRegister(error.debugDescription))
                return
            }
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    // Log In
    func signIn(with signInInfo: SignInInfo, completion: @escaping (Int?, Error?) -> Void) {
        var result: LoginResult?
        var userID: Int?
        let url = baseURL.appendingPathComponent("auth").appendingPathComponent("login")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(signInInfo)
        } catch {
            completion(nil,WebAPIError.encodingError("Error encoding JSON from object: \(error)"))
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(nil, WebAPIError.dataTaskResponse("Resonse: \(response.statusCode)"))
                return
            }
            if let error = error {
                completion(nil,WebAPIError.dataTaskError(error))
                return
            }
            guard let data = data else {
                completion(nil,WebAPIError.dataTaskData("No data in DataTask response"))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                result = try jsonDecoder.decode(LoginResult.self, from: data)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    let accessToken = parseJSON["token"] as? String
                    //Store the AuthToken in the keychain
                    let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                    print("The access token save result: \(saveAccessToken)")
                    if let result = result,
                        let user = result.user,
                        let id = user.id {
                        userID = id
                        NSLog("UserID: \(id)")
                    } else {
                        userID = nil
                    }
                    if (accessToken?.isEmpty)! {
                        completion(userID,WebAPIError.responseNoToken("Access Token is Empty"))
                        return
                    }
                }
            } catch {
                completion(nil,WebAPIError.decodingError("WebAPI - Error decoding JSON response to signin: \(error)"))
                return
            }
            if let userID = userID {
                completion(userID,nil)
            } else {
                completion(nil,WebAPIError.responseNoUserID("WebAPI - No userID returned."))
            }
        }.resume()
        return
    }
    
    //Logout all sessions and remove autologin from Userdefaults
    @objc public func logout(completion: @escaping () -> Void = { }) {
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "accessToken")
        print("Remove successful: \(removeSuccessful)")
        completion()
    }
}
