//
//  InterfaceController.swift
//  tokenTap Extension
//
//  Created by Jeffro on 7/9/19.
//  Copyright © 2019 Fedora Project. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var session: WCSession!
    @IBOutlet var tokenButton: WKInterfaceButton!
    @IBOutlet var otpLabel: WKInterfaceLabel!
    
    
    
    @IBAction func tokenButtonTapped() {
        session.sendMessage(["request":"topToken"], replyHandler: { (response) in
            print(response)
            self.clearButton()
        }) { (error) in
            print(error)
        }
        self.tokenButton.setTitle("Sent")
    }
    
    @objc func clearButton(){
        self.tokenButton.setTitle("")
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported(){
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
        tokenButton.setTitle("")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        WKInterfaceDevice().play(.click)
    }

}
