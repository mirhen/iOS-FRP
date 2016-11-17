//
//  GamesTableViewController.swift
//  TicTacToe
//
//  Created by Miriam Hendler on 11/15/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GamesTableViewController: UITableViewController {
    
    //Declare Array for Games
    var games: Variable<[Board]> = Variable([])
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //clear the delegates
        tableView.delegate = nil
        tableView.dataSource = nil
        
        games.asObservable().bindTo(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (index: Int, board: Board, cell: UITableViewCell ) in
            if let winner = board.winner() {
                cell.textLabel?.text = winner.rawValue
            } else {
                cell.textLabel?.text = board.playerWithCurrentTurn().rawValue
            }
            }.addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            destination.addBoard  = myAddBoard
        }
    }
    //completely change 
    func myAddBoard(board: Board) {
        self.games.value.append(board)
    }
}

