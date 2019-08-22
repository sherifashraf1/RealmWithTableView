//
//  ViewController.swift
//  RealmTest
//
//  Created by Sherif on 8/21/19.
//  Copyright © 2019 Sherif. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    var notifier: NotificationToken?
    var users : Results<User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromRealm()
        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifier?.invalidate() 
    }
    
    
    func loadDataFromRealm(){
        let realm = try! Realm()
         self.users = realm.objects(User.self)
        
        // let users = realm.objects(User.self)
        
        /*users.forEach({
         self.users.append($0)
         })*/
        
        // self.users = Array(users)

        
        self.notifier = users.observe { [unowned self] (results : RealmCollectionChange) in
            switch results {
            case .initial(_):
                self.tabelView.reloadData()
            case .error(let error):
                print(error)
            case .update(_ ,let deletions,let insertions,let modifications):
                //self.tabelView.reloadData()
                self.tabelView.beginUpdates()
                self.tabelView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }) , with: .automatic)
                self.tabelView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tabelView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tabelView.endUpdates()

            }
        }
    }
    
    @IBAction func addUser(_ sender: UIBarButtonItem) {
        Alert.addUserAlert(on: self)
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tabelView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        //TODO:- fetch Realm Data
        cell.textLabel?.text = user.name
        cell.textLabel?.textAlignment = .center
        return cell
        
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = users[indexPath.row]
            CrudOperation.deleteUser(user: user)
        }
    }
}
