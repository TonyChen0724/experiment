/**
 Cosc345 Asn 2, AddDeadLineController.swift
 Purpose: the UI when users add deadline record.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit
import UserNotifications

class AddDeadLineController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var deadlineTime: UITextField!
    let datePicker = UIDatePicker()
    var indexer = 0;
    /* when user add a deadline record to the list, we store it in the database */
    var triggers = [UNTimeIntervalNotificationTrigger]()
    var requests = [UNNotificationRequest]()
    @IBAction func addDeadLine(_ sender: Any)
    {
        if (input.text != "" && deadlineTime.text != "")
        {
            let ass: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: input.text!, time: deadlineTime.text!, position: "");
            let timer = deadlineTime.text!;
            let name = input.text!;
            print(timer)
            print(name)
            var timerArr = timer.components(separatedBy: "/")
            let day = timerArr[1]
            let substitution = Int(day)! - 21;
            let remainder = substitution % 7
            let restInfo = timerArr[2]
            var restArr = restInfo.components(separatedBy: ", ")
            let specificTime = restArr[1]
            var stimeArr = specificTime.components(separatedBy: ":")
            let morespacificTime = stimeArr[1]
            var spacesplit = morespacificTime.components(separatedBy: " ")
            var clock = Int(stimeArr[0])!
            var minute = Int(spacesplit[0])! // minute is wrong.
            var stimeArrArr = stimeArr[1].components(separatedBy: " ")
            let afterevening = stimeArrArr[1]
            
            let month = timerArr[0]
            let year = restArr[0]
            
            let total = "20" + year + "-" + month + "-" + day;
            let week = getDayOfWeek(today: total)
            
            
            
            print(afterevening)
            if (afterevening == "PM" && clock != 12) {
                clock = clock + 12
            }
            if (remainder == 0 || remainder == 6) {
                
            } else {
                print((remainder-1) * 5 + (clock-8))
                items.insert(input.text!, at: (week-2) + (clock-8) * 5);
                items[(week-2) + (clock-8) * 5] = input.text!
                // DELETED FOR DEBUGGING!!!!!!!!
            }
                
           // items.insert(input.text!, at: deadlineTime.text!(days) * 5 + (clock - 8)) // there is something wrong here, so what i should do is go back to old commit and change the previous statement based on this version.
            input.text = ""
            deadlineTime.text = ""
            Bridging.insertNewAssignmentObjc(ass);
            let content = UNMutableNotificationContent()
            content.title = "There is an assignment named " + name + " is due at " + timer;
            print(String(input.text!))
            content.subtitle = "check this out"
            content.body = "click to go back to the app"
            content.badge = 1
            
            
            let date = Date()
            let calendar = Calendar.current
            let currenthour = calendar.component(.hour, from: date)
            let currentminute = calendar.component(.minute, from: date)
            let currentday = calendar.component(.day, from: date)
            let currentmonth = calendar.component(.month, from: date)
            var intervalint = 0;
            
          if (Int(month)! == currentmonth) {
                intervalint = Int(day)! * 86400 + clock * 3600 + minute * 60 - currentday * 86400 - currenthour * 3600 - currentminute * 60
            
           }
            
            let interval = Double(intervalint);
            
            
            triggers.append(UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false))
            
            
            var identifier = String(indexer);
            print(indexer);
            requests.append(UNNotificationRequest(identifier: identifier, content: content, trigger: triggers[indexer]))
            //var centers = [UNUserNotificationCenter]();
            UNUserNotificationCenter.current().add(requests[indexer], withCompletionHandler: nil)
            indexer = indexer + 1
        }
    }
    /* get day (in a week) from the time input in a form(yyyy-MM-dd) */
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    
    
    /* a object which enables user to select a time rather than inputing one */
    func createDatePicker()
    {
        //format picker
        datePicker.datePickerMode = .dateAndTime
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated:false)
        
        deadlineTime.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        deadlineTime.inputView = datePicker
    }
    /* when user finished select and hit the done button. */
    func donePressed() {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        deadlineTime.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    /* action happens after everytime the AddDeadLineController shows */
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        UITextField.appearance().tintColor = .black 
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    /* check if it receives any memory warning. */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
