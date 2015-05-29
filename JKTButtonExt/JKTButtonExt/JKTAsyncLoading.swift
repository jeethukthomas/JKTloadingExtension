//
//  AsyncLoading.swift
//
//  Created by Jeethu on 28/05/15.
//  Copyright (c) 2015 jeethukthomas. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadBtn(color:UIColor? = UIColor.lightGrayColor(), needRoundEdge:Bool? = false)
    {
        self.layer.borderColor = color?.colorWithAlphaComponent(0.7).CGColor
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        
        if (self.layer.animationForKey("cornerRadius") == nil)
        {
            var cornerRadius:CGFloat = 2
            if (needRoundEdge != nil) && (needRoundEdge == true)
            {
                cornerRadius = (CGRectGetHeight(self.frame) == CGRectGetWidth(self.frame)) ? CGRectGetHeight(self.frame)/2 : ((CGRectGetHeight(self.frame) < CGRectGetWidth(self.frame)) ? CGRectGetHeight(self.frame)/2 : CGRectGetWidth(self.frame)/2)
                
                animation.fromValue = self.layer.cornerRadius
                animation.toValue = cornerRadius
                
                let animation2 = CABasicAnimation(keyPath: "borderWidth")
                animation2.fromValue = self.layer.borderWidth
                animation2.toValue = cornerRadius/15
                animation2.fillMode = kCAFillModeForwards
                animation2.removedOnCompletion = false
                self.layer.addAnimation(animation2, forKey: "borderWidth")
            }
            animation.duration = 0.1
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            self.layer.addAnimation(animation, forKey: "cornerRadius")
            
            
//            addActivity(color!)
            addCustomLoading(color!, side: cornerRadius*2)
            
            self.userInteractionEnabled = false;
            
        }
        else
        {
//                        unLoadBtn()
        }
    }
    
    func addCustomLoading(color:UIColor, side:CGFloat)
    {
        var image1:UIImageView = UIImageView(image: UIImage(named: "1.png"))
        var image2:UIImageView = UIImageView(image: UIImage(named: "2.png"))
        
        image1.tintColor = color
        image2.tintColor = color
        image1.tag = 7777
        image2.tag = 8888
        image1.userInteractionEnabled = false
        image2.userInteractionEnabled = false
        image1.alpha = 0.0
        image2.alpha = 0.0
        image1.image = image1.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        image2.image = image2.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        image1.frame = CGRectMake(side/4, side/4, side-side/2, side-side/2)
        image2.frame = CGRectMake(side/4, side/4, side-side/2, side-side/2)
        
        image1.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
        image2.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
        
        self.addSubview(image1)
        self.addSubview(image2)
        
        let animation1 = CABasicAnimation(keyPath: "transform.rotation.z")
        animation1.toValue = M_PI
        animation1.duration = 1;
        animation1.cumulative = true;
        animation1.repeatCount = HUGE;
        image1.layer.addAnimation(animation1, forKey: "rotate1")
        
        let animation2 = CABasicAnimation(keyPath: "transform.rotation.z")
        animation2.toValue = -M_PI
        animation2.duration = 0.5;
        animation2.cumulative = true;
        animation2.repeatCount = HUGE;
        image2.layer.addAnimation(animation2, forKey: "rotate2")
        
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            
          
            image1.alpha = 0.6
            image2.alpha = 0.6
            
            
            }, completion: { (completed:Bool) -> Void in
                
        })
        
        
        
       
        
        
    }
    
    func addActivity(color:UIColor)
    {
        var activity:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: (CGRectGetHeight(self.frame)<100 || CGRectGetWidth(self.frame)<100 ) ? UIActivityIndicatorViewStyle.White : UIActivityIndicatorViewStyle.WhiteLarge)
        activity.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)
        activity.color = color
        activity.tag = 77
        activity.userInteractionEnabled = false
        activity.startAnimating()
        self.addSubview(activity)
    }
    
    func unLoadBtn()
    {
        if (self.layer.animationForKey("cornerRadius") != nil)
        {
            let animation = CABasicAnimation(keyPath: "cornerRadius")
            animation.fillMode = kCAFillModeBackwards
            animation.duration = 0.1
            self.layer.addAnimation(animation, forKey: "cornerRadius")
            
            if (self.layer.animationForKey("borderWidth") != nil)
            {
                let animation2 = CABasicAnimation(keyPath: "borderWidth")
                animation.fillMode = kCAFillModeBackwards
                self.layer.addAnimation(animation, forKey: "borderWidth")
            }
            
            for view in self.subviews
            {
                if (view.dynamicType.description() == UIImageView.self.description()) && (view.tag == 7777 || view.tag == 8888)
                {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        (view as! UIView).alpha = 0
                        }, completion: { (completed:Bool) -> Void in
                            view.layer.removeAllAnimations()
                            view.removeFromSuperview()
                    })
                    
                }
            }
            
            self.userInteractionEnabled = true
        }
    }
}