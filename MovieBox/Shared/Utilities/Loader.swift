//
//  Loader.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit

fileprivate let viewTag = 14531453

class Loader {
    
    class func show(_ customView: UIView? = nil) {
        DispatchQueue.main.async {
            let bgView = UIView()
            let loadingIndicator = UIActivityIndicatorView()
            
            loadingIndicator.style = .whiteLarge
            loadingIndicator.color = .white
            var view = UIView()
            if let customView = customView {
                view = customView
            } else {
                if let window = UIApplication.shared.keyWindow {
                    view = window
                }
            }
            
            bgView.frame = view.frame
            bgView.tag = viewTag
            bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            loadingIndicator.frame = CGRect(x: (view.frame.width / 2) - 25, y: (view.frame.height / 2) - 25, width: 50, height: 50)
            loadingIndicator.startAnimating()
            bgView.addSubview(loadingIndicator)
            view.addSubview(bgView)
        }
    }
    
    class func hide(_ customView: UIView? = nil) {
        DispatchQueue.main.async {
            var view = UIView()
            if let customView = customView {
                view = customView
            } else {
                if let window = UIApplication.shared.keyWindow {
                    view = window
                }
            }
            view.viewWithTag(viewTag)?.removeFromSuperview()
        }
    }
}
