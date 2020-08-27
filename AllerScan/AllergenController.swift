//
//  FirstViewController.swift
//  TestAPP
//
//  Created by Жалын on 6/23/19.
//  Copyright © 2019 ZLJ. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AllergenController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.textField.delegate = self
        self.view.backgroundColor = .white
        
        let adRequest = GADRequest()
        adRequest.testDevices = [ (kGADSimulatorID as! String), "abb830ada63843bec20284566167c2b5a1720a34" ] //Change the id to your phone a bit later
        adBannerView.load(GADRequest())
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet{
        self.textField.autocapitalizationType = .allCharacters
    }
    }
    
    let defaults = UserDefaults.standard
    
    @IBAction func buttonIsPressed(_ sender: Any) {
//        let items = UserDefaults.standard.object(forKey: "items")
//                items.append(textField.text!)
//                print(items)
        
        var newitems = textField.text!.components(separatedBy: CharacterSet(charactersIn: ", []()\n.:"))
        
        if newitems.contains(""){
        newitems.removeAll { $0 == ""}
                    //                newitems.append(contentsOf: newitems)
        UserDefaults.standard.set(newitems, forKey: "items")
        print(newitems)
            }else{
        let newitems = textField.text!.components(separatedBy: CharacterSet(charactersIn: ", []()\n.:"))
        UserDefaults.standard.set(newitems, forKey: "items")
        }
        textField.text = ""
        }

    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-1511225988917090/2850161838"
        adBannerView.delegate = self as? GADBannerViewDelegate
        adBannerView.rootViewController = self

        return adBannerView
    }()
            
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension AllergenController: GADBannerViewDelegate {

    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        tableView.tableHeaderView?.frame = bannerView.frame
        tableView.tableHeaderView = bannerView
    }

    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        print(error)
    }
}

//extension UIColor {
//    static var colorGreen2: UIColor {
//        // define your color here
//        return UIColor(red: (95/255), green: 196/255, blue: 179/255, alpha: 1)
//    }
//    static var colorPink2: UIColor{
//        return UIColor(red: (213/255), green: 101/255, blue: 164/255, alpha: 1)
//    }
//    static var colorViolet2: UIColor{
//        return UIColor(red: (147/255), green: 135/255, blue: 191/255, alpha: 1)
//    }
//    static var colorBlue2: UIColor{
//        return UIColor(red: (101/255), green: 181/255, blue: 231/255, alpha: 1)
//    }
//    static var colorBG2: UIColor{
//        return UIColor(red: (139/255), green: 218/255, blue: 207/255, alpha: 1)
//    }
//}
