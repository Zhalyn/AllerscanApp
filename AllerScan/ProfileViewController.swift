//
//  SecondViewController.swift
//  TestAPP
//
//  Created by Жалын on 6/20/19.
//  Copyright © 2019 ZLJ. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForSavedName()
//        checkForSavedImage()
//
        self.nameTextField.delegate = self
//        self.tableView.backgroundColor = UIColor.colorBlue
        self.view.backgroundColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ThirdViewController.imageTapped(tapGestureRecognizer:)))
        profile_image.isUserInteractionEnabled = true
        profile_image.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var profile_image: UIImageView!
//    @IBAction func uploadImageButton(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
//        self.present(picker, animated: true, completion: nil)
//    }
    

    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditingImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            print("aaa")
            profile_image.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        print("Image is tapped")
        
//        uploadImageButton(self)
        
    }
    
    
    
    @IBAction func saveButton(_ sender: Any) {
//    saveChanges()
        saveName()
        print("Save button is pressed")
    }
    
    func saveName() {
        defaults.set(nameTextField.text!, forKey: "guyname")
    }
    
    func checkForSavedName() {
        let name = defaults.value(forKey: "guyname") as? String ?? ""
        nameTextField.text = name
    }
    
// All about the table
    
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = []
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    let defaults = UserDefaults.standard
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        if let tempItems = itemsObject as? [String] {
            items = tempItems
            print(items)
        }
        
        tableView.reloadData()
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            items.remove(at: indexPath.row)
            tableView.reloadData()
            UserDefaults.standard.set(items, forKey: "items")
        }
        
    }
    
    
    //MARK: Pressing return when done with texting
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    

}

extension ProfileViewController: UIPopoverPresentationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: UIImagePickerController
    
    private func presentImagePickerController(withSourceType sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            profile_image.contentMode = .scaleAspectFit
            let fixedImage = pickedImage.fixOrientation()
            profile_image.image = fixedImage
        }
        dismiss(animated: true, completion: nil)
    }
    

}

extension UIColor {
    static var colorGreen1: UIColor {
        // define your color here
        return UIColor(red: (95/255), green: 196/255, blue: 179/255, alpha: 1)
    }
    static var colorPink1: UIColor{
        return UIColor(red: (213/255), green: 101/255, blue: 164/255, alpha: 1)
    }
    static var colorViolet1: UIColor{
        return UIColor(red: (147/255), green: 135/255, blue: 191/255, alpha: 1)
    }
    static var colorBlue1: UIColor{
        return UIColor(red: (101/255), green: 181/255, blue: 231/255, alpha: 1)
    }
    static var colorBG1: UIColor{
        return UIColor(red: (139/255), green: 218/255, blue: 207/255, alpha: 1)
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .landscapeLeft
//    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }
}

// MARK: Try to find what this code was for

extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
    
}

    
    


