//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Idwall Go Dev 003 on 23/04/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
    static let appName = "⚡️FlashChat"
    static let registerSegue = "goToRegisterView"
    static let loginSegue = "goToLoginView"
    static let chatSegue = "goToChatView"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
