//
//  GuestDetailViewController.swift
//  GuestConnect
//
//  Created by Richard Sunden on 12/7/19.
//  Copyright © 2019 Richard Sunden. All rights reserved.
//

import UIKit

class GuestDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var snapchatButton: UIButton!
    
    var guestDetail: GuestDetail = GuestDetail(firstName: "", lastName: "", instagramUsername: "", snapchatUsername: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(guestDetail.firstName!) \(guestDetail.lastName!)"
        instagramButton.setTitle("Open \(guestDetail.firstName!)'s Instagram Profile", for: UIControl.State.normal)
        snapchatButton.setTitle("Open \(guestDetail.firstName!)'s Snapchat Profile", for: UIControl.State.normal)
    }
    
    @IBAction func instagramButtonPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://www.instagram.com/\(self.guestDetail.instagramUsername!)") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @IBAction func snapchatButtonPressed(_ sender: UIButton) {
        guard let url = URL(string: "http://snapchat.com/add/\(self.guestDetail.snapchatUsername!)") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    func openURL(_ url: URL) {}
    open func open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Swift.Void)? = nil) { }
}
