//
//  VideoCallMessage.swift
//  Sami
//
//  Created by Pathan Mushrankhan on 03/04/20.
//  Copyright © 2020 Ribbideo. All rights reserved.
//

import Foundation
import XMPPFramework

class VideoCallMessage: NSObject {
    
    class CallerSummery: NSObject {
        var userId          : String?
        var roleName        : String?
        var avatar          : String?
        var name            : String?
    }
    
    var apiKey          : String?
    var sessionId       : String?
    var token           : String?
    var ttlSeconds      : Int64?
    var messageType     : String?
    var callerSummery   : CallerSummery?
    
    init?(apiKey:String,sessionId:String,token:String) {
        self.sessionId = sessionId
        self.token = token
        self.apiKey = apiKey
    }
    
    init?(withXMPPMessage xmppMessage: XMPPMessage) {
        
        if let json = xmppMessage.jsonFromBody() as? Dictionary<String,Any> {
            
            guard let dictExtra = (json["extra"] as? [String:Any]) else {
                return
            }
            guard let callType = dictExtra["callType"] as? String else {
                return
            }
            if callType.lowercased() == "video" {
                if let messageType = json["messageType"] as? String {
                    self.messageType = messageType
                }
                
                if let dictBody = (json["body"] as? String)?.jsonFromBody() as? Dictionary<String,Any> {
                    if let sessionInfo = dictBody["sessionInfo"] as? Dictionary<String,Any> {
                        if let apiKey = sessionInfo["apiKey"] as? String {
                            self.apiKey = apiKey
                        }
                        if let sessionId = sessionInfo["sessionId"] as? String {
                            self.sessionId = sessionId
                        }
                        if let token = sessionInfo["token"] as? String {
                            self.token = token
                        }
                        if let ttlSeconds = sessionInfo["ttlSeconds"] as? Int64 {
                            self.ttlSeconds = ttlSeconds
                        }
                    }
                    
                    if let callerSummary = dictBody["callerSummary"] as? Dictionary<String,Any> {
                        let objCallerSummery = CallerSummery.init()
                        
                        if let userId = callerSummary["userId"] as? String {
                            objCallerSummery.userId = userId
                        }
                        if let roleName = callerSummary["roleName"] as? String {
                            objCallerSummery.roleName = roleName
                        }
                        if let avatar = callerSummary["avatar"] as? String {
                            objCallerSummery.avatar = avatar
                        }
                        if let name = callerSummary["name"] as? String {
                            objCallerSummery.name = name
                        }
                        self.callerSummery = objCallerSummery
                    }
                }
            }
        }
        
//        if let from = xmppMessage.attribute(forName: "from")?.stringValue, let nickname = from.split(separator: "/").last {
//            self.mine = String(nickname) == SessionData.shared.nickname
//        } else if let from = xmppMessage.element(forName: "delay")?.attributeStringValue(forName: "from") {
//            let id = from.split(separator: "@")[0]
//            self.mine = id.contains(SessionData.shared.authOutput.user.id)
//        }
    }
}



extension String {
    
    func jsonFromBody() -> Any? {
        if let jsonDataToVerify = self.data(using: String.Encoding.utf8)
        {
            do {
                let object = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                return object
            } catch {
                return nil
            }
        }
        return nil
    }
    
}



extension XMPPMessage {
    
    func jsonFromBody() -> Any? {
        guard let body = self.body else {
            return nil
        }
        if let jsonDataToVerify = body.data(using: String.Encoding.utf8)
        {
            do {
                let object = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                return object
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
