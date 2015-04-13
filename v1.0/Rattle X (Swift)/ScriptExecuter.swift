//
//  ScriptExecuter.swift
//  Rattle X
//
//  Created by Max Bilbow on 04/01/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

import Foundation


class ScriptExecuter {
    var path, cmd, script, command: String
    
    init(){
        self.path = "~/"
        self.cmd = "echo "
        self.script = "rattle.sh"
        self.command = self.cmd + self.path + self.script
    }
    
    func setCommand (cmd: String){
        self.command = cmd
        
    }
    
    func setCommand (){
        self.command = self.cmd + self.path + self.script
    }
    
    func setPath(path: String){
        self.path = path
        
    }
    
    func setScript(script: String){
        self.script = script
        
    }
    
    func setCmd(cmd: String){
        self.cmd = cmd
        
    }
    
    func execute() ->String{
        system(self.command)
        return "\n Command Run: \n\(self.command)"
    }
    
    
    func execute(s: String){
        system(s)
        
    }
    
}


