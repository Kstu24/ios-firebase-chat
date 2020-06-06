//
//  Message.swift
//  FirebaseChat
//
//  Created by Kevin Stewart on 6/5/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import MessageKit
import Firebase

struct Message {
    let sender: String
    let message: String
    let id: UUID
    let timestamp: Date
    let sentBy: Sender
    
    init(id: UUID = UUID(), sender: Sender, message: String, timestamp: Date = Date()) {
        self.sentBy = sender
        self.message = message
        self.id = id
        self.timestamp = timestamp
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let senderId = value["senderId"] as? String,
            let senderName = value["senderName"] as? String,
            let message = value["message"] as? String,
            let timesString = value["timestamp"] as? String,
            let timestamp = timesString.transformToIsoDate else {
                return nil
        }

        self.id = UUID(uuidString: snapshot.key) ?? UUID()
        self.sender = senderId
        self.sentBy = Sender(id: senderId, displayName: senderName)
        self.message = message
        self.timestamp = timestamp
    }
}
