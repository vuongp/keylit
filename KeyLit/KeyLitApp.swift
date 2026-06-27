//
//  KeyLitApp.swift
//  KeyLit
//
//  Created by Vuong Pham on 27/06/2026.
//

import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    let menuBarController = MenuBarController()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        menuBarController.setupMenuBar()
    }
}

@main
struct KeyLitApp: App {
    // Tells SwiftUI to use our AppKit delegate setup
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // Empty scene so the app runs invisibly in the background
        Settings {
            EmptyView()
        }
    }
}
