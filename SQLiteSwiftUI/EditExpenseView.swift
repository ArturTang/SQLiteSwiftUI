//
//  EditUserView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI
 
struct EditExpenseView: View {
     
    // id receiving of expense from previous view
    @Binding var id: Int64
     
    // variables to store value from input fields
    @State var amount: String = ""
    @State var category_name: String = ""
    
     
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        VStack {
            // create name field
            TextField("Enter expense", text: $category_name)
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
             
            // button to update user
            Button(action: {
                // call function to update row in sqlite database
                DBManager().updateExpense(idValue: self.id, amountValue: Int64(self.amount) ?? 0, category_nameValue: self.category_name)
 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit Expense")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
 
        // populate user's data in fields when view loaded
        .onAppear(perform: {
             
            // get data from database
            let expenseModel: ExpenseModel = DBManager().getExpense(idValue: self.id)
             
            // populate in text fields
            self.id = expenseModel.id
            self.amount = String(expenseModel.amount)
            self.category_name = String(expenseModel.category_name)
        })
    }
}
 
struct EditExpenseView_Previews: PreviewProvider {
     
    // when using @Binding, do this in preview provider
    @State static var id: Int64 = 0
     
    static var previews: some View {
        EditExpenseView(id: $id)
    }
}
