//
//  TransitionManager.swift
//  iConSaid
//
//  Created by Bộp Bộp on 5/9/16.
//  Copyright © 2016 Bộp Bộp. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {

    private var Present = false

    func animateTransition(transitionInfo: UIViewControllerContextTransitioning) {
        let Container = transitionInfo.containerView()
        let Screens : (from:UIViewController, to:UIViewController) = (transitionInfo.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionInfo.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        let InfoView = !self.Present ? Screens.from as! ViewinfoMe : Screens.to as! ViewinfoMe
        let BackView = !self.Present ? Screens.to as UIViewController : Screens.from as UIViewController
        let InfoMe = InfoView.view
        let BackInfoMe = BackView.view
        if (self.Present){
            self.OutStageController(InfoView)
        }
        
        Container!.addSubview(BackInfoMe)
        Container!.addSubview(InfoMe)
        let Duration = self.transitionDuration(transitionInfo)
        UIView.animateWithDuration(Duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: [], animations: {
            if (self.Present) {
                self.InStageController(InfoView)
            }else{
                self.OutStageController(InfoView)
            }
            }, completion: { finished in
                transitionInfo.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.addSubview(Screens.to.view)
        })
    }
    func OutStage(CGF: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeScale(CGF, CGF)
    }
    func OutStageController(InfoView: ViewinfoMe){
        let OutStageset:CGFloat = 2
        InfoView.view.alpha = 0
        InfoView.InfoLBL.transform = self.OutStage(OutStageset)
    }
    func InStageController(InfoView: ViewinfoMe){
        InfoView.view.alpha = 0.9
        InfoView.InfoLBL.transform = CGAffineTransformIdentity
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.Present = true
        return self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.Present = false
        return self
    }
}
