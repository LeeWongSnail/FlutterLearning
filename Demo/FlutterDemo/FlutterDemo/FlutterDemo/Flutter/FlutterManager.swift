//
//  FlutterManager.swift
//  FlutterDemo
//
//  Created by LeeWong on 2022/11/26.
//

import Foundation
import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant

final class FlutterManager {
    let flutterEngine: FlutterEngine
    let lifeCycleDelegate: FlutterPluginAppLifeCycleDelegate
    static let shared = FlutterManager()
    
    private init() {
        flutterEngine = FlutterEngine(name: "my flutter engine")
        lifeCycleDelegate = FlutterPluginAppLifeCycleDelegate()
    }
    
    func setup() {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        
    }
    
}
