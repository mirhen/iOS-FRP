//
//  SearchViewController.swift
//  RxIssuesViewer
//
//  Created by Miriam Hendler on 11/22/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var repositoriesButton: UIButton!
    let disposeBag = DisposeBag()
    let gitHubAPI = RxGitHubAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObservables()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpObservables() {
        let userObservable: Observable<User?> = searchTextField.rx.text.asObservable()
            .throttle(0.75, scheduler: MainScheduler.instance)
            .flatMapLatest { (query: String?) -> Observable<User?> in
                        return self.gitHubAPI.createUserObservable(for: query!)
        }
        userObservable.subscribe { user in
            print(user)
            if user.debugDescription != "next(nil)" {
            self.gitHubAPI.createRepositoryObservable(for: user.element!!)
            }
            
        }.addDisposableTo(disposeBag)
        
        userObservable.map { (user: User?) in
            
            return user != nil
        }.bindTo(repositoriesButton.rx.isEnabled)
        .addDisposableTo(disposeBag)
    
    }
}
