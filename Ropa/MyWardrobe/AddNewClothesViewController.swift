//
//  AddNewClothesViewController.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/6/22.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
import FirebaseStorage


class AddNewClothesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    @IBOutlet weak var clothesImageView: UIImageView!
   
    var ref: DatabaseReference?

    // 點選上傳按鈕，可開啟相機及相簿
    @IBAction func selectImageButton(_ sender: Any) {
    
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        //開啟相簿
        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in
            if UIImagePickerController.isSourceTypeAvailable( .photoLibrary) {
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        // 開啟相機
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in
            if UIImagePickerController.isSourceTypeAvailable( .camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }

            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
                imagePickerAlertController.dismiss(animated: true, completion: nil)
            }

        // 取消
            imagePickerAlertController.addAction(imageFromLibAction)
            imagePickerAlertController.addAction(imageFromCameraAction)
            imagePickerAlertController.addAction(cancelAction)

        present(imagePickerAlertController, animated: true, completion: nil)
    }
    
    //儲存
    @IBAction func saveButton(_ sender: Any) {
        
        ref = Database.database().reference()
        if dateTextField.text == "" || brandTextField.text == "" || priceTextField.text == "" || colorTextField.text == "" {
            //error handing 跳出警告視窗
            print("請填寫內容")
        }
        else {
//            guard let email = Auth.auth().currentUser?.email else { print("email error"); return }
            
//            guard let uid = Auth.auth().currentUser?.uid else { print("uid error");return }
            let uid = "testUid"
            //作為衣服的編號
            guard let key = ref?.childByAutoId().key else { return }
            
            ref?.child("clothes").child(uid).child("\(key)").setValue(["date":"\(dateTextField.text!)","brand":"\(brandTextField.text!)","price":"\(priceTextField.text!)","color":"\(colorTextField.text!)","Like": false])
            
            dateTextField.text = ""
            brandTextField.text = ""
            priceTextField.text = ""
            colorTextField.text = ""
            
            performSegue(withIdentifier: "goToWardrobe", sender: nil)
        }
        
    }
    
        
    @IBAction func cancelButton(_ sender: Any) {
        dateTextField.text = ""
        brandTextField.text = ""
        priceTextField.text = ""
        colorTextField.text = ""
        
        performSegue(withIdentifier: "goToWardrobe", sender: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//
//extension AddNewClothesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        var selectedImageFromPicker: UIImage?
//        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            selectedImageFromPicker.image = image
//        }
//        let uniqueString = NSUUID().uuidString
//        
//        if let selectedImage = Storage.storage().reference().child("clothes")
//        
//    }
    
    
}


  
    
    


