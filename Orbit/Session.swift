//
//  Session.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//
import Foundation

class Session: Codable {
    let cycles:Int
    let activityLength:Int
    let breakLength:Int
    let activityName:String
    
    init(cycles : Int, activityLength: Int, breakLength: Int, activityName: String) {
        self.cycles = cycles
        self.activityLength = activityLength
        self.breakLength = breakLength
        self.activityName = activityName
    }
    
    public static func saveSession(session: Session){
        var sessionArray = getSessions()
        sessionArray?.append(session)
        let sessionsData = try! JSONEncoder().encode(sessionArray)
        UserDefaults.standard.set(sessionsData, forKey: "sessions")
    }

    public static func getSessions() -> [Session]?{
        if let sessionData = UserDefaults.standard.data(forKey: "sessions") {
            let sessionArray = try! JSONDecoder().decode([Session].self, from: sessionData)
            return sessionArray
        }
        return []
    }
}
