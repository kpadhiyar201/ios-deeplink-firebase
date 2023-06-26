//
//  ViewController.swift
//  iOS Deeplink
//
//  Created by Kiran Padhiyar on 16/06/23.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        createDynamicLink()
    }

    private func createDynamicLink() {
        guard let link = URL(string: "https://dev.starcam.com/presenter/event/live/2504/eyJpdiI6IlBZZzBTd0ZNZVFSNVlzWERKZllvWFE9PSIsInZhbHVlIjoiejhzNCtGQjZmc084dytwRCtVM05iSjRONjk4eUtaaGRrajJLYWtncFNML1VHR2NJaHRiWjA3dDRieGtIK1NHc1pXd1ZCSnFKUlpnWFM4S3F2TGxFQnI5SkFBaEhnZ3o0dFRMUXFsdE5HZWs9IiwibWFjIjoiMjgyNTEyYzg0M2ExOTRkZjFhZjY4ZjhlNWZjYjE3MmZjMGE5NmQyMGNhMzMwZWIxOTljNTg2MTdkOWJlZTRmOSIsInRhZyI6IiJ9") else { return }
        let dynamicLinksDomainURIPrefix = "https://starcamdeeplink.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.steer-tech.parkingapp")
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.steer-tech.parkingapp")
        
        guard let longDynamicLink = linkBuilder?.url else { return }
        print("The long URL is: \(longDynamicLink.absoluteString)")
        linkBuilder?.shorten() { url, warnings, error in
            guard let url = url, error == nil else {
                print(error?.localizedDescription)
                return
            }
            print("The short URL is: \(url)")
            UIPasteboard.general.string = url.absoluteString
        }
    }
}

