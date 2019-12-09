//
//  GuestListViewController.swift
//  GuestConnect
//
//  Created by Richard Sunden on 12/7/19.
//  Copyright © 2019 Richard Sunden. All rights reserved.
//

import UIKit

class GuestListViewController: UIViewController {

    @IBOutlet weak var guestListTableView: UITableView!
    
    var eventArray: [Event] = []
    var event = Event(eventName: "", guestList: [GuestDetail(firstName: "", lastName: "", instagramUsername: "", snapchatUsername: "")])
    var currentEventName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestListTableView.dataSource = self
        guestListTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadEventData()
        for event in eventArray {
            if event.eventName == currentEventName {
                self.event = event
            }
        }
        self.guestListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGuestSegue" {
            let destinationNavController = segue.destination as! UINavigationController
            let destination = destinationNavController.topViewController as! AddGuestViewController
            destination.currentEventName = self.currentEventName
        } else if segue.identifier == "guestDetailSegue" {
            let destination = segue.destination as! GuestDetailViewController
            let indexPath = self.guestListTableView.indexPathForSelectedRow
            if indexPath != nil {
                let index = indexPath!.row
                destination.guestDetail = event.guestList[index]
            } else {
                print("Index path is nil")
            }
            if let selectedPath = guestListTableView.indexPathForSelectedRow {
                guestListTableView.deselectRow(at: selectedPath, animated: false)
            }
        } else {
            if let selectedPath = guestListTableView.indexPathForSelectedRow {
                guestListTableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
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
    
    func saveEventData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(eventArray) {
            UserDefaults.standard.set(encoded, forKey: "eventArray")
        } else {
            print("ERROR: Saving encoded did not work")
        }
    }
}

extension GuestListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if event.guestList.count > 0 {
            return event.guestList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = guestListTableView.dequeueReusableCell(withIdentifier: "GuestCell", for: indexPath)
        cell.textLabel?.text = "\(event.guestList[indexPath.row].firstName!) \(event.guestList[indexPath.row].lastName!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            event.guestList.remove(at: indexPath.row)
            guestListTableView.deleteRows(at: [indexPath], with: .fade)
            saveEventData()
        }
    }
}
