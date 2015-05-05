//
//  Messages.swift
//  Rattle X
//
//  Created by Max Bilbow on 13/04/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation

///An archive consists of two external drives. Log file may be useful as well.
typealias RXArchivePair = RXArchive// (master:NSURL?, slave:NSURL?, logFile: NSURL?)


enum ArchiveStatus: Int { case OUT_OF_SYNC = 0, SLAVE_HAS_CHANGED, NEW_ARCHIVE, FORCE_OVERRITE_SLAVE, INVALID_ARCHIVE_PAIR, NO_CHANGE, PAIR_ON_SAME_DRIVE }

struct RXMessages {
    let Messages = [
        ArchiveStatus.OUT_OF_SYNC.rawValue          : "Changes have been found on the master drive",
        ArchiveStatus.SLAVE_HAS_CHANGED.rawValue    : "WARNING: The slave drive has been altered. Syncing will override these changes",
        ArchiveStatus.NEW_ARCHIVE.rawValue          : "Slave drive is empty and ready for first sync",
        ArchiveStatus.FORCE_OVERRITE_SLAVE.rawValue : "All data will be overritten, including new data found on Slave",
        ArchiveStatus.INVALID_ARCHIVE_PAIR.rawValue : "ERROR: Archives are not compatible",
        ArchiveStatus.NO_CHANGE.rawValue            : "Chill! Nothing seems to have changed since last time. If unsure, try using rsync",
        ArchiveStatus.PAIR_ON_SAME_DRIVE.rawValue   : "Both archives appear to be on the same drive. This does not protect from mechanical failure"
    ]
}


struct RXArchive {
    
    var master: NSURL?
    
    var slave: NSURL?
    
    ///Returns true if both URLs exist, as well as the directories they point to.
    var exists: Bool {
        if self.master != nil && self.slave != nil {
            let fm = NSFileManager()
            return fm.fileExistsAtPath(self.master!.path!)
                && fm.fileExistsAtPath(self.slave!.path!)
        }
        return false
    }
    
}