//
//  DB_manager.swift
//  SQLiteSwiftUI
//
//  Created by Виктория Тангатарова on 08.12.2022.
//

import Foundation

import SQLite
 
class DBManager {
     
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
    
    // return array of expense models
    public func getExpenses() -> [ExpenseModel] {
         
        // create empty array
        var expenseModels: [ExpenseModel] = []
     
        // get all expenses in descending order
        expenses = expenses.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all expenses
            for expense in try db.prepare(expenses) {
     
                // create new model in each loop iteration
                let expenseModel: ExpenseModel = ExpenseModel()
     
                // set values in model from database
                expenseModel.id = expense[id]
                expenseModel.amount = expense[amount]
                expenseModel.category_name = expense[category_name]

     
                // append in new array
                expenseModels.append(expenseModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return expenseModels
    }
    
    // get single user data
    public func getExpense(idValue: Int64) -> ExpenseModel {
     
        // create an empty object
        let expenseModel: ExpenseModel = ExpenseModel()
         
        // exception handling
        do {
     
            // get user using ID
            let user: AnySequence<Row> = try db.prepare(expenses.filter(id == idValue))
     
            // get row
            try user.forEach({ (rowValue) in
     
                // set values in model
                expenseModel.id = try rowValue.get(id)
                expenseModel.amount = try rowValue.get(amount)
                expenseModel.category_name = try rowValue.get(category_name)
                
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return expenseModel
    }
    
    // function to update user
    public func updateExpense(idValue: Int64, amountValue: Int64, category_nameValue: String) {
        do {
            // get user using ID
            let user: Table = expenses.filter(id == idValue)
             
            // run the update query
            try db.run(user.update(id <- idValue, amount <- amountValue, category_name <- category_nameValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // function to delete user
    public func deleteUser(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = expenses.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}



