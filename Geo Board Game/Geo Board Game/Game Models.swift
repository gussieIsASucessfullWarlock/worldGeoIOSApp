//
//  Game Models.swift
//  Geo Board Game
//
//  Created by Eoin Shearer on 5/10/22.
//

import SwiftUI

struct Player: Codable, Hashable {
    var id = UUID().uuidString
    var name: String
    var countryID: Int
    var diceHistory: [DiceHistory]
    var ownes: [DiceHistory]
}

struct Territory: Codable, Hashable {
    var name: String
    var cost: Double
}

struct Country: Codable, Hashable {
    var name: String = ""
    var countryID: Int = 0
    var currency: String = ""
    var amountOfMoney: Double = 0.00
    var transactionHistory: [CountryTransaction] = [CountryTransaction(name: "None", amount: 0.00, reason: "None", player: "None")]
    var players: [Player] = [Player(name: "None", countryID: 0, diceHistory: [], ownes: [])]
}

struct CountryTransaction: Codable, Hashable {
    var name: String
    var amount: Double
    var time: Date = Date()
    var reason: String
    var player: String
}

struct DiceHistory: Codable, Hashable {
    var amount: Int
    var date: Date = Date()
}
