//
//  AddEventViewController.swift
//  GuestConnect
//
//  Created by Richard Sunden on 12/7/19.
//  Copyright © 2019 Richard Sunden. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventNameTextField: UITextField!
    
    var eventArray: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEventData()
        eventNameTextField.text = ""
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if eventNameTextField.text == "" {
            showAlert(title: "Wait!", message: "Must make an Event Name to create an event!")
        } else {
            eventArray.append(Event(eventName: "\(eventNameTextField.text!)", guestList: [GuestDetail(firstName: "", lastName: "", instagramUsername: "", snapchatUsername: "")]))
            saveEventData()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveEventData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(eventArray) {
            UserDefaults.standard.set(encoded, forKey: "eventArray")
        } else {
            print("ERROR: Saving encoded did not work")
        }
    }
    
    func loadEventData() {
        guard let EventDataEncoded = UserDefaults.standard.value(forKey: "eventArray") as? Data else {
            print("Could not load eventData from UserDefaults")
            return
        }
        let decoder = JSONDecoder()
        if let eventArray = try? decoder.decode([Event].self, from: EventDataEncoded) as [Event] {
            self.eventArray = eventArray
        } else {
            print("ERROR: Could not decode data read from UserDefaults")
        }
    }
}
