//
//  MessageBoard.swift
//  FirebaseChat
//
//  Created by Kevin Stewart on 6/5/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import Firebase
import MessageKit

struct MessageBoard {
    let messageBoardName: String
    let messages: [Message]
    let id: String
    
    init(messageBoardName: String, messages: [Message], id: String = UUID().uuidString) {
        self.messageBoardName = messageBoardName
        self.messages = messages
        self.id = id
    }
}
