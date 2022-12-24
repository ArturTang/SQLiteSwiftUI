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
}
