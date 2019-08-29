//
//  ProfileViewController.swift
//  BonPlan
//
//  Created by DEVLOPER on 04/04/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var tel: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var adresses: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var mail: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var userName: SkyFloatingLabelTextFieldWithIcon!
  
    @IBAction func enregistrer(_ sender: Any) {
        WebServiceBP.init().createProfile(name: self.userName.text ?? "user", tel: Int(self.tel.text ?? "2222222") ?? 222222 , address: self.adresses.text ?? "Sousse Sahloul", email: self.mail.text ?? "user@gmail.com", password: self.password.text ?? "user") { (response,isTrue) in
            print("profile created")
    }
    }
    @IBOutlet weak var enregistrer: UIButtonX!
    @IBOutlet weak var profileImage: UIButtonX!
    
    @IBOutlet weak var camBtn: UIButtonX!
    var newMedia: Bool?
    @IBOutlet weak var cameraBtn: UIButtonX!
    
    @IBOutlet weak var test: UIImageView!
    
    @IBAction func camBtn(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType =
                UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
    @IBAction func profileImageBtn(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = (self as UIImagePickerControllerDelegate as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
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
            profileImage.isHidden = true
            test.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(ProfileViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.profileImage.image =  UIImage(named:"photo")
        profileImage?.borderColor = UIColor.white
        profileImage?.layer.cornerRadius = 10
        profileImage?.clipsToBounds = true
        // Do any additional setup after loading the view.
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        func checkPermission() {
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            switch photoAuthorizationStatus {
            case .authorized:
                print("Access is granted by user")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({
                    (newStatus) in
                    print("status is \(newStatus)")
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        /* do stuff here */
                        print("success")
                    }
                })
                print("It is not determined until now")
            case .restricted:
                // same same
                print("User do not have access to photo album.")
            case .denied:
                // same same
                print("User has denied the permission.")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
