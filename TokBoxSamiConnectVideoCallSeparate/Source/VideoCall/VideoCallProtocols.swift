//
//  VideoCallProtocols.swift
//  Sami
//
//  Created Kencor Health on 30/01/19.
//  Copyright © 2019 Kencor Health. All rights reserved .
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import UIKit

//MARK: Wireframe -
protocol VideoCallWireframeProtocol: class {

}
//MARK: Presenter -
protocol VideoCallPresenterProtocol: class {

    var interactor: VideoCallInteractorInputProtocol? { get set }
    func screenWillDisappear()
    func btnMuteMiceTapped()
    func btnVideoOnOffTapped()
    func changeCameraTapped()
    func muteSpeakerTapped()
    func doConnect()
    func cleanupSubscriber()
    func cleanupPublisher()
    func getButtonIcons()
    func endCall()
    func didDisConnectDismissView()
    func callEndedByThisSide()
    func screenWillAppear()
}

//MARK: Interactor -
protocol VideoCallInteractorOutputProtocol: class {
//    func didReceiveMessage(_ message: Message)
    func didJoinRoom()
    func doPublish(publisherView:UIView,isAudioChannelOnly:Bool)
    func didUpdateBtnMuteMice(isSelected:Bool)
    func updateChangeCamera(isSelected:Bool)
    func updateMuteSpeaker(isSelected:Bool)
    func displayError(_ message:String)
    func updateButtonIcons(_ micButtonSelected:Bool, speakerButtonSelected:Bool, cameraChangeButtonSelected:Bool, videoOnOffSelected:Bool)
    func subscriberDidConnect(subscriberView:UIView,isAudioChannelOnly:Bool)
    func didDisConnectDismissView()

    /* Interactor -> Presenter */
}

protocol VideoCallInteractorInputProtocol: class {

    var presenter: VideoCallInteractorOutputProtocol?  { get set }
    func doConnect()
    func btnMuteMiceTapped()
    func changeCameraTapped()
    func muteSpeakerTapped()
    func cleanupSubscriber()
    func cleanupPublisher()
    func updateButtonIcons()
    func doPublish()
    func endCall()
    func getButtonIcons()
    func subscribeToVideo()
    func callEndedByThisSide()
    /* Presenter -> Interactor */
}

//MARK: View -
protocol VideoCallViewProtocol: class {

    var presenter: VideoCallPresenterProtocol?  { get set }
    func doPublish(publisherView:UIView,isAudioChannelOnly:Bool)
    func updateMuteMiceButton(_ isSelected: Bool)
    func updateChangeCamera(isSelected:Bool)
    func updateMuteSpeaker(isSelected:Bool)
    func displayError(_ message:String)
    func updateButtonIcons(_ micButtonSelected:Bool, speakerButtonSelected:Bool, cameraChangeButtonSelected:Bool, videoOnOffSelected:Bool)
    func subscriberDidConnect(subscriberView:UIView,isAudioChannelOnly:Bool)
    func dismissController()

    /* Presenter -> ViewController */
}
