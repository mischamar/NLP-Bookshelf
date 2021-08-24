//
//  Book.swift
//  Booknerd3.0
//
//  Created by Michele Martin on 12.06.21.
//

import Foundation
import UIKit

class Book {
    
    var image: UIImage?
    var title: String
    var author: String
    
    init(image: UIImage, title: String, author: String) {
        self.image = image
        self.title = title
        self.author = author
    }
    
}
