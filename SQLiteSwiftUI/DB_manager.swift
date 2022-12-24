//
//  DB_manager.swift
//  SQLiteSwiftUI
//
//  Created by Виктория Тангатарова on 08.12.2022.
//

import Foundation

import SQLite
 
class DB_Manager {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var expenses: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var amount: Expression<Int64>!
    private var category_name: Expression<String>!
    private var message: Expression<String>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory,  .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/my_expenses.sqlite3")
             
            // creating table object
            expenses = Table("expenses")
             
            // create instances of each column
            id = Expression<Int64>("id")
            amount = Expression<Int64>("amount")
            category_name = Expression<String>("category_name")
            
            
             
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
 
                // if not, then create the table
                try db.run(expenses.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(amount)
                    t.column(category_name)
                    
                    
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
    }
    
    public func addExpense(category_nameValue: String,  amountValue: Int64) {
        do {
            try db.run(expenses.insert(category_name <- category_nameValue, amount <- amountValue))
        } catch {
            print(error.localizedDescription)
        }
    }
}



