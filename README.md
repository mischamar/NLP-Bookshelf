# NLP-Bookshelf
## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Code examples](#code-examples)

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


• 
•





## Code examples

Code for the Segue that leads from the landing page to the MainPage:
```
@IBAction func ContinuetoMain(_ sender: Any) {
        self.performSegue(withIdentifier: "MainScreenSegue", sender: self)
       
    }
   
```


Button that directs the User to the Devices library (enact it to crop the pictures once chosen):
*must add the - privacy - camera usage description- in the info.plist
```
//GalleryButton
    @IBAction func GalleryButtom(_ sender: UIButton) {
    let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
```

Button that directs the User to the Devicesa Camer (enact it to crop the pictures once chosen):
*must add the - privacy - photo library description- in the info.plist
```
//CameraButton
    @IBAction func CameraButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
    }
    
```
