//
//  FirstViewController.swift
//  FlutterDemo
//
//  Created by LeeWong on 2022/11/29.
//

import Foundation
import UIKit
import Flutter

class FirstViewController: UIViewController {
    
    private var eventSink: FlutterEventSink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "原生页面"
        
        button.frame = CGRect(x: 100, y: 100, width: 150, height: 30)
        secondButton.frame = CGRect(x: 100, y: 300, width: 150, height: 30)

    }
    
    
    @objc func buttonDidClick() {
        let flutterViewController = FlutterViewController(project: nil, initialRoute: "home", nibName: nil, bundle: nil)
        
        let eventChannelName = "wg/native_post"
        let methodChannelName = "wg/native_get"
        
        let eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: flutterViewController.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        let methodChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: flutterViewController.binaryMessenger)
        methodChannel.setMethodCallHandler { [weak self] call, result in
            print(call.method)
            
            if call.method == "changeNavStatus", let arguements = call.arguments as? String {
                if arguements.hasSuffix("show") {
                    self?.navigationController?.setNavigationBarHidden(false, animated: true)
                } else {
                    self?.navigationController?.setNavigationBarHidden(true, animated: true)
                }
            } else if call.method == "backToViewController" {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        navigationController?.pushViewController(flutterViewController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.eventSink?("这是我外部设置的值")
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.setTitle("调用flutter方法", for: .normal)
        button.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.setTitle("调用flutter方法", for: .normal)
        button.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
}


extension FirstViewController: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
