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
   // @objc dynamic var date = Date()

    convenience init(withBookDict: [String: Any]) {
        self.init()

        self.author = withBookDict["author"] as? String ?? "No Author"
        self.title = withBookDict["title"] as? String ?? "No Title"
        self.imageLink = withBookDict["imageLink"] as? String ?? "No link"
    }
}



/*class Books: Object {
    
    let books = Map<String, String>()
    
                    }
 */
/*
class Books: Object, Decodable {
        @objc dynamic var author: String?
        @objc dynamic var imageLink: String?
        @objc dynamic var title: String?
        
    convenience init(author: String, imageLink: String, title: String) {
         self.init()
         self.author = author
         self.imageLink = imageLink
         self.title = title
      }
    
        override static func primaryKey() -> String? {
                return "author"
            }
            
            private enum CodingKeys: String, CodingKey {
                case author
                case imageLink
                case title
}
    }
*/

/*
class Books: Object {
    let books = Map<String,String>()
}
 */



/*
class Books: Object, Decodable {
     var books = Bookdata()
}


class Bookdata: Object, Decodable{
    @objc dynamic var author: String?
    @objc dynamic var imageLink: String?
    @objc dynamic var title: String?
    
    override static func primaryKey() -> String? {
            return "author"
        }
        
        private enum CodingKeys: String, CodingKey {
            case author
            case imageLink
            case title
}
    
}

*/
