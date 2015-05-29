//
//  AsyncLoading.swift
//
//  Created by Jeethu on 28/05/15.
//  Copyright (c) 2015 jeethukthomas. All rights reserved.
//

import UIKit

extension UIView {
    
    @objc func loadBtnForObjc(color:UIColor, needRoundEdge:Bool)
    {
        loadBtn(color: color, needRoundEdge: needRoundEdge)
    }
    
    func loadBtn(color:UIColor? = UIColor.lightGrayColor(), needRoundEdge:Bool? = false)
    {
        self.layer.borderColor = color?.CGColor
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        
        if (self.layer.animationForKey("cornerRadius") == nil)
        {
            if (needRoundEdge != nil) && (needRoundEdge == true)
            {
                let cornerRadius = (CGRectGetHeight(self.frame) == CGRectGetWidth(self.frame)) ? CGRectGetHeight(self.frame)/2 : ((CGRectGetHeight(self.frame) > CGRectGetWidth(self.frame)) ? CGRectGetHeight(self.frame)/5 : CGRectGetWidth(self.frame)/5)
                
                animation.fromValue = self.layer.cornerRadius
                animation.toValue = cornerRadius
                
                let animation2 = CABasicAnimation(keyPath: "borderWidth")
                animation2.fromValue = self.layer.borderWidth
                animation2.toValue = cornerRadius/15
                animation2.fillMode = kCAFillModeForwards
                animation2.removedOnCompletion = false
                self.layer.addAnimation(animation2, forKey: "borderWidth")
            }
            
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            self.layer.addAnimation(animation, forKey: "cornerRadius")
            
            
            addActivity(color!)
            
            
            self.userInteractionEnabled = false;
            
        }
        else
        {
            //                        unLoadBtn()
        }
    }
    
    
    private func addActivity(color:UIColor)
    {
        var activity:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: (CGRectGetHeight(self.frame)<100 || CGRectGetWidth(self.frame)<100 ) ? UIActivityIndicatorViewStyle.White : UIActivityIndicatorViewStyle.WhiteLarge)
        activity.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
        activity.color = color
        activity.tag = 77
        activity.userInteractionEnabled = false
        activity.startAnimating()
        self.addSubview(activity)
    }
    
    @objc func unLoadBtn()
    {
        if (self.layer.animationForKey("cornerRadius") != nil)
        {
            let animation = CABasicAnimation(keyPath: "cornerRadius")
            animation.fillMode = kCAFillModeBackwards
            self.layer.addAnimation(animation, forKey: "cornerRadius")
            
            if (self.layer.animationForKey("borderWidth") != nil)
            {
                let animation2 = CABasicAnimation(keyPath: "borderWidth")
                animation.fillMode = kCAFillModeBackwards
                self.layer.addAnimation(animation, forKey: "borderWidth")
            }
            
            for view in self.subviews
            {
                if (view.dynamicType.description() == UIActivityIndicatorView.self.description()) && view.tag == 77
                {
                    view.removeFromSuperview()
                }
            }
            
            self.userInteractionEnabled = true
        }
    }
}