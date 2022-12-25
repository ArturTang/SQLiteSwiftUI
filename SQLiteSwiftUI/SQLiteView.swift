//
//  SQLiteView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI

struct SQLiteView: View {
    
    // array of user models
    @State var expenseModels: [ExpenseModel] = []
    
    // check if user is selected for edit
    @State var expenseSelected: Bool = false
     
    // id of selected user to edit or delete
    @State var selectedExpenseId: Int64 = 0
    
    var body: some View {
        // create navigation view
        NavigationView {
         
            VStack {
         
                // create link to add user
                HStack {
                    Spacer()
                    NavigationLink (destination: AddExpenseView(), label: {
                        Text("Add expense")
                    })
                }
         
                // navigation link to go to edit user view
                NavigationLink (destination: EditExpenseView(id: self.$selectedExpenseId), isActive: self.$expenseSelected) {
                    EmptyView()
                }
                
                // list view goes here
                // create list view to show all users
                List (self.expenseModels) { (model) in
                 
                    // show name, email and age horizontally
                    HStack {
                        Text("\(model.amount)")
                        Spacer()
                        Text(model.category_name)
                        Spacer()
                 
                        // edit and delete button goes here
                        // button to edit user
                        Button(action: {
                            self.selectedExpenseId = model.id
                            self.expenseSelected = true
                        }, label: {
                            Text("Edit")
                                .foregroundColor(Color.blue)
                            })
                            // by default, buttons are full width.
                            // to prevent this, use the following
                            .buttonStyle(PlainButtonStyle())
                        
                        // button to delete user
                        Button(action: {
                            // create db manager instance
                            let dbManager: DBManager = DBManager()
                         
                            // call delete function
                            dbManager.deleteUser(idValue: model.id)
                         
                            // refresh the user models array
                                self.expenseModels = dbManager.getExpenses()
                        }, label: {
                            Text("Delete")
                                .foregroundColor(Color.red)
                        })// by default, buttons are full width.
                        // to prevent this, use the following
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                
         
            }
            // load data in user models array
            .onAppear(perform: {
                self.expenseModels = DBManager().getExpenses()
            })
            .padding()
            .navigationBarTitle("My Costs")
        }
        
    }
}

struct SQLiteView_Previews: PreviewProvider {
    static var previews: some View {
        SQLiteView()
    }
}
