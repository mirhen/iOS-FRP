

//
//  RxGitHubAPI.swift
//  RxIssuesView
//
//  Created by Nikolas Burk on 21/11/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//
//  inspired by Octokit.swift

import Foundation
import RxSwift
import RxCocoa

class RxGitHubAPI {
    
    static var loggedIn = false
    
    static fileprivate let clientID = "f7b9c65001861fe10953"
    static fileprivate let clientSecret = "68d3822fe02fa9a259b319bd489aaa86678872fb"
    static fileprivate var userAccessToken = ""
    
    let baseURL = "https://api.github.com"
    static let githubWebURL = "https://github.com"
    
    enum GitHubEndpoint {
        case user(String)
        case organization(String)
        case repos(User)
        case issues(User, Repository)
    }
    
    //MARK: Public API
    
    func createUserObservable(for user: String) -> Observable<User?> {
        guard let url = url(for: .user(user))
            else {
                return Observable<User?>.just(nil)
        }
        
        let jsonObservable: Observable<Any> = URLSession.shared.rx.json(url: url)
        let userInfoObservable: Observable<[String: Any]?> = jsonObservable.map { (json: Any) in
            return (json as? [String: Any])
        }
        let userObservable: Observable<User?> = userInfoObservable.map { (userInfo: [String: Any]?) in
            if let userInfo = userInfo {
                return self.jsonToMaybeUser(userInfo: userInfo)
            }
            return nil
        }

        return userObservable
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(nil)
    }
    
    func createRepositoryObservable(for user: User) -> Observable<Repository?> {
        guard let url = url(for: .repos(user))
            else {
                return Observable<Repository?>.just(nil)
        }
        
        let jsonObservable: Observable<Any> = URLSession.shared.rx.json(url: url)
        let repositoryInfoObservable: Observable<[String: Any]?> = jsonObservable.map { (json: Any) in
            return (json as? [String: Any])
        }
        let repositoryObservable: Observable<Repository?> = repositoryInfoObservable.map { (repositoryInfo: [String: Any]?) in
            if let repositoryInfo = repositoryInfo {
                print(repositoryInfo)
            }
            return nil
        }
        
        return repositoryObservable
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(nil)

    }
    // MARK: Authentication
    
    static func authenticate(with code: String) {
        
        let path = "login/oauth/access_token"
        let params = ["client_id": clientID, "client_secret": clientSecret, "code": code]
        
        let urlString = githubWebURL + "/" + path + "?" + params.toURLArguments()
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print(#file.lastPathComponent()!, #line, #function, "ERROR: no token, code \(response.statusCode)")
                    return
                } else {
                    if let data = data, let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String {
                        let accessToken = string.retrieveAccessToken()
                        if let accessToken = accessToken {
                            print(#file.lastPathComponent()!, #line, #function, "received access token: \(accessToken)")
                            userAccessToken = accessToken
                            loggedIn = true
                        }
                        else {
                            print(#file.lastPathComponent()!, #line, #function, "ERROR: could not get access token, code \(response.statusCode)")
                        }
                    }
                    else {
                        print(#file.lastPathComponent()!, #line, #function, "ERROR: could not parse data, code \(response.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
    
    static func loginURL() -> String {
        let baseURL = "https://github.com/login/oauth/authorize"
        let callback = "rxissuesviewer://success"
        let scope = "user%20repo"
        let urlString = baseURL + "?client_id=\(clientID)&redirect_url=\(callback)&scope=\(scope)" //
        return urlString
    }
    
    
    // MARK: Parsing
    
    func jsonToMaybeUser(userInfo: [String: Any]) -> User? {
        //        let identifier: Int
        //        let login: String
        //        let name: String
        //        let email: String
        guard let identifier = userInfo["id"] as? Int else {
            print("could not get id data")
            return nil
        }
        guard let login = userInfo["login"] as? String else {
            print("could not get login data")
            return nil
        }
        
        guard let name = userInfo["name"] as? String else {
            print("could not get name data")
            return nil
        }
        guard let email = userInfo["email"] as? String else {
            print("could not get email data")
            return nil
        }
        let user = User(identifier: identifier, login: login, name: name, email: email)
        return user
    }
    
    
    // MARK: URLs
    
    func url(for endpoint: GitHubEndpoint) -> URL? {
        var urlString = baseURL
        switch endpoint {
        case .user(let username):
            urlString = urlString + "/users/" + username
            if RxGitHubAPI.userAccessToken.characters.count > 0 {
                urlString = urlString + "?access_token=" + RxGitHubAPI.userAccessToken
            }
        case .organization(let organizationName):
            urlString = urlString + "/orgs/" + organizationName
            if RxGitHubAPI.userAccessToken.characters.count > 0 {
                urlString = urlString + "?access_token=" + RxGitHubAPI.userAccessToken
            }
        case .repos(let user):
            urlString = urlString + "/users/" + user.login + "/repos"
            if RxGitHubAPI.userAccessToken.characters.count > 0 {
                urlString = urlString + "?access_token=" + RxGitHubAPI.userAccessToken
            }
        case .issues(let user, let repository):
            urlString = urlString + "/repos/" + user.login + "/" + String(repository.name) + "/issues?state=all"
            if RxGitHubAPI.userAccessToken.characters.count > 0 {
                urlString = urlString + "&access_token=" + RxGitHubAPI.userAccessToken
            }
        }
        return URL(string: urlString)
    }
    
    
    
}



// MARK: Helpers





