//
//  Util.swift
//  Weather App
//
//  Created by N4ve on 1/1/2568 BE.
//

import Foundation

struct AppInfo {
    
    /// Returns the official app name, defined in your project data.
    var appName : String {
        return readFromInfoPlist(withKey: "CFBundleName") ?? ""
    }
    
    /// Return the official app display name, eventually defined in your 'infoplist'.
    var displayName : String {
        return readFromInfoPlist(withKey: "CFBundleDisplayName") ?? ""
    }
    
    var apiKey : String {
        return readFromInfoPlist(withKey: "API_KEY") ?? ""
    }
    
    // MARK: - Private stuff
    
    // lets hold a reference to the Info.plist of the app as Dictionary
    private let infoPlistDictionary = Bundle.main.infoDictionary
    
    /// Retrieves and returns associated values (of Type String) from info.Plist of the app.
    private func readFromInfoPlist(withKey key: String) -> String? {
        return infoPlistDictionary?[key] as? String
    }
    
}
