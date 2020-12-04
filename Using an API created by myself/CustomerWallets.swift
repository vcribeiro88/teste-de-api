//
//  CustomerWallets.swift
//  Using an API created by myself
//
//  Created by Vinícius de Oliveira on 27/11/20.
//

import Foundation

struct CustomerWallets: Codable {
    var customerWallets: Data
}

struct Data: Codable {
    var data: [DataCustomersModel]
}
