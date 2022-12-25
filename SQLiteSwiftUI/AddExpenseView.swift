//
//  AddExpenseView.swift
//  SQLiteSwiftUI
//
//  Created by Виктория Тангатарова on 08.12.2022.
//

import SwiftUI

struct AddExpenseView: View {
    // create variables to store user input values
        @State var expense_name: String = ""
        @State var amount: String = ""
         
        // to go back on the home screen when the user is added
        @Environment(\.presentationMode) var mode: Binding<PresentationMode>
         
        var body: some View {
             
            VStack {
                // create name field
                TextField("Enter expense", text: $expense_name)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                 
                // create email field
            
                // create age field, number pad
                TextField("Enter amount", text: $amount)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                 
                // button to add a user
                Button(action: {
                    // call function to add row in sqlite database
                    DBManager().addExpense(category_nameValue: self.expense_name, amountValue: Int64(self.amount) ?? 0)
                     
                    // go back to home page
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Add Expense")
                })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }.padding()
             
        }
    }

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
