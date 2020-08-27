//
//  FirstViewController.swift
//  TestAPP
//
//  Created by Жалын on 6/25/19.
//  Copyright © 2019 ZLJ. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func buttonToClick(_ sender: Any) {
    }
    @IBOutlet var tv: UITableView!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignbackground()
    }

        override func viewDidAppear(_ animated: Bool) {
           let itemsObject = UserDefaults.standard.object(forKey: "items")
           if let tempItems = itemsObject as? [String] {
                items = tempItems
          }
    
            tv.reloadData()
        }
    
        internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                items.remove(at: indexPath.row)
                tableView.reloadData()
               UserDefaults.standard.set(items, forKey: "items")
            }
    
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()       // Dispose of any resources that can be recreated.
        //    }
        //
        
        
        
    }
    
    func assignbackground(){
        let background = UIImage(named: "background-image")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
