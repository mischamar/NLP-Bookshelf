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

    
    @IBOutlet weak var searchBar: UISearchBar!
    let searchController = UISearchController ()
    //    var searchResults = try! Realm().objects(Book.self)
   
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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
     // In case you have to delete the realm database
       /* let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
       */
        
        let realm = try! Realm()
        let results = realm.objects(Book.self)
        token = results.observe { _ in
            self.updateUI()
        }
 
        myBooks = realm.objects(Book.self)
        
        self.tableview.keyboardDismissMode = .interactive
        
        
    }
    // MARK: - Addbutton
    
    @IBAction func addbutton(_ sender: UIButton) {
     
        func showInputDialog() {
               //Creating UIAlertController and
               //Setting title and message for the alert dialog
               let alertController = UIAlertController(title: "You want to add a new book?", message: "Enter the title and author.", preferredStyle: .alert)
               
               //the confirm action taking the inputs
               let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                   
                   
                let realm = try! Realm()
                try! realm.write {
                    let realm = try! Realm()
                    let book = Book()
                    let author = alertController.textFields?[0].text!
                    let title = alertController.textFields?[1].text!
                    let imageLink = "https://via.placeholder.com/60x80?text=No+picture.com"
                    let category = "read"
                    let date = Date()

                                        
                    book.author = author!
                    book.title = title!
                    book.imageLink = imageLink
                    book.date = date
                    book.category = category
                  
                    realm.add(book)
        
                    }
               }
               
               //the cancel action doing nothing
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
               
               //adding textfields to our dialog box
               alertController.addTextField { (textField) in
                   textField.placeholder = "Enter author"
               }
               alertController.addTextField { (textField) in
                   textField.placeholder = "Enter title"
               }
               
               //adding the action to dialogbox
               alertController.addAction(confirmAction)
               alertController.addAction(cancelAction)
               
               //finally presenting the dialog box
               self.present(alertController, animated: true, completion: nil)
           }
        showInputDialog()
    }
    
    // MARK: - segmented control

    @IBOutlet weak var scopeBar: UISegmentedControl!
  

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var books = myBooks
        let realm = try! Realm()
        let notfiltered = realm.objects(Book.self)
      //  let filteredread = realm.objects(Book.self).filter({ $0.category == "read"})
        
    //    let filteredwanttoread = realm.objects(Book.self).filter("category == wantoread")
     //   let filteredreading = realm.objects(Book.self).filter("category == reading")
        
        
        if books?.count == 0 {
               tableView.setEmptyView(title: "You don't have any Books.", message: "Take a picture and add it to your list.")
           }
        else  {
            tableView.restore()

         /*   switch scopeBar.selectedSegmentIndex {
        
                   case 0:
                   return books?.count

                   case 1:
                   return books?.count

                   case 2:
                   return books?.count

                   case 3:
                   return notfiltered.count

                   default:
                   break
      }
             return 0
      */
        }

        return books!.count

   }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell
        
        
        cell.title.text = self.myBooks?[indexPath.item].title
        cell.author.text = self.myBooks?[indexPath.item].author
        cell.imgView.downloadImage(from: (self.myBooks?[indexPath.item].imageLink)!)
            return cell
        
        
       // let realm = try! Realm()
        
      //  let notfiltered = realm.objects(Book.self)
    //  let filteredread = realm.objects(Book.self).filter("category == read")
     //   let filteredwanttoread = realm.objects(Book.self).filter("category == wantoread")
     //   let filteredreading = realm.objects(Book.self).filter("category == reading")
   


     /*   switch scopeBar.selectedSegmentIndex{
        case 0:
            cell.title.text = realm.objects(Book.self)[indexPath.item].title
            cell.author.text = realm.objects(Book.self)[indexPath.item].author
            cell.imgView.downloadImage(from: (realm.objects(Book.self)[indexPath.item].imageLink))
                return cell
        case 1:
            cell.title.text = realm.objects(Book.self)[indexPath.item].title
            cell.author.text = realm.objects(Book.self)[indexPath.item].author
            cell.imgView.downloadImage(from: (realm.objects(Book.self)[indexPath.item].imageLink))
                return cell
        case 2:
            cell.title.text = self.myBooks?[indexPath.item].title
            cell.author.text = self.myBooks?[indexPath.item].author
            cell.imgView.downloadImage(from: (self.myBooks?[indexPath.item].imageLink)!)
                return cell
        case 3:
            cell.title.text = self.myBooks?[indexPath.item].title
            cell.author.text = self.myBooks?[indexPath.item].author
            cell.imgView.downloadImage(from: (self.myBooks?[indexPath.item].imageLink)!)
                return cell
        default:
            break
        }
        */
  
 //   cell.title.text = self.myBooks?[indexPath.item].title
 //   cell.author.text = self.myBooks?[indexPath.item].author
 //   cell.imgView.downloadImage(from: (self.myBooks?[indexPath.item].imageLink)!)
    }
    
 
 
        
        
    @IBAction func segmentedChanged(_ sender: Any) {
        tableview.reloadData()
    }
    
   // MARK: -  Scopbar
    /*
    @IBOutlet weak var scopeBar: UISegmentedControl!
    
    @IBAction func scopebar(_ sender: Any) {
        let scopeBar = sender as! UISegmentedControl?
        let realm = try! Realm()
        var book = try! Realm().objects(Book.self)
        let scopebar = searchController.searchBar.selectedScopeButtonIndex
        
        switch scopeBar?.selectedSegmentIndex {
         case 1:
         book = realm.objects(Book.self).filter("category == wanttoread")
            //self.tableview.reloadData()
 
         case 2:
         book = realm.objects(Book.self).filter("category == read")
            //self.tableview.reloadData()

         case 3:
         book = realm.objects(Book.self).filter("category == reading")
            //self.tableview.reloadData()
         default:
         book = realm.objects(Book.self).sorted(byKeyPath:"date", ascending: true)
            //self.tableview.reloadData()
        }
        self.tableview.reloadData()
    }
*/
    // MARK: - add label red/want to read/ reading
/*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func showmethisfunction() {
            let realm = try! Realm()
            let book = realm.objects(Book.self)
            let boook = Book()
            let booook = myBooks
            
            
            let alert = UIAlertController(title: "Want to put your book in a list?", message: "Please Select an Option", preferredStyle: .actionSheet)

            if let popoverController = alert.popoverPresentationController {
              popoverController.sourceView = self.view
              popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
              popoverController.permittedArrowDirections = []
            }
            
            
            
            
            alert.addAction(UIAlertAction(title: "Read", style: .default, handler: { (_) in
                
                    try! realm.write {
                    boook.category = "read"
                       }
                  }))

                  alert.addAction(UIAlertAction(title: "Want to read", style: .default, handler: { (_) in
                    try! realm.write {
                        boook.category = "wanttoread"
                       }
                  }))

                  alert.addAction(UIAlertAction(title: "Reading", style: .default, handler: { (_) in
                    try! realm.write {
                        boook.category = "readin"
                       }
                  }))

                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
                      print("User click Dismiss button")
                  }))

                  self.present(alert, animated: true, completion: {
                      print("completion block")
                  })
  
        }
        showmethisfunction()
    }
    
    */
    
    // MARK: -  Dropdown Menu
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
       func updateUI() {
            tableview.reloadData()
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
                //SVProgressHUD.dismiss(withDelay: 2)

                     }
             .responseData { response in
                  switch response.result {
                  case .failure(let error):
                    print(error)
                      SVProgressHUD.setDefaultMaskType(.gradient)
                      SVProgressHUD.showError(withStatus: "Error")
                     //SVProgressHUD.dismiss(withDelay: 2)

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
                        SVProgressHUD.showError(withStatus: "Error: We couldn't find your book")
                        SVProgressHUD.dismiss(withDelay: 2)

                     }
                  }
             }
     }
        SVProgressHUD.dismiss(withDelay: 2)
        dismiss(animated: true, completion: nil)
    }
 
    
    ///------------------IMAGEPICKER-------------------------

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
    }
