//
//  SecondViewController.swift
//  iKnow
//
//  Created by Bộp Bộp on 5/8/16.
//  Copyright © 2016 Bộp Bộp. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var LoadImage: UIImageView!
    @IBOutlet weak var LoadlblND: UILabel!
    
    var ImagesGet = UIImage()
    var lblText = String()
    var Back:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadImage.image = ImagesGet
        LoadlblND.text = lblText
        LoadImage.transform = CGAffineTransformMakeTranslation(-500, 0)
        LoadlblND.transform = CGAffineTransformMakeTranslation(-500, 0)
        LoadlblND.alpha = 0
        LoadImage.alpha = 0
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.LoadImage.transform = CGAffineTransformIdentity
            self.LoadImage.alpha = 1
            }, completion: {finished in
                NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(SecondViewController.Repeat), userInfo: nil, repeats: true)
        })
        UIView.animateWithDuration(4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: [], animations: {
            self.LoadlblND.transform = CGAffineTransformIdentity
            self.LoadlblND.alpha = 1
            }, completion: nil)
    }
    func Repeat(){
        UIView.animateWithDuration(0.5, animations: {
            self.LoadImage.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: {finished in
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
                    self.LoadImage.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: nil )
        })
    }
    
    override func didReceiveMemoryWarning() {    super.didReceiveMemoryWarning()   }
    
}
