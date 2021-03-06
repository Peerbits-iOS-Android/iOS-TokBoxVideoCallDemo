//
//  MessengerViewController.swift
//  Sami
//
//  Created Kencor Health on 30/01/19.
//  Copyright © 2019 Kencor Health. All rights reserved .
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
//import GrowingTextView
//import SVProgressHUD
//import IQKeyboardManagerSwift
import OpenTok
import Haptica
//import Kingfisher

class VideoIncomingCallViewController: UIViewController, VideoIncomingCallViewProtocol {
    
	var presenter                                   : VideoIncomingCallPresenterProtocol?
    @IBOutlet var btnAccept                         : UIButton!
    @IBOutlet var btnReject                         : UIButton!
    @IBOutlet var lblCallingUserName                : UILabel!
    @IBOutlet var imgViewCallingUser                : UIImageView!
    @IBOutlet weak var cntrBottomCallingView        : NSLayoutConstraint!
    @IBOutlet weak var viewBackBlur                 : UIVisualEffectView!
    var timerAnimation                              : Timer!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.imgViewCallingUser.layer.cornerRadius = self.imgViewCallingUser.frame.width/2
        
        UIView.animate(withDuration: 0.3, animations: {
            self.viewBackBlur.alpha = 1
        }) { (s) in
            
        }
    }
    
    deinit {
        presenter?.screenWillDisappear()
        print("Deinit \(self.description)")
    }
    
    private func setupViews() {

        self.viewBackBlur.alpha = 0
        self.imgViewCallingUser.clipsToBounds = true
        self.imgViewCallingUser.layer.cornerRadius = self.imgViewCallingUser.frame.width/2
        self.imgViewCallingUser.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.imgViewCallingUser.layer.borderWidth = 1
        
        if let objVideoCallMessage = presenter?.getMessageObject() {
            self.lblCallingUserName.text = objVideoCallMessage.callerSummery?.name ?? ""
            let url = URL(string: objVideoCallMessage.callerSummery?.avatar ?? "")
//            self.imgViewCallingUser.kf.setImage(with: url)
        }
        
        self.btnAccept.mk_addTapHandler { (btn) in
            
            UIView.animate(withDuration: 0.2, animations: {
                self.viewBackBlur.alpha = 0
            }) { (s) in
                
                self.dismiss(animated: true, completion: {
                    self.presenter?.callAccepted()
                })
            }
            
            
        }
        
        self.btnReject.mk_addTapHandler { (btn) in
            UIView.animate(withDuration: 0.2, animations: {
                self.viewBackBlur.alpha = 0
            }) { (s) in
                
                self.dismiss(animated: true, completion: {
                    self.presenter?.callRejected()
                })
            }
        }

        
        self.callingSoundAndVibrations()
        self.timerAnimation = Timer.every(2.5) {
            self.callingSoundAndVibrations()
        }
        
        
    }
    
    func callingSoundAndVibrations() {
        AudioServicesPlaySystemSound (1151)
        self.cntrBottomCallingView.constant = 62
        Haptic.play("..oOOO-OOOo..", delay: 0.5)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
            self.view.layoutIfNeeded()
        }) { (isSuccess) in
            
            Haptic.play("..oOOO-OOOo..", delay: 0.5)
            self.cntrBottomCallingView.constant = 58
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
                self.view.layoutIfNeeded()
            }) { (isSuccess) in
                
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timerAnimation.invalidate()
    }
    
//
//    func displayError(_ message: String) {
//        DispatchQueue.main.async {
//            let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(controller, animated: true, completion: nil)
//        }
//    }
//
//
//    func updateMuteMiceButton(_ isSelected: Bool) {
//        self.btnMuteMic.isSelected = isSelected
//    }
//
//    func updateChangeCamera(isSelected: Bool) {
//        self.btnCameraChange.isSelected = isSelected
//    }
//
//    func updateMuteSpeaker(isSelected: Bool) {
//        self.btnMuteSpeaker.isSelected = isSelected
//    }
    

}


