//
//  ContentView.swift
//  SQLiteSwiftUI
//
//  Created by Виктория Тангатарова on 04.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SQLiteView()
            .tabItem {
                Label("My Costs", systemImage: "list.dash")
            }

            ChartView(expenseModels: DBManager().getExpenses(), expenseSelected: true, selectedExpenseId: 1)
            .tabItem {
                Label("Chart", systemImage: "chart.bar")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

