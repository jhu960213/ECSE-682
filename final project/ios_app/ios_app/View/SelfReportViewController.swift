//
//  SelfReportViewController.swift
//  ios_app
//
//  Created by Jack Hu on 2020-11-23.
//

import Foundation
import UIKit
import MobileCoreServices
import Firebase


// This class will be the controller behind the self report scene
class SelfReportViewController: UIViewController, UIDocumentPickerDelegate {
    
    // Create a Google Firebase vision instance variables
    var vision:Vision?
    var textRecognizer:VisionTextRecognizer?
    var options:VisionCloudTextRecognizerOptions?
    
    // create data store to store the uploaded images or pdfs or docs
    var results = DataStore()
    
    //
    // outlets and actions
    //
    
    // storing my photo of covid results0
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myResults: UILabel!
    
    // upload/take a photo
    @IBAction func UploadPhotoButtonPress(_ button: UIButton) {
        //Reduces the sender's (the button that got pressed) opacity to half.
            button.alpha = 0.5
            //Code should execute after 0.2 second delay.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            button.alpha = 1.0
            }
        upLoadPhoto(sender: button)
    }
    
    // upload pdf
    @IBAction func UploadPDFButtonPress(_ sender: UIButton) {
        //Reduces the sender's (the button that got pressed) opacity to half.
            sender.alpha = 0.5
            //Code should execute after 0.2 second delay.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
            }
        upLoadPDF()
    }
    
    //
    // button press functions
    //
    
    func upLoadPhoto(sender: UIButton) {
        // creating a interface controller instance for accessing the camera hardware
        let pickerController = UIImagePickerController()
        // seeing if camera device is available on the client's device or not
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            // Take a photo button press
            if (sender.tag == 0) {
                // setting the access dest as camera through picker interface
                pickerController.sourceType = .camera
                pickerController.allowsEditing = true
                pickerController.delegate = self
                // present camera to user
                present(pickerController, animated: true)
                
            // Upload a photo button press
            } else if (sender.tag == 1) {
                pickerController.sourceType = .photoLibrary
                pickerController.delegate = self
                pickerController.allowsEditing = true
                // present saved photo library to user
                present(pickerController, animated: true)
            }
            
        } else {
            // notifying user camera is not available
            print("Camera is not available!")
            showToast(controller: self, message : "Camera is not available!", seconds: 3.0)
        }
    }
    
    // TODO: still need to get the document to upload into our app
    func upLoadPDF() {
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.item")], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .fullScreen
        self.present(importMenu, animated: true, completion: nil)
    }
    
    // for toasting notifications
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    // looping through the features to find specific words
    func processResult(from text: VisionText?, error: Error?) {
        var notPos = 1 // if the person wasn't infected
        let features  = text
        for block in features!.blocks {
            for line in block.lines {
                let myWords = line.elements
                for (index, value) in myWords.enumerated() {
                    if (value.text.lowercased() == "covid-19" || value.text.lowercased() == "covid") {
                        if (myWords[index+1].text.lowercased() == "positive") {
                            self.myResults.text = "You have been exposed!"
                            notPos = 0 // if person is indeed infected change to 0
                            
                            // TODO: Here could be a place where you create the notification and add to firebase documents
                            
                        }
                    }
                        
                }
                
            }
        }
        if (notPos == 1) {
            self.myResults.text = "You are clean!"
        }
    }
    
    // function that run text recognizer
    func runTextRecognition(with image: UIImage) {
        let visionImage = VisionImage(image: image)
        // extracting the text features from the images
        self.textRecognizer!.process(visionImage) { (features, error) in
            // error handling
            guard error == nil, let features = features else {
                print("Couldn't extract any features!")
                return
            }
            self.processResult(from: features, error: error)
        }
    }
    
    // function to process the uploaded image
    override func viewDidLoad() {
        // create the vision instances var in here
        self.vision = Vision.vision()
        self.textRecognizer = self.vision!.cloudTextRecognizer()
        self.options = VisionCloudTextRecognizerOptions()
        self.options!.languageHints = ["en", "hi", "fr", "zh-Hans","de"]
        self.textRecognizer = vision!.cloudTextRecognizer(options: self.options!)
        self.myResults.text = "Results Unknown!"
    }
}

extension ViewController: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
   
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
   
        // cancel the interface after the document has been selected
        documentPicker.dismiss(animated: true, completion: nil)
    }
    
    // when the document picker interface to user file system is canceled
    func documentPickerWasCancelled(_ documentPicker: UIDocumentPickerViewController) {
        print("Document view was canceled!")
        documentPicker.dismiss(animated: true, completion: nil)
    }
}



// to implement UIImagePickerDelegates
extension SelfReportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // when we cancel the image connection to the interface picker controller which had brought us the camera
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // when user is finished with taking a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // when we cancel the image connection to the interface picker controller which had brought us the camera
        picker.dismiss(animated: true, completion: nil)
        
        // we want the origina image taken by the camera and not an edited image
        guard let imageTaken = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("Original Image not available!")
            return
        }
        
        // setting my image view as the taken image from my camera
        self.myImageView.image = imageTaken
        self.runTextRecognition(with: imageTaken)
        results.addExposureResultsImages(imageTaken)
    }
}
