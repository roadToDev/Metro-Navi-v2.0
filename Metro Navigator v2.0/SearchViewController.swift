//
//  SearchViewController.swift
//  Metro Navigator v2.0
//
//  Created by Alex on 6/13/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var firstSearchBar: UISearchBar!
    @IBOutlet weak var secondSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    @IBAction func searchWay(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        cell.textLabel?.text = "Політехнічний Інститут"
        
        return cell
    }
    
    
    
    
    
    
    
    
    ////////////// ANIMATION /////////////
    
    private func showAnimate() {
        self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = self.view.transform.scaledBy(x: 0.7, y: 0.7)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished) {
                self.view.removeFromSuperview()
            }
            
        })
    }
    

}
