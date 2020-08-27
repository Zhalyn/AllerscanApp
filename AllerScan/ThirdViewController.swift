//
//  ThirdViewController.swift
//  TestAPP
//
//  Created by Жалын on 6/20/19.
//  Copyright © 2019 ZLJ. All rights reserved.
//

import UIKit
import FirebaseMLVision
import MobileCoreServices
import Foundation

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var textView: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let processor = ScaledElementProcessor()
    
    @IBOutlet var allegenLabel: UILabel!
    @IBOutlet var tapToStart: UIImageView!
    
    
    //Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Notifications to slide the keyboard up
        NotificationCenter.default.addObserver(self, selector: #selector(ThirdViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ThirdViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        imageView.layer.addSublayer(frameSublayer)
        drawFeatures(in: imageView)
        
        self.view.backgroundColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ThirdViewController.imageTapped(tapGestureRecognizer:)))
        tapToStart.isUserInteractionEnabled = true
        tapToStart.addGestureRecognizer(tapGestureRecognizer)

//        view.bringSubviewToBack(imageView)

        
        // Color of the table ||| (code below)
        //        self.table.backgroundColor = UIColor.colorBlue
        //        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        print("Image is tapped")
        
        cameraDidTouch(self)
    }

    var allergensFound: [String] = [] { didSet{table.reloadData()}}
    
    var frameSublayer = CALayer()
    var scannedText: String = "Detected text can be edited here." {
        didSet {
            textView.text = scannedText
            let str = scannedText.uppercased()
            let allergens = UserDefaults.standard.array(forKey: "items") as! [String]
            let string = str.components(separatedBy: CharacterSet(charactersIn: ", []()\n.:"))
            print(string)
            let words = ["APPLES", "APPLE"]
            for allergen in allergens{
                if string.contains(String(Substring(allergen))) == true {
                    for word in words{
                        if allergen.contains(word){
                            let string = word
                        }
                    }
                    print("I found the string \(allergen)")
                    allegenLabel.text = "Not safe"
                    allegenLabel.alpha = 1  //Make the label visible
                    allegenLabel.textColor = .red
                    allergensFound.append(allergen)
                    print(allergensFound)
                    
                }
                
                if string.contains(String(Substring(allergen))) == false {
                    allegenLabel.text = "Safe"
                    allegenLabel.alpha = 1 //Make the label visible
                    allegenLabel.textColor = UIColor.colorGreen
                    //                    table.reloadData()
                }
            }

        }
    }
        
    @IBOutlet var table: UITableView!
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergensFound.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = allergensFound[indexPath.row]
        
        return cell
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    @IBAction func cameraDidTouch(_ sender: Any){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentImagePickerController(withSourceType: .camera)
        } else {
            let alert = UIAlertController(title: "Camera Not Available", message: "A camera is not available. Please try using the app next available time.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        allergensFound.removeAll()
        table.reloadData()
        print("button is pressed")
//        tapToStart.isHidden = true
        
    }
    
    private func removeFrames() {
        guard let sublayers = frameSublayer.sublayers else { return }
        for sublayer in sublayers {
            sublayer.removeFromSuperlayer()
        }
    }
    
    private func drawFeatures(
        in imageView: UIImageView,
        completion: (() -> Void)? = nil
        ) {
        // 2
        removeFrames()
        processor.process(in: imageView) { text, elements in
            elements.forEach() { element in
                self.frameSublayer.addSublayer(element.shapeLayer)
            }
            self.scannedText = text
            // 3
            completion?()
        }
    }
    
//    func bringToSubView() {
//      self.view.bringSubviewToFront(cameraButton)
//        cameraDidTouch(self).layer.zPosition = 1
//    }
    
}


extension ThirdViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    // MARK: UIImagePickerController
    
    private func presentImagePickerController(withSourceType sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.mediaTypes = [String(kUTTypeImage)]
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageView.contentMode = .scaleAspectFit
            let fixedImage = pickedImage.fixOrientation()
            imageView.image = fixedImage
            drawFeatures(in: imageView)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIColor {
    static var colorGreen: UIColor {
        // define your color here
        return UIColor(red: (95/255), green: 196/255, blue: 179/255, alpha: 1)
    }
    static var colorPink: UIColor{
        return UIColor(red: (213/255), green: 101/255, blue: 164/255, alpha: 1)
    }
    static var colorViolet: UIColor{
        return UIColor(red: (147/255), green: 135/255, blue: 191/255, alpha: 1)
    }
    static var colorBlue: UIColor{
        return UIColor(red: (101/255), green: 181/255, blue: 231/255, alpha: 1)
    }
    static var colorBG: UIColor{
        return UIColor(red: (139/255), green: 218/255, blue: 207/255, alpha: 1)
    }
}











