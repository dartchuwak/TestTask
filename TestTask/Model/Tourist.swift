//
//  Tourist.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 21.12.2023.
//

import Foundation

struct Tourist: Identifiable {
    let id = UUID()
    var number: String
    var name: String
    var surname: String
    var birthDate: String
    var citezenship: String
    var passportNumber: String
    var passportValidDate: String
    var isToogle: Bool

    var isNameValid: Bool = true
    var isSurnameValid: Bool = true
    var isBirthdateValid: Bool = true
    var isCitezenshipValid: Bool = true
    var isPassportNumberValid: Bool = true
    var isPassportValidDateValid: Bool = true
}
