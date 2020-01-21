//
//  LoginCall.swift
//  Learning2
//
//  Created by Max Burkhardt on 12.02.19.
//  Copyright © 2019 Max Burkhardt. All rights reserved.
//

import Foundation

enum FunctionalAdmin {
    case myself
    case functionalAdmin
}

protocol LoginCallDelegate {
    func successLMS(_ sender: LoginCalls)
    func successSF(_ sender: LoginCalls)
    func failLMS(_ sender: LoginCalls, errorDesc: String)
    func failSF(_ sender: LoginCalls, errorDesc: String)
}

enum Tenants: String {
    case LMSTST = "https://aldi-stage.plateau.com/"
    case LMSPRD = "https://aldi.plateau.com/"
    case SFTST = "https://api12preview.sapsf.eu/"
    case SFPRD = "https://api012.successfactors.eu/"

    init(string: String) {
        switch string {
        case "LMSTST": self = .LMSTST
        case "LMSPRD": self = .LMSPRD
        case "SFTST": self = .SFTST
        case "SFPRD": self = .SFPRD
        default:
            self = .SFTST
        }
    }
}

enum userTypeEnum: String {
    case user = "user"
    case admin = "admin"
    
    init(string: String) {
        switch string {
        case "user": self = .user
        case "admin": self = .admin
        default:
            self = .user
        }
    }
}

class LoginCalls {
    
    //Klassen
    var fetchService = ODataService()
    let sfOAuth = SFOAuthService()
//    let lmsOAuth = LMSOAuthService()
//    let keyManager = KeyChain()
    var contextUser: FunctionalAdmin
    let userId: String
    let userType: userTypeEnum
//    let lmsTenant: Tenants
    let sfTenant: Tenants
    
    //Delegate
    var delegate: LoginCallDelegate?
    
    //Init
    init(contextUser: FunctionalAdmin, userId: String, userType: userTypeEnum, sfTenant: Tenants){
    self.userId = userId
    self.userType = userType
//    self.lmsTenant = Tenants.init(string: keyManager.loadedLMSTenant())
    self.sfTenant = sfTenant
    self.contextUser = contextUser
    }
    
    //Variablen
    var SFToken: String = ""
    var time: Int = 0
    
    func finishLMS() {
        delegate?.successLMS(self)
    }
    func finishSF() {
        delegate?.successSF(self)
    }
    
    func finishFailLMS(errorDesc: String) {
        delegate?.failLMS(self, errorDesc: errorDesc)
    }
    func finishFailSF(errorDesc: String) {
        delegate?.failSF(self, errorDesc: errorDesc)
    }
    
    func loginSF(){
        
                self.sfOAuth.SFSAML(userID: self.userId, password: "", tenant: self.sfTenant, completion: { (resultSAML) in
                    switch resultSAML {
                        
                    case .Success(let result):
                        print("SAML Ergebnis: \(result)")
                        let assertion = result
                        
                        //
                        
                        //SF AUTH –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
                        
                        self.sfOAuth.SFToken(userID: self.userId, password: "", assertion: assertion, tenant: self.sfTenant, completion: { (result) in
                            switch result {
                                
                            case .Success(let json):
                                guard let token = json["access_token"] as? String else {return}
                                guard let time = json["expires_in"] as? Int else {return}
                                self.SFToken = token
                                self.time = time
                                
                                self.finishSF()
                                
                                //SF AUTH ERROR –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
                                
                            case .Error(let error):
                                print("SFAuth wirft folgenden error \(error.debugDescription)") //TODO: Errorhandling
                                self.finishFailSF(errorDesc: error.description)

                            }
                        })
                        
                        //SF SAML ERROR –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
                        
                    case .Error(let error):
//                        self.presentAlert(title: "SF SAML Fehler", message: error)
                        print("SAML wirft folgenden Error: \(error.debugDescription)") //TODO: Errorhandling
                        self.finishFailSF(errorDesc: error.description)
                    }
                })
    }
    
//    func loginLMS() { //Anhand des userKontextes werden hier 2 Routen eingeschlagen
//        switch self.contextUser {
//
//        case .functionalAdmin:
//
//            self.lmsOAuth.tokenCall(userId: "admin_burkhardt", userTypeInput: .admin, tenant: self.lmsTenant) { (result) in
//                switch result {
//                case .Success(let token):
//                    let key: String = token["access_token"] as! String
//
//                    //Für UserLogin: Eigener Kontext. Wenn Learning auf Absolviert werden soll benötige ich aber einen Admin. Der kann in Abhängigkeit der Initialisierung der Klasse dann gesetzt werden
//                    print("UserKontextLMS: Funktionsadmin")
//
//                    self.keyManager.saveLMSFunctionalAdminToken(key: key)
//                    self.finishLMS()
//
//                case .Error(let error):
//                    self.finishFailLMS(errorDesc: error.description)
//                }
//            }
//
//        case .myself:
//
//        self.lmsOAuth.tokenCall(userId: self.userId!, userTypeInput: self.userType, tenant: self.lmsTenant) { (result) in
//            switch result {
//
//            case .Success(let token):
//                let key: String = token["access_token"] as! String
//
//                self.keyManager.saveLMSToken(key: key)
//                print("UserKontextLMS: Selbst")
//                self.finishLMS()
//
//            case .Error(let error):
//                self.finishFailLMS(errorDesc: error.description)
//                }
//            }
//        }
//    }
}
