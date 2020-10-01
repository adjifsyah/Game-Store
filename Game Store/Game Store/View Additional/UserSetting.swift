//
//  UserSetting.swift
//  Game Store
//
//  Created by Adji Firmansyah on 20/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class UserSetting: ObservableObject {
    
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "username")
        }
    }
    @Published var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: "email")
        }
    }
    @Published var image: String {
        didSet {
            UserDefaults.standard.set(image, forKey: "image")
        }
    }
    @Published var isFavorite: Bool {
        didSet {
            UserDefaults.standard.set(isFavorite, forKey: "isFavorite")
        }
    }
    
    init() {
        self.name = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.email = UserDefaults.standard.object(forKey: "email") as? String ?? ""
        self.image = UserDefaults.standard.object(forKey: "image") as? String ?? ""
        self.isFavorite = UserDefaults.standard.object(forKey: "isFavorite") as? Bool ?? false
    }
}
