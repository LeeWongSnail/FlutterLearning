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
    let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
    let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    present(flutterViewController, animated: true, completion: nil)
  }
}



