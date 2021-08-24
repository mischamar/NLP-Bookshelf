//
//  MainScreenViewController.swift
//  Booknerd3.0
//
//  Created by Michele Martin on 24.07.21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import RealmSwift
import DropDown



// MARK: - Tableview is empty

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        //change hight
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center       
        self.backgroundView = emptyView
        self.separatorStyle = .none
        }
        func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        }
}


// MARK: - Class MainScreenViewController

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

        let searchController = UISearchController ()
        var searchResults = try! Realm().objects(Book.self)
       
  
   
    // MARK: - Galery  Button

    @IBAction func GalleryButtom(_ sender: UIButton) {
    let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    // MARK: - Camera Button

    @IBAction func CameraButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
    }
    
    // MARK: - Delete Slide

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if let book = myBooks?[indexPath.row] {
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(book)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    // MARK: - ViewDidLoad

    @IBOutlet weak var tableview: UITableView!
    
    var books: [Book]? = []
    var myImage = UIImage()
   
    
var myBooks: Results<Book>?
var token: NotificationToken?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let realm = try! Realm()
        let results = realm.objects(Book.self)
        token = results.observe { _ in
            self.updateUI()
        }
 
        myBooks = realm.objects(Book.self)
    }
    
    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let books = myBooks
        if books?.count == 0 {
               tableView.setEmptyView(title: "You don't have any Books.", message: "Take a picture and add it to your list.")
           }
        else {
            tableView.restore()
        }
        return books!.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell
  
    cell.title.text = self.myBooks?[indexPath.item].title
    cell.author.text = self.myBooks?[indexPath.item].author
    cell.imgView.downloadImage(from: (self.myBooks?[indexPath.item].imageLink)!)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
  
    
       func updateUI() {
            tableview.reloadData()
 
        
        var myImage = UIImage()
        
        
}
    let dropDown = DropDown() //2

    @IBAction func sort(_ sender: UIButton) {
        dropDown.dataSource = ["sort by title", "sort by author", "sort by date"]//4
        dropDown.anchorView = sender //5
     
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7

     
     dropDown.selectionAction = { [weak self] (index: Int, item: String ) in //8
         let realm = try! Realm()

         if item == "sort by author" {
             self?.myBooks = realm.objects(Book.self).sorted(byKeyPath:"author", ascending: true)
                 self?.tableview.reloadData()
             }
         else if item == "sort by title" {
             self?.myBooks = realm.objects(Book.self).sorted(byKeyPath:"title", ascending: true)
             self?.tableview.reloadData()
         }
         else if item == "sort by date" {
             self?.myBooks = realm.objects(Book.self).sorted(byKeyPath:"date", ascending: true)
             self?.tableview.reloadData()
         }
     }
   }
}



   
      






// MARK: - UI IMAGEVIEW

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
var myItems = [[String:Any]]()




// MARK: - Front and Backend Implementation

 extension MainScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

     
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let image:UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
             self.myImage = image
             
             AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(self.myImage.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "image.png", mimeType: "image/jpeg")
             
             }, to: "https://booknerdvirtualreadinglist.herokuapp.com/getbook" , headers: nil )
             .uploadProgress { progress in
                         print(progress)
                SVProgressHUD.setDefaultMaskType(.gradient)
                SVProgressHUD.show(withStatus: "Searching for book")
                SVProgressHUD.dismiss(withDelay: 2)

                     }
             .responseData { response in
                  switch response.result {
                  case .failure(let error):
                      print(error)
                    print(error)
                      SVProgressHUD.setDefaultMaskType(.gradient)
                      SVProgressHUD.show(withStatus: "Error")
                    SVProgressHUD.dismiss(withDelay: 2)

                  case .success(let json):
                     do {
                         if let json = try JSONSerialization.jsonObject(with: json) as? [String: AnyObject] {
                            if let bookArray = json["books"] as? [[String:AnyObject]] {
                                 for eachBook in bookArray {
                                     let book = Book(withBookDict: eachBook)
                                    let realm = try! Realm()
                                     try! realm.write {
                                         realm.add(book)
                                     }
                                 }
                             }
                         }
                     } catch {
                         print("Error deserializing JSON: \(error)")
                        SVProgressHUD.setDefaultMaskType(.gradient)
                        SVProgressHUD.show(withStatus: "Error: We couldn't find your book")
                        SVProgressHUD.dismiss(withDelay: 2)

                     }
                  }
             }
     }
        dismiss(animated: true, completion: nil)
    }
 
    
    ///------------------IMAGEPICKER-------------------------

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
    }
