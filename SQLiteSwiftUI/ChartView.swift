//
//  ChartView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
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
         
                BarChartView(data: ChartData(values: expenseModels.map { ($0.category_name, $0.amount) } ), title: "Expenses", legend: "expense", form: ChartForm.extraLarge)
                
                LineView(data: expenseModels.map { Double($0.amount) }, title: "Prices", legend: "price par expense")
         
            }
            // load data in user models array
            .onAppear(perform: {
                self.expenseModels = DBManager().getExpenses()
            })
            .padding()
            .navigationBarTitle("Chart")
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

import Foundation
let exp : [ExpenseModel] = []
let exps = exp.map { ($0.category_name, $0.amount) }

