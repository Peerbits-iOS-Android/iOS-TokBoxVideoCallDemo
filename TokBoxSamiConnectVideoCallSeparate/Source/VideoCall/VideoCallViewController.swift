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
import PureLayout

class VideoCallViewController: UIViewController, VideoCallViewProtocol {
    
	var presenter                                   : VideoCallPresenterProtocol?
    @IBOutlet var btnMuteMic                        : UIButton!
    @IBOutlet var btnVideoOnOff                     : UIButton!
    @IBOutlet var btnMuteSpeaker                    : UIButton!
    @IBOutlet var btnCameraChange                   : UIButton!
    @IBOutlet weak var viewPublisher                : UIView!
    @IBOutlet weak var viewSubscriber               : UIView!
//    @IBOutlet weak var viewSubscriberFamilyMember   : UIView!
    @IBOutlet weak var stackViewSubscribers         : UIStackView!
    @IBOutlet weak var btnCall_publish              : UIButton!
    @IBOutlet weak var btnReceive_subscribe         : UIButton!
    
    @IBOutlet weak var btnMinimize: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    override func viewDidAppear(_ animated: Bool) {
        Timer.after(0.3) {
            self.callSaif()
        }
    }
    
    deinit {
        presenter?.screenWillDisappear()
        print("Deinit \(self.description)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.screenWillAppear()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupViews() {
        
        self.btnCameraChange.isEnabled = false
        self.btnCameraChange.alpha = 0.3
        self.btnMuteMic.isEnabled = false
        self.btnMuteMic.alpha = 0.3
        self.btnVideoOnOff.isEnabled = false
        self.btnVideoOnOff.alpha = 0.3
        self.btnMuteSpeaker.isEnabled = false
        self.btnMuteSpeaker.alpha = 0.3
        
        self.btnCall_publish.mk_addTapHandler { (btn) in
            self.callSaif()
        }
        
        self.btnVideoOnOff.mk_addTapHandler { (btn) in
            self.presenter?.btnVideoOnOffTapped()
        }
        
        self.btnReceive_subscribe.mk_addTapHandler { (btn) in
            self.callSaif()
        }
        
        self.btnMuteMic.mk_addTapHandler { (btn) in
            self.presenter?.btnMuteMiceTapped()
        }
        
        self.btnCameraChange.mk_addTapHandler { (btn) in
            self.presenter?.changeCameraTapped()
        }
        
        
        self.btnMuteSpeaker.mk_addTapHandler { (btn) in
            self.presenter?.muteSpeakerTapped()
        }
        
        self.btnMinimize.mk_addTapHandler { (btn) in
//            apde.addFloatView()
//            apde.addViewToFloat(viewVideo: self.view)
        }
        
    }
    
    func displayError(_ message: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
    
   
    func updateMuteMiceButton(_ isSelected: Bool) {
        self.btnMuteMic.isSelected = isSelected
    }
    
    func updateChangeCamera(isSelected: Bool) {
        self.btnCameraChange.isSelected = isSelected
    }
    
    func updateMuteSpeaker(isSelected: Bool) {
        self.btnMuteSpeaker.isSelected = isSelected
    }
    
    func dismissController() {
        self.endCall()
    }

}




// Replace with your OpenTok API key
let kApiKey = "46608962"
//// Replace with your generated session ID
//let kSessionId = "2_MX40NjYwODk2Mn5-MTU4NTE0MTA4MTc2Nn5zNXJxQWx2NXl5RmkvdkNESjVvRTNOaUF-fg"
//// Replace with your generated token
//let kToken = "T1==cGFydG5lcl9pZD00NjYwODk2MiZzaWc9NzNlNDcyZmU0ZGM5YjVhMzUyMjAyZGM1NGVhMTUyNGJlNTEwZjMxMjpzZXNzaW9uX2lkPTJfTVg0ME5qWXdPRGsyTW41LU1UVTROVEUwTVRBNE1UYzJObjV6TlhKeFFXeDJOWGw1Um1rdmRrTkVTalZ2UlROT2FVRi1mZyZjcmVhdGVfdGltZT0xNTg1NTYzNjcxJm5vbmNlPTAuNDI1Mzc4MDg1MDQzMzkwMTQmcm9sZT1wdWJsaXNoZXImZXhwaXJlX3RpbWU9MTU4ODE1NTY3MCZpbml0aWFsX2xheW91dF9jbGFzc19saXN0PQ=="

//68495c5edfcb2ee0afab3182dcee687b83014e2a

//// Replace with your OpenTok API key
//let kApiKey = "46630222"
//// Replace with your generated session ID
//let kSessionId = "1_MX40NjYzMDIyMn5-MTU4NTYzMDAyMTc5MX5vZ1JBMm4vYlBNcFhBK0ZLNDRxOEFFS1N-fg"
//// Replace with your generated token
//let kToken = "T1==cGFydG5lcl9pZD00NjYzMDIyMiZzaWc9YWMxZjhkYTU5ODJkYThiYWIzMGYzNDQ4Y2I3OTNlN2E3ODgzZjgxODpzZXNzaW9uX2lkPTFfTVg0ME5qWXpNREl5TW41LU1UVTROVFl6TURBeU1UYzVNWDV2WjFKQk1tNHZZbEJOY0ZoQkswWkxORFJ4T0VGRlMxTi1mZyZjcmVhdGVfdGltZT0xNTg1NjMwMDQ0Jm5vbmNlPTAuNDgwNjM3NTg3ODg1MDMwNCZyb2xlPXB1Ymxpc2hlciZleHBpcmVfdGltZT0xNTg2MjM0ODQzJmluaXRpYWxfbGF5b3V0X2NsYXNzX2xpc3Q9"


//let kWidgetHeight = 240
//let kWidgetWidth = 320

extension VideoCallViewController {

    func updateButtonIcons(_ micButtonSelected: Bool, speakerButtonSelected: Bool, cameraChangeButtonSelected: Bool, videoOnOffSelected: Bool) {
        self.btnMuteMic.isSelected = micButtonSelected
        self.btnMuteSpeaker.isSelected = speakerButtonSelected
        self.btnCameraChange.isSelected = cameraChangeButtonSelected
        self.btnVideoOnOff.isSelected = videoOnOffSelected
    }

    func callSaif() {
        self.btnCall_publish.loadingIndicator(true)
        self.presenter?.doConnect()
    }
    
    
    
    func doPublish(publisherView: UIView, isAudioChannelOnly: Bool) {
        
        self.btnCameraChange.isEnabled = true
        self.btnCameraChange.alpha = 1.0
        self.btnMuteMic.isEnabled = true
        self.btnMuteMic.alpha = 1.0
        self.btnVideoOnOff.isEnabled = true
        self.btnVideoOnOff.alpha = 1.0
        self.btnMuteSpeaker.isEnabled = true
        self.btnMuteSpeaker.alpha = 1.0
        
        print(isAudioChannelOnly)
        
        publisherView.mk_addConstraintsHeight(height: self.view.frame.height * 0.25)
        publisherView.layer.cornerRadius = 10
        publisherView.layer.masksToBounds = true
        publisherView.autoSetDimensions(to: CGSize.init(width: 99, height: 150))
        
        self.stackViewSubscribers.addArrangedSubview(publisherView)
        
        self.btnCall_publish.loadingIndicator(false)
        self.btnCall_publish.backgroundColor = #colorLiteral(red: 1, green: 0.2508518696, blue: 0.2691290379, alpha: 0)
        self.btnCall_publish.setTitle("", for: .normal)
        self.btnCall_publish.setImage(#imageLiteral(resourceName: "AssetRejectCall"), for: .normal)
        
        self.btnCall_publish.mk_addTapHandler { (btn) in
            self.endCall()
        }
        
        self.presenter?.getButtonIcons()
        
    }

    fileprivate func cleanupSubscriber() {
        self.presenter?.cleanupSubscriber()
    }

    fileprivate func cleanupPublisher() {
        self.presenter?.cleanupPublisher()
        self.btnCall_publish.setTitle("Connect Call", for: .normal)
        self.btnCall_publish.alpha = 1.0
        self.btnCall_publish.isEnabled = true
    }
    
    func subscriberDidConnect(subscriberView: UIView, isAudioChannelOnly : Bool) {
        
        if viewSubscriber.subviews.count == 0 {
            self.viewSubscriber.mk_addFourSideConstraintsInParent(childView: subscriberView)
        } else {
            subscriberView.mk_addConstraintsHeight(height: self.view.frame.height * 0.25)
            subscriberView.layer.cornerRadius = 10
            subscriberView.layer.masksToBounds = true
            subscriberView.autoSetDimensions(to: CGSize.init(width: 99, height: 150))
            self.stackViewSubscribers.addArrangedSubview(subscriberView)
            
            if isAudioChannelOnly {
                
                let imgView = UIImageView.init(image: UIImage.init(named: "AssetTranslatorHeadphones")!)
//                imgView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
                
                imgView.mk_addConstraintsHeight(height: 25)
                imgView.mk_addConstraintsWidth(width: 25)
                
                subscriberView.addSubview(imgView)
                
                imgView.centerXAnchor.constraint(equalTo: subscriberView.centerXAnchor).isActive = true
                imgView.centerYAnchor.constraint(equalTo: subscriberView.centerYAnchor).isActive = true
                
            }
            
        }
        
        self.btnCall_publish.backgroundColor = #colorLiteral(red: 1, green: 0.2508518696, blue: 0.2691290379, alpha: 0)
        self.btnCall_publish.setTitle("", for: .normal)
        self.btnCall_publish.setImage(#imageLiteral(resourceName: "AssetRejectCall"), for: .normal)
        
        self.btnCall_publish.alpha = 1.0
        self.btnCall_publish.isEnabled = true
        
        self.presenter?.getButtonIcons()

        self.btnCall_publish.mk_addTapHandler { (btn) in
            self.presenter?.callEndedByThisSide()
            self.endCall()
        }
    }
    
    func endCall() {
        
        self.presenter?.endCall()

        self.btnCall_publish.backgroundColor = #colorLiteral(red: 0.9480138421, green: 0.7052292824, blue: 0.1849106252, alpha: 1)
        self.btnCall_publish.setTitle("Connect Call", for: .normal)
        self.btnCall_publish.alpha = 1.0
        self.btnCall_publish.isEnabled = true
        
        self.cleanupSubscriber()
        self.cleanupPublisher()

        self.presenter?.getButtonIcons()

        self.btnCameraChange.isEnabled = false
        self.btnCameraChange.alpha = 0.3
        self.btnMuteMic.isEnabled = false
        self.btnMuteMic.alpha = 0.3
        self.btnVideoOnOff.isEnabled = false
        self.btnVideoOnOff.alpha = 0.3
        self.btnMuteSpeaker.isEnabled = false
        self.btnMuteSpeaker.alpha = 0.3
        
        self.btnCall_publish.mk_addTapHandler { (btn) in
            self.callSaif()
        }
        
        self.dismiss(animated: true, completion: nil)
        apde.isVideoCallRunning = false
    }
}

//private var window2: UIWindow!
//
//extension VideoCallViewController {
//    func present(animated: Bool, completion: (() -> Void)?) {
//        window2 = UIWindow(frame: UIScreen.main.bounds)
//        window2.rootViewController = UIViewController()
//        window2.windowLevel = .alert + 1
//        window2.makeKeyAndVisible()
//        window2.rootViewController?.present(self, animated: animated, completion: completion)
//    }
//
//    open override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        window2 = nil
//    }
//}




//class FloatingButtonController: UIViewController {
//
//    private(set) var button: UIButton!
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError()
//    }
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        window.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
//        window.isHidden = false
//        window.rootViewController = self
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(note:)), name: UIResponder.keyboardDidShowNotification, object: nil)
//    }
//
//    private let window = FloatingButtonWindow()
//
//    override func loadView() {
//        let view = UIView()
//
//        let viewCalling = ViewVideoCall.init()
//        let button = UIButton(type: .custom)
//        button.setTitle("Floating", for: .normal)
//        button.setTitleColor(UIColor.green, for: .normal)
//        button.backgroundColor = UIColor.white
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowRadius = 3
//        button.layer.shadowOpacity = 0.8
//        button.layer.shadowOffset = CGSize.zero
//        button.sizeToFit()
//        button.frame = CGRect(origin: CGPoint(x: 10, y: 10), size: button.bounds.size)
//        button.autoresizingMask = []
//        view.addSubview(button)
//        self.view = view
//        self.button = button
////        window.button = button
//
//        let panner = UIPanGestureRecognizer(target: self, action: #selector(panDidFire(panner:)))
//        button.addGestureRecognizer(panner)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        snapButtonToSocket()
//    }
//
//    @objc func panDidFire(panner: UIPanGestureRecognizer) {
//        let offset = panner.translation(in: view)
//        panner.setTranslation(CGPoint.zero, in: view)
//        var center = button.center
//        center.x += offset.x
//        center.y += offset.y
//        button.center = center
//
//        if panner.state == .ended || panner.state == .cancelled {
//            UIView.animate(withDuration: 0.3) {
//                self.snapButtonToSocket()
//            }
//        }
//    }
//
//    @objc func keyboardDidShow(note: NSNotification) {
//        window.windowLevel = UIWindow.Level(rawValue: 0)
//        window.windowLevel = UIWindow.Level(rawValue: CGFloat.greatestFiniteMagnitude)
//    }
//
//    private func snapButtonToSocket() {
//        var bestSocket = CGPoint.zero
//        var distanceToBestSocket = CGFloat.infinity
//        let center = button.center
//        for socket in sockets {
//            let distance = hypot(center.x - socket.x, center.y - socket.y)
//            if distance < distanceToBestSocket {
//                distanceToBestSocket = distance
//                bestSocket = socket
//            }
//        }
//        button.center = bestSocket
//    }
//
//    private var sockets: [CGPoint] {
//        let buttonSize = button.bounds.size
//        let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
//        let sockets: [CGPoint] = [
//            CGPoint(x: rect.minX, y: rect.minY),
//            CGPoint(x: rect.minX, y: rect.maxY),
//            CGPoint(x: rect.maxX, y: rect.minY),
//            CGPoint(x: rect.maxX, y: rect.maxY),
//            CGPoint(x: rect.midX, y: rect.midY)
//        ]
//        return sockets
//    }
//
//}
//
//private class FloatingButtonWindow: UIWindow {
//
////    var button: UIButton?
//    var viewCalling : ViewVideoCall!
//
//    init() {
//        super.init(frame: UIScreen.main.bounds)
//        backgroundColor = nil
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    fileprivate override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        guard let viewCalling = viewCalling else { return false }
//        let viewCallingPoint = convert(point, to: viewCalling)
//        return viewCalling.point(inside: viewCallingPoint, with: event)
//    }
//
//}