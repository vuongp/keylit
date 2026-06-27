//
//  KeyboardBrightnessManager.swift
//  KeyLit
//

import Foundation

@objc protocol KeyboardBrightnessClientProtocol: NSObjectProtocol {
    @objc(isAutoBrightnessEnabledForKeyboard:)
    func isAutoBrightnessEnabled(forKeyboard keyboard: UInt64) -> Bool
    
    @objc(isIdleDimmingSuspendedOnKeyboard:)
    func isIdleDimmingSuspended(onKeyboard keyboard: UInt64) -> Bool
    
    @objc(suspendIdleDimming:forKeyboard:)
    func suspendIdleDimming(_ suspend: Bool, forKeyboard keyboard: UInt64) -> Bool
    
    @objc(setIdleDimTime:forKeyboard:)
    func setIdleDimTime(_ time: Double, forKeyboard keyboard: UInt64) -> Bool
    
    @objc(idleDimTimeForKeyboard:)
    func idleDimTime(forKeyboard keyboard: UInt64) -> Double
    
    @objc(isKeyboardBuiltIn:)
    func isKeyboardBuiltIn(_ keyboard: UInt64) -> Bool
    
    @objc(isAmbientFeatureAvailableOnKeyboard:)
    func isAmbientFeatureAvailable(onKeyboard keyboard: UInt64) -> Bool
    
    @objc(enableAutoBrightness:forKeyboard:)
    func enableAutoBrightness(_ enable: Bool, forKeyboard keyboard: UInt64) -> Bool
    
    @objc(setBrightness:fadeSpeed:commit:forKeyboard:)
    func setBrightness(_ brightness: Float, fadeSpeed: Int32, commit: Bool, forKeyboard keyboard: UInt64) -> Bool
    
    @objc(setBrightness:forKeyboard:)
    func setBrightness(_ brightness: Float, forKeyboard keyboard: UInt64) -> Bool
    
    @objc(brightnessForKeyboard:)
    func brightness(forKeyboard keyboard: UInt64) -> Float
    
    @objc(isBacklightDimmedOnKeyboard:)
    func isBacklightDimmed(onKeyboard keyboard: UInt64) -> Bool
    
    @objc(isBacklightSaturatedOnKeyboard:)
    func isBacklightSaturated(onKeyboard keyboard: UInt64) -> Bool
    
    @objc(isBacklightSuppressedOnKeyboard:)
    func isBacklightSuppressed(onKeyboard keyboard: UInt64) -> Bool
    
    @objc(copyKeyboardBacklightIDs)
    func copyKeyboardBacklightIDs() -> AnyObject?
}

class KeyboardBrightnessManager {
    static let shared = KeyboardBrightnessManager()
    
    private var brightnessClient: KeyboardBrightnessClientProtocol?
    private let keyboardId: UInt64 = 1
    
    private init() {
        let bundlePath = "/System/Library/PrivateFrameworks/CoreBrightness.framework"
        guard let bundle = Bundle(path: bundlePath) else {
            print("Failed to find CoreBrightness.framework bundle at path: \(bundlePath)")
            return
        }
        
        if !bundle.isLoaded {
            guard bundle.load() else {
                print("Failed to load CoreBrightness.framework")
                return
            }
        }
        
        guard let clientClass = NSClassFromString("KeyboardBrightnessClient") as? NSObject.Type else {
            print("Failed to find KeyboardBrightnessClient class in runtime")
            return
        }
        
        let clientInstance = clientClass.init()
        self.brightnessClient = unsafeBitCast(clientInstance, to: KeyboardBrightnessClientProtocol.self)
    }
    
    func setBrightness(_ brightness: Float) {
        _ = brightnessClient?.setBrightness(brightness, forKeyboard: keyboardId)
    }
    
    func getBrightness() -> Float {
        return brightnessClient?.brightness(forKeyboard: keyboardId) ?? 0.0
    }
    
    func isAutoBrightnessEnabled() -> Bool {
        return brightnessClient?.isAutoBrightnessEnabled(forKeyboard: keyboardId) ?? false
    }
    
    func isIdleDimmingSuspended() -> Bool {
        return brightnessClient?.isIdleDimmingSuspended(onKeyboard: keyboardId) ?? false
    }
    
    func setSuspendIdleDimming(_ value: Bool) {
        _ = brightnessClient?.suspendIdleDimming(value, forKeyboard: keyboardId)
    }
    
    func setIdleDimTime(_ value: Double) {
        _ = brightnessClient?.setIdleDimTime(value, forKeyboard: keyboardId)
    }
    
    func idleDimTimeForKeyboard() -> Double {
        return brightnessClient?.idleDimTime(forKeyboard: keyboardId) ?? 0.0
    }
    
    func enableAutoBrightness(_ value: Bool) {
        _ = brightnessClient?.enableAutoBrightness(value, forKeyboard: keyboardId)
    }
    
    func flashKeyboardLights(times: Int, interval: Double, fadeSpeed: Int32) {
        let current = getBrightness()
        for _ in 0..<times {
            _ = brightnessClient?.setBrightness(0.0, fadeSpeed: fadeSpeed, commit: true, forKeyboard: keyboardId)
            Thread.sleep(forTimeInterval: interval)
            _ = brightnessClient?.setBrightness(1.0, fadeSpeed: fadeSpeed, commit: true, forKeyboard: keyboardId)
            Thread.sleep(forTimeInterval: interval)
        }
        setBrightness(current)
    }
}
