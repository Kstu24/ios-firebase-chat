//
//  Extensions.swift
//  FirebaseChat
//
//  Created by Kevin Stewart on 6/5/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var optionalText: String? {
        let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        return (trimmedText ?? "").isEmpty ? nil : trimmedText
    }
}

extension Date {
    var transformIsoToString: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
}

extension String {
    var transformToIsoDate: Date? {
        guard self != "" else { return nil }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self)
    }
}
