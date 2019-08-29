//
//  AjoutPlanViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 22/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import CoreLocation
import iOSDropDown
import GooglePlaces
import CoreFoundation
import MobileCoreServices

class AjoutPlanViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate {
   
    @IBOutlet weak var photo: UIImageView!
    var newMedia: Bool?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        categorie.text = pickerData[row]
        
    }
    
    let URL_IMAGE = URL(string: "http://www.simplifiedtechy.net/wp-content/uploads/2017/07/simplified-techy-default.png")
    @IBOutlet weak var categorie: SkyFloatingLabelTextFieldWithIcon!
    //  @IBOutlet weak var categories: DropDown!
    
   
    var picker: UIPickerView?
    var pickerData: [String] = []

    @IBOutlet weak var titre: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lien: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var localisation: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var dscript: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var ajouter: UIButtonX!
    
    @IBOutlet weak var ajouterPhoto: UIButtonX!
    var lon = 0.00
    var lat = 0.00
   // var categoriesNames: [String] = []
   // var categoriesId: [Int] = []
    var selectedAction = ""
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        //self.picker?.reloadAllComponents()
        picker?.delegate = self
        picker?.dataSource = self
        categorie.inputView = picker
        categorie.inputAccessoryView = UIToolbar().ToolbarPicker(mySelect: #selector(pickerShouldReturn))
        
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        
                        //displaying the image
                        self.photo.image = image
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
        
    }
    
    
    @IBAction func ajoutPhotoBtn(_ sender: Any) {
        createAlert(title: "choose your image source", message: "")
        if (selectedAction == "camera"){
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
            }
        }
        else  if (UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary)) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = false
        }
    }


    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[.originalImage] as!UIImage
            ajouterPhoto.isHidden = true
            photo.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(ProfileViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pickerShouldReturn()
    {
        categorie.resignFirstResponder()
    }
    @IBAction func ajouter(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        addPlan()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        fillCategoryArray()
    }
    
    func createAlert (title:String, message:String)
    {
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (action) in
            self.selectedAction = "camera"

            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = false
            picker.delegate = self
            alert.dismiss(animated: true, completion: nil)
            self.present(picker, animated: true, completion: nil)
            //open up the camera
        }))
       /* alert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
                picker.delegate = self
                
                self.present(picker, animated: true, completion: nil)
            })
        }))
        */
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (action) in
            self.selectedAction = "gallery"

            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            picker.delegate = self
            alert.dismiss(animated: true, completion: nil)
            self.present(picker, animated: true, completion: nil)
            
            
            //open up the gallery
            self.selectedAction = "gallery"
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    
    func addPlan(){
       
        WebServiceBP.init().AddPlan(title: self.titre.text ?? "Bon Plan", adress: self.localisation.text ?? "sousse", region: "String", latitude: self.lat, longitude: self.lon, description: self.dscript.text ?? "Bon Plan !!", user_id: 3, image: "String",rate :4) { (response, isTrue) in
            
            
        }}
        
    @IBAction func localisation(_ sender: Any) {
        localisation.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    func fillCategoryArray(){
        WebServiceBP.init().getCategories() { (response, isTrue) in
            if isTrue{
                self.pickerData.removeAll()
                print (response)
                for rep in response{
                    let categoryName = rep.object(forKey: "category_name") as! String
                    self.pickerData.append(categoryName)
                    
                }
                
            }
            else{
                print ("something went wrong")
            }
        }
    }
}
extension AjoutPlanViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        localisation.text = place.name
        lat = Double(place.coordinate.latitude)
        lon = Double(place.coordinate.longitude)

        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
