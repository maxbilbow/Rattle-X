//
//  ViewController.swift
//  Rattle X (Swift)
//
//  Created by Max Bilbow on 19/02/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func start(sender: AnyObject) {
        RattleX().run()
    }
    
    @IBAction func whoop(sender: AnyObject) {
        println("Whoop!")
    }
}


class RattleX {
    let PATH = "'/Volumes/Rattle X/root/Library/Application Support/Rattle X/'"
    let localPath = "'Rattle X/'" //Users/rattle/Library/Mobile Documents/com~apple~CloudDocs/Rattle Apps/RattleApps/RattleApps 0.2.0/X/X/'"
    let SCRIPT = "install.sh"
    
    
    func run() {
        
        var x =  ScriptExecuter()
        
        x.setCommand("cd \(PATH) && sh \(SCRIPT)")
        x.execute()
        
        // std::cout << "Running: " << x.execute() << std::endl
        //x.execute()
        // myfile.sh should be chmod +x
    }
}

