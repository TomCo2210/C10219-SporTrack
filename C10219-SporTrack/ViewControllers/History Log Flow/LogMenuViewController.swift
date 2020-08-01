//
//  LogMenuViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit

class LogMenuViewController: UIViewController {
    //MARK: - Members
    var datesToShow = [Date]()
    var selectedIndex : IndexPath!
    
    //MARK: - View Components
    @IBOutlet weak var history_TV_list: UITableView!
    
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let i = (navigationController?.viewControllers.count)!
        let previousViewController = navigationController?.viewControllers[i-1]
        previousViewController?.navigationItem.title = K.Titles.LogScreenTitle
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        history_TV_list.delegate = self
        history_TV_list.dataSource = self
    }
    
    //MARK: - request Dataload
    func loadData() {
    FirebaseFunctions.getExerciseDays { (exerciseDays) in
        for day in exerciseDays{
            if !self.datesToShow.contains(day){
                self.datesToShow.append(day)
                self.datesToShow.sort()
                self.datesToShow.reverse()
                self.history_TV_list.reloadData()
            }
        }
    }
    FirebaseFunctions.getEnduranceDays { (enduranceDays) in
        for day in enduranceDays{
            if !self.datesToShow.contains(day){
                self.datesToShow.append(day)
                self.datesToShow.sort()
                self.datesToShow.reverse()
                self.history_TV_list.reloadData()
            }
        }
    }
}
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! LogDayViewController
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        vc.selectedDate = dateFormatter.string(from: self.datesToShow[self.selectedIndex.row])
    }
    
}

// MARK: - TableView Data
extension LogMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.history_TV_list.dequeueReusableCell(withIdentifier: K.dayEntryCell, for: indexPath) as? DayEntryTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        cell?.history_Label_day.text = "\(dateFormatter.string(from: datesToShow[indexPath.row]))"
        return cell!
    }
}

//MARK: - TableView Delegate
extension LogMenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        performSegue(withIdentifier: K.Segues.logToDateSegue, sender: self)
    }
}
