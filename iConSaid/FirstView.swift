//
//  FirstView.swift
//  iConSaid
//
//  Created by Bộp Bộp on 5/8/16.
//  Copyright © 2016 Bộp Bộp. All rights reserved.
//

import UIKit

class FirstView: UIViewController {

    @IBOutlet weak var FirstIMG: UIImageView!
    @IBOutlet weak var Firstlbl: UILabel!

    @IBAction func TapToTrans(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: {
            self.FirstIMG.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: {finished in
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.FirstIMG.transform = CGAffineTransformIdentity
                    }, completion: {finished in
                        self.performSegueWithIdentifier("iConView", sender: self)
                })
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstIMG.image = UIImage(named: "SmileyFirstView")
        FirstIMG.alpha = 0
        UIView.animateWithDuration(1, animations: {
            self.FirstIMG.transform = CGAffineTransformTranslate(self.FirstIMG.transform, 0, -500)
            self.Firstlbl.transform = CGAffineTransformTranslate(self.Firstlbl.transform, 0, -400)
            self.Firstlbl.alpha = 0
            }, completion: {finished in
                UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.FirstIMG.transform = CGAffineTransformIdentity
                    self.Firstlbl.transform = CGAffineTransformIdentity
                    self.FirstIMG.alpha = 1
                    self.Firstlbl.alpha = 1
                    }, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {   super.didReceiveMemoryWarning() }   }

