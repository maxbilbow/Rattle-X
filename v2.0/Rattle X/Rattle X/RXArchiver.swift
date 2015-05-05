//
//  RXCommonTasks.swift
//  Rattle X
//
//  Created by Max Bilbow on 13/04/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation




class RXArchiver : NSObject, NSFileManagerDelegate {
    
    let fileManager = NSFileManager.defaultManager()
    var keyPattern: String = "RM###"
    
    var availableArchives: [RXArchivePair] = []

    override func fileManager(fileManager: NSFileManager, shouldCopyItemAtURL srcURL: NSURL, toURL dstURL: NSURL) -> Bool {
        return fileManager.contentsEqualAtPath(srcUrL, andPath: dstURL) == false
    }

    
    override func awakeFromNib() {
        self.fileManager.delegate = self
    }
    ///Locates archive Master and Copy drives, if attached.
    ///@param key is the default or custom numbering of drives (e.g. RM001Master / RM001Slave )
    func findAttachedArchives(#key: String) -> AnyObject? {
        //search for archives matching the key and add them to available archives
        return nil
    }
    
    ///Syncs drives if everything is OK
    func syncDrives(archive pair: RXArchivePair) -> AnyObject? {
        if !pair.exists {
            return nil
        }
        
        if let status = compareArchive(archive: pair) {
            switch status {
            case .NO_CHANGE:
                return ArchiveStatus.NO_CHANGE.rawValue
            case .SLAVE_HAS_CHANGED:
                return ArchiveStatus.SLAVE_HAS_CHANGED.rawValue
            case .INVALID_ARCHIVE_PAIR:
                return ArchiveStatus.INVALID_ARCHIVE_PAIR.rawValue
            case .OUT_OF_SYNC:
                break //and go to nextstep (i.e. begin the sync)
                default:
                    return "unidentified drive state encountered in \(__FUNCTION__)"
            }
        } else {
            fatalError(__FILE__)
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
    
    
    ///Scans a
    func createMetaDataLog(archive pair: RXArchivePair) -> RXArchivePair? {
        if !pair.exists {
            return nil
        }
       
        return nil
    }
    
    func performSync(archive pair: RXArchivePair) -> AnyObject? {
        if !pair.exists {
            return nil
        }
        let error: NSErrorPointer
        self.fileManager.copyItemAtURL(pair.master!, toURL: pair.slave!, error: error)
        return nil
    }
    
    func compareArchive(archive pair: RXArchivePair) -> ArchiveStatus? {
        if !pair.exists {
            return .INVALID_ARCHIVE_PAIR
        }
        
        //scan master for changes from log; stop when change is found and return "Drives out of sync"
        //if Master data matches Master log file && slave log matches slave data, no sync needed
        return nil
    }
    
    ///After every successful sync, the redundant (slave/copy) location should be locked to prevent the user accidentally committing new data that could end up being overwritten during a sync. 
    ///@TODO: Add a method that checks a log for alterations before sync.
    func lockSlave(archive pair: RXArchivePair) -> AnyObject? {
        if !pair.exists {
            return nil
        }
        return nil
    }
    
    ///This will be called just before an existing archive is synced. Slave locations should be locked to prevent accidental overriting of new data
    ///This may also be called if the user is working form a slave drive and needs to unlock the files. Unadvised
    func unlockSlave(archive pair: RXArchivePair) -> AnyObject? {
        if !pair.exists {
            return nil
        }
        return nil
    }
    
    
}




