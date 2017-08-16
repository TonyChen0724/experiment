/**
 Cosc345 Asn 2, DeadlinesViewController.swift
 Purpose: the Deadline UI.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit
import UserNotifications

var assignmentArr : NSMutableArray = [];

class DeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var deadLineList: UITableView!
    /* return the number of items in assignmentArr array */
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (assignmentArr.count)
    }
    /* present the records from database in DeadlineViewController */
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deadline", for: indexPath) as! DeadlinesTableCell

        cell.deadLineName.text = (assignmentArr[indexPath.row] as! AssignmentObjc).lecture;
        cell.deadLineDate.text = (assignmentArr[indexPath.row] as! AssignmentObjc).time;
        
        return (cell)
    }
    /* add delete function to deadline UI */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let target: AssignmentObjc = assignmentArr[indexPath.row] as! AssignmentObjc;
            assignmentArr.remove(at: indexPath.row)
            assignmentArr = NSMutableArray(array:Bridging.queryForAllAssignments());
            Bridging.deleteAssignment(byId: target.pkid);
        }
        deadLineList.reloadData() // FIXME
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    /* check if the view appears or not */
    override func viewDidAppear(_ animated: Bool) {
        assignmentArr = NSMutableArray(array:Bridging.queryForAllAssignments());
        deadLineList.reloadData()
    }
    /* actions after everytime the DeadlinesViewController is called */
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.appearance().tintColor = .black
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        
        })
        
    }
    /* check if the UI received any memory warning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
