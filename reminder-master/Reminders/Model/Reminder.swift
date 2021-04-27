//
//  Reminder.swift
//  Reminders
//
//  Created by Mert Köksal on 22.04.2021.
//

import Foundation

struct Reminder: Hashable {
    let title: String
    let notes: String
    let date: Date
    let list: ListModel
}
