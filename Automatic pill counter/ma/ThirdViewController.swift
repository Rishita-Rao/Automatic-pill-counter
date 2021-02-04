//
//  ThirdViewController.swift
//  ma
//
//  Created by Vennela Dondapati on 11/23/20.
//

import UIKit
class ThirdViewController: UIViewController {
    public var imgName = ""
    public var dataString = ""
   
    @IBOutlet weak var imageView: UIImageView!
    
   
    @IBOutlet weak var button1: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = .secondarySystemBackground
        

    }
    
    
   
    @IBAction func photolibrary(_ sender: Any) {
    let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
   
    @IBAction func count(_ sender: Any) {
        
    let params = ["imageName": self.imgName] as Dictionary<String, String>

        let url = URL(string: "https://venni7002.azurewebsites.net/api/HttpExample")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
                
            }
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")     }
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Number of pills in the image \(dataString)")     }
                
        }
        task.resume()
            }
}
    
extension ThirdViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            self.imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(self.imgName)
            print(self.imgName)
            print(localPath)
            let image1 = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image1.pngData()! as NSData
            print(data)
            
            

            do {
                let account = try AZSCloudStorageAccount(fromConnectionString:"DefaultEndpointsProtocol=https;AccountName=venni7002;AccountKey=XuoETAedQ5jBdD5MBs6l5pl1u4aiTbiLHLrtL54WR70JBrxZRvaOoRl/xOlEwEkxqyQaBiSiWuRDJhut4gyMhg==;EndpointSuffix=core.windows.net") //I stored the property in my header file
                let blobClient: AZSCloudBlobClient = account.getBlobClient()
                let blobContainer: AZSCloudBlobContainer = blobClient.containerReference(fromName: "container")
                blobContainer.createContainerIfNotExists(with: AZSContainerPublicAccessType.container, requestOptions: nil, operationContext: nil) { (NSError, Bool) -> Void in
                   if ((NSError) != nil){
                      NSLog("Error in creating container.")
                   }
                   else {
                    let blob: AZSCloudBlockBlob = blobContainer.blockBlobReference(fromName: self.imgName as String) //If you want a random name, I used let imageName = CFUUIDCreateString(nil, CFUUIDCreate(nil))
                      let imageData = data

                    blob.upload(from: imageData as Data, completionHandler: {(NSError) -> Void in
                      NSLog("Ok, uploaded !")
                    
                   
                      })
                    }
                }
            }
        catch {
                print("error")
            }
            
         guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage  else {
            return
        }
            
        
        
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
            
    
   }
    
}
}
