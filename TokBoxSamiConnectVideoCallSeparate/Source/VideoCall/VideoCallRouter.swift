//
//  VideoCallRouter.swift
//  Sami
//
//  Created Kencor Health on 30/01/19.
//  Copyright © 2019 Kencor Health. All rights reserved .
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class VideoCallRouter: VideoCallWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(objVideoCallMessage:VideoCallMessage) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        
        let view            = UIStoryboard.init(name: "VideoCallStoryboard", bundle: nil).instantiateViewController(withIdentifier: "VideoCallViewController") as! VideoCallViewController
        let interactor      = VideoCallInteractor.init(objVideoCallMessage: objVideoCallMessage)
        let router          = VideoCallRouter()
        let presenter       = VideoCallPresenter.init(interface: view, interactor: interactor, router: router)
        
        view.presenter              = presenter
        interactor.presenter        = presenter
        router.viewController       = view

        return view
    }
    
    deinit {
        print("Deinit \(self)")
    }
}