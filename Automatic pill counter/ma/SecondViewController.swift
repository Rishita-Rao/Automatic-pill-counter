//
//  SecondViewController.swift
//  ma
//
//  Created by Vennela Dondapati on 11/23/20.
//

import UIKit


class SecondViewController: UIViewController{


    
    @IBOutlet weak var imageView: UIImageView!
    
  
    @IBOutlet weak var button: UIButton!
  
  
   
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = .secondarySystemBackground
        
        
    }
    
   
    @IBAction func camera(_ sender: Any) {
    
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
    
        
        guard imageView.image != nil else {
       return
     }
    UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_: didFinishSavingWithError: contextInfo:)),nil)
    }
    
}

extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage  else {
            return
        }
        imageView.image = image

        picker.dismiss(animated: true, completion: nil)
    
    }
   
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
                // we got back an error!
                let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
}

