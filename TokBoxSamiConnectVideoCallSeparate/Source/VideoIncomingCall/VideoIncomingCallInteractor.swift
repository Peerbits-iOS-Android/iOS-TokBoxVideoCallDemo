//
//  VideoIncomingCallInteractor.swift
//  Sami
//
//  Created Kencor Health on 30/01/19.
//  Copyright © 2019 Kencor Health. All rights reserved .
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import OpenTok

class VideoIncomingCallInteractor: NSObject, VideoIncomingCallInteractorInputProtocol {
    
    
    weak var presenter                              : VideoIncomingCallInteractorOutputProtocol?
    private var videoCallMessage                    : VideoCallMessage!
    typealias BlockIncomingCallViewAcceptReject     = (Bool)->()
    var blockCallAcceptReject                       : BlockIncomingCallViewAcceptReject!
    
    
    init(videoCallMessage:VideoCallMessage, completionHandler: @escaping (Bool)->()) {
        super.init()
        self.videoCallMessage           = videoCallMessage
        self.blockCallAcceptReject      = completionHandler
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func callAccepted() {
        self.blockCallAcceptReject?(true)
    }
    
    func callRejected() {
        self.blockCallAcceptReject?(false)
    }
    
    func getMessageObject() -> VideoCallMessage {
        return self.videoCallMessage
    }
}
