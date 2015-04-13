//
//  RXCommonTasks.swift
//  Rattle X
//
//  Created by Max Bilbow on 13/04/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


///An archive consists of two external drives. Log file may be useful as well.
typealias RXArchivePair = (master:NSURL?, slave:NSURL?, logFile: NSURL?)

class RXArchiver : NSObject, NSFileManagerDelegate {
    
    let fileManager: NSFileManager = NSFileManager()

    override func awakeFromNib() {
        self.fileManager.delegate = self
    }
    ///Locates archive Master and Copy drives, if attached.
    ///@param key is the default or custom numbering of drives (e.g. RM001Master / RM001Slave )
    func findAttachedArchives(#key: String) -> RXArchivePair? { return nil }
    
    ///Syncs drives if everything is OK
    func syncDrives(archive pair: RXArchivePair) -> AnyObject? {
        
        if let error: AnyObject = compareArchive(archive: pair) {
            return error
        }
        
        if let error: AnyObject = unlockSlave(archive: pair) {
            return error
        }
        
        if let error: AnyObject = performSync(archive: pair) {
            return error
        }
        
        if let error: AnyObject = lockSlave(archive: pair) {
            return error
        }
        
        
        return nil
    }
    
    func performSync(archive pair: RXArchivePair) -> AnyObject? { return nil }
    
    func compareArchive(archive pair: RXArchivePair) -> AnyObject? { return nil }
    
    func lockSlave(archive pair: RXArchivePair) -> AnyObject? { return nil }
    
    func unlockSlave(archive pair: RXArchivePair) -> AnyObject? { return nil }
    
    
}

class RXArchive {
    private var archivePair: RXArchivePair = (nil,nil,nil)
    
    var master: NSURL? {
        return self.archivePair.master
    }
    
    var slave: NSURL? {
        return self.archivePair.slave
    }
    
    var logFile: NSURL? {
        return self.archivePair.logFile
    }
    
}