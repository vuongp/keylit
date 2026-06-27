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
        
        let targetBrightness = self.isActivated ? 0.0001 : 0
        
        _ = runBrightnessCmd(args: ["\(targetBrightness)"])
        
        sender.image = NSImage(systemSymbolName: "keyboard", accessibilityDescription: nil)
        sender.alphaValue = isActivated ? 1.0 : 0.5
    }
    
    /// Reads the current brightness level from the CLI to sync the UI
    private func syncState() {
        let output = runBrightnessCmd(args: [])
        
        if let pctString = output?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "Current brightness: ", with: ""),
           let pct = Double(pctString) {
            self.isActivated = pct > 0
        }
    }

    private func toggleBacklight() {
    }

    /// Helper to run the mac-brightnessctl binary
    private func runBrightnessCmd(args: [String]) -> String? {
        let process = Process()
        let pipe = Pipe()
        
        process.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/mac-brightnessctl")
        process.arguments = args
        process.standardOutput = pipe
        
        do {
            try process.run()
            process.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8)
        } catch {
            print("Failed to run mac-brightnessctl: \(error)")
            return nil
        }
    }
}
