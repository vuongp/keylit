import AppKit
import SwiftUI

class MenuBarController: NSObject {
    var statusItem: NSStatusItem?
    var isActivated = false

    func setupMenuBar() {
        syncState()
        // Create the item in the system bar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            // Set the initial icon
            button.image = NSImage(systemSymbolName: "keyboard", accessibilityDescription: nil)
            button.alphaValue = isActivated ? 1.0 : 0.5
            
            // Link the click event directly to our action
            button.target = self
            button.action = #selector(statusBarButtonClicked(_:))
        }
    }

    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        isActivated.toggle()
        
        let targetBrightness: Float = self.isActivated ? 0.0001 : 0.0
        
        KeyboardBrightnessManager.shared.setBrightness(targetBrightness)
        
        sender.image = NSImage(systemSymbolName: "keyboard", accessibilityDescription: nil)
        sender.alphaValue = isActivated ? 1.0 : 0.5
    }
    
    /// Reads the current brightness level from the manager to sync the UI
    private func syncState() {
        let pct = KeyboardBrightnessManager.shared.getBrightness()
        self.isActivated = pct > 0
    }

    private func toggleBacklight() {
    }
}
