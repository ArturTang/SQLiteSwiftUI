//
//  ExpenseModel.swift
//  SQLiteSwiftUI
//
//  Created by Виктория Тангатарова on 08.12.2022.
//

import Foundation

class ExpenseModel: Identifiable {
    public var id: Int64 = 0
    public var amount: Int64 = 0
    public var category_name: String = ""
    
    init(id: Int64, amount: Int64, category_name: String) {
        self.id = id
        self.amount = amount
        self.category_name = category_name
    }
    
    init() {
        self.id = 0
        self.amount = 0
        self.category_name = ""
    }
}
