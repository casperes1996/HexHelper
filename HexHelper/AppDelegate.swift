//
//  AppDelegate.swift
//  HexHelper
//
//  Created by Casper Sørensen on 21/06/2020.
//  Copyright © 2020 TheParallelThread. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let menuBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        menuBarItem.button?.title = "0x"
        menuBarItem.behavior = .terminationOnRemoval
        menuBarItem.button!.action = #selector(showMenu)
        menuBarItem.isVisible = true
        
    }
    
    @objc func showMenu() {
        let popover = NSPopover()
        popover.behavior = .transient
        let storyboard = NSStoryboard.init(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateController(withIdentifier: "menuBarView") as? ViewController else {fatalError("Could not make storyboard viewcontroller")}
        popover.contentViewController = controller
        popover.show(relativeTo: menuBarItem.button!.bounds, of: menuBarItem.button!, preferredEdge: .maxY)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

