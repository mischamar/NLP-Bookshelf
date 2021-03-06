# NLP-Bookshelf
## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Design](#design)
* [Front-End](#front-end)

## General info
This project is a simple project created for a "Praxisprojekt". An iOS mobile application that analyzes images of books captured by device and converts the information in a structured form into a TableView containing title, author and thumbnail.

## Technologies
Project is created with:
* Xcode: 12.5
* IOS: 14.6 (for simulating)

## Design
	• Prototype created in Figma (https://www.figma.com/proto/YMwywqzsWeA9ZtSVqfyDID/dunkle-Farben-Beispiel?node-id=139%3A757&starting-point-node-id=79%3A148)
	• Free prototype templates are from figma.com/community/ 
	• Label, Icon and simple Label created in Procreate.
	• Dark design for health benefits and because it's generally prefered by users.
	• Grey buttons to mark interactive objects
	• icons8.de used for the filter, library and camera icon
	• coolors.co used for colour scheme inspiration
	• pilestone.com used to check if the design is compatible for users with colour blindness
	• Official iOS toolbar guidlines used for button sizes. https://developer.apple.com/design/human-interface-guidelines/ios/bars/toolbars/

## Front-End
* Project written in swift for iOS applications.
* IDE → Xcode

### Step by step guide:

	• Download the latest XCode application from your Appstore. (https://apps.apple.com/de/app/xcode/id497799835?mt=12)
	• Create a new project using storyboard.

Install https://cocoapods.org

	• SVProgressHUD → https://cocoapods.org/pods/SVProgressHUD-0.8.1
	• Realm → https://cocoapods.org/pods/Realm
	• RealmSwift → https://cocoapods.org/pods/RealmSwift
	• Alamofire  →  https://cocoapods.org/pods/Alamofire
	• DropDown  →  https://cocoapods.org/pods/DropDown

Your podfile should look like this:
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'App name' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for App name

pod 'Alamofire', '~> 5.2'

pod 'SwiftyJSON', '~> 4.0'

pod 'NVActivityIndicatorView'

pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git'

pod 'RealmSwift'

pod "RealmSearchViewController"
```
### Info.plist:
Add the ' - privacy - photo library description-' and '- privacy - photo library description-' to your info.plist to ensure the necessary privacy settings.

### Interface Builder:

Using the interface builder create:

- TableView
- TableView Cells
- One ImageView on top for the logo
- Two buttons on the bottom

Next equip the prototype cell with with two Labels for the book title and author name. Add an ImageView for the book cover.
Once you adjusted the features to the correct size add the constraints. Change the ViewController class to MainScreenViewController.




## Code

Open a seperate swift.file to build you book class/ realm object. Add the following code:
```
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

```

Open a seperate swift.file for your book cell. Add the identifier via you storyboard. Drag the outlets(2xLabel, ImageView) into the file and add the following code:
```
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

```

Open the ViewController file and add the code found in the repository.
