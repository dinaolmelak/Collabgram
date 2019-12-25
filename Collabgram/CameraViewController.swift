//
//  CameraViewController.swift
//  Collabgram
//
//  Created by Dinaol Melak on 12/24/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    let custom = Customfunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func onTapCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onTapPost(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionTextField.text!
        post["author"] = PFUser.current()!
        
        if let imageData = imageView.image?.pngData(){
            let file = PFFileObject(data: imageData)
            
            post["image"] = file
            post.saveInBackground { (success, error) in
                if error != nil {
                    print(error as Any)
                } else{
                    print("Success")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        
        } else{
            custom.showAlert(title: "No Image", message: "Unfortunately, their is no image in camera")
        }
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        // resizing the image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
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
