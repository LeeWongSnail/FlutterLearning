//
//  ViewController.swift
//  FlutterDemo
//
//  Created by LeeWong on 2022/11/26.
//

import UIKit
import Flutter

//class ViewController: UIViewController {
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Make a button to call the showFlutter function when pressed.
//    let button = UIButton(type:UIButton.ButtonType.custom)
//    button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
//    button.setTitle("Show Flutter!", for: UIControl.State.normal)
//    button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
//    button.backgroundColor = UIColor.blue
//    self.view.addSubview(button)
//  }
//
//    @objc func showFlutter() {
////        let flutterEngine = FlutterManager.shared.flutterEngine
////        let flutterViewController =
////        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
////        present(flutterViewController, animated: true)
//
////        let flutterEngine = FlutterManager.shared.flutterEngine
//        let flutterViewController = FlutterViewController(project: nil, nibName: nil, bundle: nil)
//        flutterViewController.view.backgroundColor = .white
//        present(flutterViewController, animated: true)
//
//
////        let channelName = "com.yinxiang.flutterDemo"
////        var methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
////        methodChannel.setMethodCallHandler { call, result in
////            print("--->call.method \(call.method), call.arguments \(call.arguments)")
////        }
//
//    }
//}

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Make a button to call the showFlutter function when pressed.
    let button = UIButton(type:UIButton.ButtonType.custom)
    button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
    button.setTitle("Show Flutter!", for: UIControl.State.normal)
    button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
    button.backgroundColor = UIColor.blue
    self.view.addSubview(button)
  }

  @objc func showFlutter() {
    let flutterViewController = FlutterViewController(project: nil, initialRoute: "myApp", nibName: nil, bundle: nil)
      flutterViewController.view.backgroundColor = .white
      let channelName = "native/flutter"
      let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
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
          } else if call.method == "iosFlutter1", let arguements = call.arguments as? [String: Any] {
              print(arguements)
              if let data = try? JSONSerialization.data(withJSONObject: arguements), let str = String(data: data, encoding: .utf8) {
                  DispatchQueue.main.async {
                      let alertController = UIAlertController(title: "flutter传递过来的参数", message: str, preferredStyle: .alert)
                      alertController.addAction(UIAlertAction(title: "确定", style: .cancel))
                      self?.present(alertController, animated: true)
                  }
              }
          } else if call.method == "iosFlutter2" {
              result("这是native返回给flutter的值")
          } else if call.method == "iOSFlutter", let title = call.arguments as? String {
              let firstVc = FirstViewController()
              firstVc.title = title
              self?.navigationController?.pushViewController(firstVc, animated: true)
          }
      }
      navigationController?.pushViewController(flutterViewController, animated: true)
      
      DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
          methodChannel.invokeMethod("iosInvokeFlutter", arguments: "argument from native") { result in
              print(result)
          }
      }
  }
}



