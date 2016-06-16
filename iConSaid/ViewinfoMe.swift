//
//  ViewinfoMe.swift
//  iConSaid
//
//  Created by Bộp Bộp on 5/9/16.
//  Copyright © 2016 Bộp Bộp. All rights reserved.
//

import UIKit

class ViewinfoMe: UIViewController {

    @IBOutlet weak var InfoIMG: UIImageView!
    @IBOutlet weak var InfoLBL: UILabel!
    @IBOutlet weak var BTNout: UIButton!
    
    let transitionManager = MenuTransitionManager()
    
    @IBAction func InfoBTN(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self.transitionManager
        InfoIMG.image = UIImage(named: "Smileyinfo")
        BTNout.layer.cornerRadius = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
