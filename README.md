# NLP-Bookshelf
## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Code examples](#code-examples)

## General info
This project is a simple project created for a "Praxisprojekt". It is supposed to be an App that acts a virtual reading list.
	
## Technologies
Project is created with:
* Xcode: 12.5
* IOS: 14.6 (for simulating)

## Code examples

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
