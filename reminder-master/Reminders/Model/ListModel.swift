//
//  List.swift
//  Reminders
//
//  Created by Mert Köksal on 22.04.2021.
//

import Foundation

struct ListModel: Hashable {
    let color: String
    let text: String
    let reminders: [Reminder]
}
