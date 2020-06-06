//
//  ChatGroups.swift
//  FirebaseChat
//
//  Created by Kevin Stewart on 6/5/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import Firebase
import MessageKit

struct ChatGroups {
    let title: String
    let messages: [Message]?
    let timestamp: Date
    let id: UUID

    init(title: String, messages: [Message]? = nil, timestamp: Date = Date(), id: UUID = UUID()) {
        self.id = id
        self.title = title
        self.timestamp = timestamp
        self.messages = messages
}

init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let timesString = value["timestamp"] as? String,
            let timestamp = timesString.transformToIsoDate else {
                return nil
        }

        self.id = UUID(uuidString: snapshot.key) ?? UUID()
        self.title = title
        self.timestamp = timestamp
        self.messages = nil
    }

    func toDictionary() -> Any {
        return [
            "title": title,
            "timestamp": timestamp.transformIsoToString
        ]
    }
}
