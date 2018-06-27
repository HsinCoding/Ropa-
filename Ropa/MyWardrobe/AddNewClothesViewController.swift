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
import FirebaseStorage
import Firebase


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
            
            guard let image = self.clothesImageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let filename = NSUUID().uuidString
            
            Storage.storage().reference().child("Clothes_Image").child("uid").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload profile image:", err)
                    return
                }
               
                
            Storage.storage().reference().child("Clothes_Image").child("uid").child(filename).downloadURL(completion: { (url, error) in
                    
                    // optional biding
                    guard let url = url else  {
                        return
                    }
                    print("download", error, url)
                
                
                    let dic = ["date":"\(self.dateTextField.text!)","brand":"\(self.brandTextField.text!)","price":"\(self.priceTextField.text!)","color":"\(self.colorTextField.text!)","Like": false,"ImageUrl":"\(url)"] as [String : Any]

                    Database.database().reference().child("clothes").child("uid").setValue(dic, withCompletionBlock: { (error, ref) in
                        if let error = error {
                            print("Failed to ", error)
                            return
                        }
                        print("Successfully")
                    })
                })
            })
            
        }
        performSegue(withIdentifier: "goToWardrobe", sender: nil)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
       
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        clothesImageView.image = image
        
        dismiss(animated: true, completion: nil)
        
    }

}





//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////
////
////if let selectedImage = selectedImageFromPicker {
////
////    let storageRef = Storage.storage().reference().child("clothes").child("\(uniqueString).png")
////
////    if let uploadData = UIImagePNGRepresentation(selectedImage) {
////        storageRef.putData(uploadData, metadata: nil) { (data, error) in
//            if error != nil {
//                print("Error: \(error!.localizedDescription)")
//                return
//            }
//
//            storageRef.downloadURL(completion: { (url, error) in
//                if error != nil {
//                    print(error)
//                    return
//                }
//                if url != nil {
//                    let databaseRef = Database.database().reference().child("clothes").child(uniqueString)
//                    databaseRef.setValue(url, withCompletionBlock: { (error, dataRef) in
//                        if error != nil {
//                            print("Database Error \(error?.localizedDescription)")
//                        }
//                        else {
//                            print("圖片已存")
//                        }
//                    })
//                    self.SetUpUser(Image: url!.absoluteString)
//                }
//            })
//        }
//
//
//    }
//}
//

