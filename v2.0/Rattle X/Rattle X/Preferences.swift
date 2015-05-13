//
//  Preferences.swift
//  Rattle X
//
//  Created by Max Bilbow on 05/05/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

class Prefs {
    let CHECK_IN_PATH   = "checkInPath"
    let CHECK_OUT_PATH  = "checkOutPath"
    let RATTLE_UP_PATH  = "RattleUpPath"
    let DROPBOX         = "DROPBOX"
    let RATTLE_LOCAL    = "RattleLocalPath"
    let TEMP            = "temporaryPath"
    let FCPX            = "fcpxLocalPath"
    let CACHES          = "cachesPath"
    let MEDIA           = "fcpxGeneratedMedia"
    let BACKUPS         = "fcpxCloudBackup"
    let home = NSHomeDirectory()
    
    var localPrefs: Dictionary<String, String> = Dictionary<String, String>()
    
    
    
    var checkInPath: NSURL?
    var checkOutPath: NSURL?
    
    init(){
        self.setDefaults()
    }
    
    func getPref(key: String) -> String? {
        return self.localPrefs[DROPBOX]!
    }
    
    func setDefaults(){
        
        self.localPrefs[DROPBOX] = "\(self.home)/Dropbox"
        self.localPrefs[RATTLE_UP_PATH] = "\(self.localPrefs[DROPBOX]!)/Rattle Up"
        self.localPrefs[CHECK_IN_PATH] = "\(self.localPrefs[RATTLE_UP_PATH]!)/Production/Checked In"
        self.localPrefs[RATTLE_LOCAL] = "\(self.home)/Documents/Rattle Local"
        self.localPrefs[FCPX] = "\(self.localPrefs[RATTLE_LOCAL]!)/FCPX"
        self.localPrefs[TEMP] = "\(self.localPrefs[RATTLE_LOCAL]!)/TEMP"
        self.localPrefs[CACHES] = "\(self.localPrefs[TEMP]!)/FCPX CACHES"
        self.localPrefs[MEDIA] = "\(self.localPrefs[TEMP]!)/FCPX MEDIA"
        self.localPrefs[BACKUPS] = "\(self.localPrefs[RATTLE_UP_PATH]!)/Backups"
    }
    
    func validate(#pref: AnyObject?) -> Bool{
        let fm = NSFileManager.defaultManager()
        if fm.fileExistsAtPath(pref!.description) {
            println("\(pref) exists OK")
        } else {
            println("Select path: \(pref)")
        }
        return true
    }
    
    func askForNewPref(entry: (String, String)) -> String {
        return entry.1
    }
    
    func testPreferences(){
        let fm = NSFileManager.defaultManager()
        for entry in self.localPrefs {
            var path: String = ""
            if let pref = getPref(DROPBOX) {
                if self.validate(pref: pref) {
                    self.localPrefs[entry.0] = pref
            } else {
                self.localPrefs[entry.0] = self.askForNewPref(entry)
            }
        }
    }
    }
    
    var description: String {
        let fm = NSFileManager.defaultManager()
        
        var s = "\n"
        for pref in self.localPrefs {
            
            s += "\n   \(pref.0): '\(pref.1)', EXISTS: \(fm.fileExistsAtPath(pref.1))\n"
            
        }
        s += "\n"
        return s
    }
    
}