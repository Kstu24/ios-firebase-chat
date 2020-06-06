//
//  MessageController.swift
//  FirebaseChat
//
//  Created by Kevin Stewart on 6/5/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import MessageKit
import Firebase

class MessageController {
    
    // Properties
    let ref = Database.database().reference()
    let groupsRef: DatabaseReference
    let messagesRef: DatabaseReference
    var groups = [ChatGroups]()
    var messages = [Message]()
    var users = [Sender]()

    //MARK: - Helpers
    
    init() {
        groupsRef = ref.child("groups")
        messagesRef = ref.child("messages")
    }
    
    func fetchGroups(completion: @escaping () -> Void) {
        groupsRef.observe(.value, with: { snapshot in
            var newGroups = [ChatGroups]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let group = ChatGroups(snapshot: snapshot) {
                    newGroups.append(group)
                }
            }
            self.groups = newGroups
            completion()
        })
    }

    func fetchMessages(for group: ChatGroups, completion: @escaping () -> Void) {
        messagesRef.child(group.id.uuidString).observe(.value, with: { snapshot in
            var newMessages = [Message]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let message = Message(snapshot: snapshot) {
                    newMessages.append(message)
                }
            }
            self.messages = newMessages
            completion()
        })
    }
    
    func createGroup(with title: String, completion: @escaping () -> Void) {
         let newGroup = ChatGroups(title: title)

         groupsRef.child((newGroup.id.uuidString)).setValue(newGroup.toDictionary())
         completion()
     }

     func createMessage(for group: ChatGroups, from sender: Sender, with message: String, completion: @escaping () -> Void) {
        let newMessage = Message(snapshot: DataSnapshot, from: sender, with: message)

         messagesRef.child(group.id.uuidString).child(newMessage.id.uuidString).setValue(newMessage.toDictionary())
         completion()
     }
}

