//
//  ChartView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI
import SwiftUICharts
import Charts

struct ChartView: View {
    
    // array of user models
    @State var expenseModels: [ExpenseModel]
    
    // check if user is selected for edit
    @State var expenseSelected: Bool
    // id of selected user to edit or delete
    @State var selectedExpenseId: Int64
    
    init(expenseModels: [ExpenseModel], expenseSelected: Bool, selectedExpenseId: Int64) {
        self.expenseModels = expenseModels
        self.expenseSelected = expenseSelected
        self.selectedExpenseId = selectedExpenseId
    }
    
    init() {
        self.expenseModels = [ExpenseModel]()
        self.expenseSelected = false
        self.selectedExpenseId = 0
    }
    
    var body: some View {
        // create navigation view
        NavigationView {
         
            VStack {
                PieChartView(data: expenseModels.map { Double($0.amount) }, title: "Amount", legend: "Траты по долям", form: ChartForm.extraLarge )
                 
                //BarChartView(data: ChartData(values: expenseModels.map { ($0.category_name, $0.amount) } ), title: "Expenses", legend: "expense", form: ChartForm.extraLarge)
                
//                LineView(data: expenseModels.map { Double($0.amount) }, title: "Amount", legend: "amount par expense")
         
            }
            // load data in user models array
            .padding()
            .navigationBarTitle("Chart")
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let expenseModelExample1 = ExpenseModel(id: 1, amount: 320, category_name: "Еда")
        let expenseModelExample2 = ExpenseModel(id: 2, amount: 210, category_name: "Вода")
        let expenseModelExample3 = ExpenseModel(id: 3, amount: 1120, category_name: "Алкоголь")
        let expenseModelExample4 = ExpenseModel(id: 4, amount: 200, category_name: "Бижутерия")
        let expenseModelsExampleArray: [ExpenseModel] = [expenseModelExample1, expenseModelExample2, expenseModelExample3, expenseModelExample4]
        
        ChartView(expenseModels: expenseModelsExampleArray,
                  expenseSelected: true,
                  selectedExpenseId: 0)
    }
}

import Foundation
let exp : [ExpenseModel] = []
let exps = exp.map { ($0.category_name, $0.amount) }

