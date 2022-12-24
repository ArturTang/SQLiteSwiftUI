//
//  ContentView.swift
//  SQLiteSwiftUI
//
//  Created by Виктория Тангатарова on 04.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            VStack {
                
                // create link to add user
                HStack {
                    Spacer()
                    NavigationLink (destination: AddExpenseView(), label: {
                        Text("Add expense")
                    })
                }
                
                // list view goes here
                
            }.padding()
                .navigationBarTitle("Мy Expenses")
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

