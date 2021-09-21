//
//  Books.swift
//  Booknerd3.0
//
//  Created by Michele Martin on 13.06.21.
//

import UIKit
import Realm
import RealmSwift


class Book: Object, Codable {
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var imageLink = ""
    @objc dynamic var category = "Lk"
    @objc dynamic var date = Date()

    convenience init(withBookDict: [String: Any]) {
        self.init()

        self.author = withBookDict["author"] as? String ?? "No Author"
        self.title = withBookDict["title"] as? String ?? "No Title"
        self.imageLink = withBookDict["imageLink"] as? String ?? "No link"
        self.category = withBookDict["category"] as? String ?? "No category"

    }
}

