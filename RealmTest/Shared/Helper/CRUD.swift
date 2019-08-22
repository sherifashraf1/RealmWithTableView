//
//  CRUD.swift
//  RealmTest
//
//  Created by Sherif on 8/22/19.
//  Copyright © 2019 Sherif. All rights reserved.
//

import Foundation
import RealmSwift

struct CrudOperation {
    static func creatNewUser(user : User ) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    static func deleteUser(user : User){
        let realm = try! Realm()
//        let users = realm.objects(User.self)
        try! realm.write {
            realm.delete(user)
            
        }
    }
    
    //Update
    static func updateUser(){
        let realm = try! Realm()
        let mohamed = realm.objects(User.self).filter("name == 'Mohamed'").first
        try! realm.write {
            mohamed?.age = 60
        }
    }
    
    //Read
    static func readUser(){
        let realm = try! Realm()
        //        let users = realm.objects(User.self).filter("age > 20")
        let users = realm.objects(User.self).sorted(byKeyPath: "name" , ascending: false )
        //        let users = realm.objects(User.self).filter("name CONTAINS 'Ahmed'")
        //CONTAINS equal to ==
        
        for user in users{
            print(user.name)
        }
    }

}
