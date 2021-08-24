//
//  BookCell.swift
//  Booknerd3.0
//
//  Created by Michele Martin on 12.06.21.
//
import UIKit

class BookCell: UITableViewCell {
   
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}



