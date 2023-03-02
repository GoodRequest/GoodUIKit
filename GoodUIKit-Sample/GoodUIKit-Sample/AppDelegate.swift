//
//  AppDelegate.swift
//  GoodUIKit-Sample
//
//  Created by Andrej Jasso on 02/03/2023.
//

import UIKit
import GoodUIKitCombine
import GoodUIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dismissCancellable: AnyCancellable?
    var pushCancellable: AnyCancellable?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        window.backgroundColor = .white
        let controller = UIViewController()
        controller.view.backgroundColor = .green.withAlphaComponent(0.2)
        let navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let pushButton = UIButton(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
        pushButton.backgroundColor = .cyan.withAlphaComponent(0.5)
        pushButton.setTitle("Click to push", for: .normal)
        pushButton.gr.circleMasked()
        controller.view.addSubview(pushButton)


        pushCancellable = pushButton.gr.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let secondController = UIViewController()
                secondController.view.backgroundColor = .red.withAlphaComponent(0.2)
                navigationController.present(secondController, animated: true)

                let dismissButton = UIButton(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
                dismissButton.backgroundColor = .blue.withAlphaComponent(0.5)
                dismissButton.setTitle("Click to dismiss", for: .normal)
                dismissButton.gr.circleMasked()

                secondController.view.addSubview(dismissButton)

                self?.dismissCancellable = dismissButton.gr.publisher(for: .touchUpInside)
                    .sink { _ in
                        secondController.dismiss(animated: true)
                    }
            }

        return true
    }


}

