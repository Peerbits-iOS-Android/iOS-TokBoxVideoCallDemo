//
//  ViewController.swift
//  TokBoxSamiConnectVideoCallSeparate
//
//  Created by Mushrankhan Pathan on 19/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}




extension UIButton {

    private class Action {
        var action: (UIButton) -> Void

        init(action: @escaping (UIButton) -> Void) {
            self.action = action
        }
    }

    private struct AssociatedKeys {
        static var ActionTapped = "actionTapped"
    }

    private var tapAction: Action? {
        set { objc_setAssociatedObject(self, &AssociatedKeys.ActionTapped, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &AssociatedKeys.ActionTapped) as? Action }
    }


    @objc dynamic private func handleAction(_ recognizer: UIButton) {
        tapAction?.action(recognizer)
    }


    func mk_addTapHandler(action: @escaping (UIButton) -> Void) {
        self.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        tapAction = Action(action: action)

    }
    
    
    
    
    private struct AssociatedKeys2 {
        static var _title = String()
        
    }
    
    var associated_title:String {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys2._title) as! String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys2._title, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.color = #colorLiteral(red: 0.03942008317, green: 0.009498601779, blue: 0.01263471786, alpha: 1)
            indicator.tintColor = #colorLiteral(red: 0.03942008317, green: 0.009498601779, blue: 0.01263471786, alpha: 1)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
            self.associated_title = self.titleLabel?.text ?? ""
            self.setTitle("", for: .normal)
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                self.setTitle(self.associated_title, for: .normal)
            }
        }
    }
    
    func mk_makeEnable(_ boolValue:Bool) {
        self.isEnabled = boolValue
        self.alpha = boolValue ? 1.0 : 0.5
    }
}


extension UIView {
    func mk_addFourSideConstraintsInParent(childView:UIView) {
        
        self.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: childView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        self.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
    func mk_addFourSideConstraintsInParent(childView:UIView,leftOffset:CGFloat,rightOffset:CGFloat,topOffset:CGFloat,bottomOffset:CGFloat) {
        
        self.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: topOffset)
        let bottomConstraint = NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: bottomOffset)
        
        let leadingConstraint = NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: leftOffset)
        let trailingConstraint = NSLayoutConstraint(item: childView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: rightOffset)
        
        self.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
    func mk_addConstraintsInParentWithSides(childView:UIView,leftSide:Bool=false,rightSide:Bool=false,topSide:Bool=false,bottomSide:Bool=false) {
        
        
        if childView.isDescendant(of: self) == false {
            self.addSubview(childView)
        }
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        if leftSide {
            let leadingConstraint = NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            self.addConstraints([leadingConstraint])
        }
        if rightSide {
            let trailingConstraint = NSLayoutConstraint(item: childView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            self.addConstraints([trailingConstraint])
        }
        if topSide {
            let topConstraint = NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            self.addConstraints([topConstraint])
        }
        if bottomSide {
            let bottomConstraint = NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            self.addConstraints([bottomConstraint])
        }
    }
    
    
    func mk_addConstraintsHeight(height:CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        self.addConstraints([heightConstraint])
    }
    
    func mk_addConstraintsWidth(width:CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        self.addConstraints([widthConstraint])
    }
}


extension RangeReplaceableCollection where Iterator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
        }
    }
    
}
