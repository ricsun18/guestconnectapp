//
//  ViewController.swift
//  GuestConnect
//
//  Created by Richard Sunden on 12/7/19.
//  Copyright © 2019 Richard Sunden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eventTableView: UITableView!
    
    var eventArray: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.dataSource = self
        eventTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadEventData()
        self.eventTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventSegue" { // then tableView cell was clicked
            let destination = segue.destination as! GuestListViewController
            let index = eventTableView.indexPathForSelectedRow!.row
            destination.currentEventName = eventArray[index].eventName
        } else {
            if let selectedPath = eventTableView.indexPathForSelectedRow {
                eventTableView.deselectRow(at: selectedPath, animated: false)
            }
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
    
    func saveEventData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(eventArray) {
            UserDefaults.standard.set(encoded, forKey: "eventArray")
        } else {
            print("ERROR: Saving encoded did not work")
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if eventArray.count > 0 {
            return eventArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = eventArray[indexPath.row].eventName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eventArray.remove(at: indexPath.row)
            eventTableView.deleteRows(at: [indexPath], with: .fade)
            saveEventData()
        }
    }
}
