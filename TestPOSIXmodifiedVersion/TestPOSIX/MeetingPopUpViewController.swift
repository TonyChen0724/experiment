/**
 Cosc345 Asn 2, MeetingPopUpViewController.swift
 Purpose: After user hits Add button this UI will show.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit

class MeetingPopUpViewController: UIViewController {
    

    @IBOutlet weak var group: UILabel!
  
    @IBOutlet weak var timeAndDate: UITextField!
    
    @IBOutlet weak var groupText: UITextField!
    
    @IBOutlet weak var locationText: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let datePicker = UIDatePicker()
/*
    action after user hits the submit.
*/
    @IBAction func submit(_ sender: Any) {
        //print("time =" + timeAndDate.text!)
        let ass: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: groupText.text!, time: timeAndDate.text!, position: "");
        let timer = timeAndDate.text!;
        var timerArr = timer.components(separatedBy: "/")
        let day = timerArr[1]
        let substitution = Int(day)! - 21;
        let remainder = substitution % 7
        let restInfo = timerArr[2]
        var restArr = restInfo.components(separatedBy: ", ")
        let specificTime = restArr[1]
        var stimeArr = specificTime.components(separatedBy: ":")
        var clock = Int(stimeArr[0])!
        var stimeArrArr = stimeArr[1].components(separatedBy: " ")
        let afterevening = stimeArrArr[1]
        
        let month = timerArr[0]
        let year = restArr[0]
        
        let total = "20" + year + "-" + month + "-" + day;
        let week = getDayOfWeek(today: total)
        if (afterevening == "PM" && clock != 12) {
            clock = clock + 12
        }
        if (groupText.text != "" && timeAndDate.text != "" && locationText.text != "")
        {
            meetings.append(groupText.text!)
            meetingTimes.append(timeAndDate.text!)
            meetingLoc.append(locationText.text!)
            
            groupText.text = ""
            timeAndDate.text = ""
            Bridging.insertMeetingsObjc(ass);
            
            items[(week-2) + (clock-8) * 5] = "Meeting: " + groupText.text! + "\n" + timeAndDate.text! +
                "\n" + locationText.text!
            // DELETE FOR DEBUGGING
            
        }
        
        
        self.view.removeFromSuperview()
        self.removeAnimate()
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    
    /*
     a small object which enable users to pick a date instead of inputing one.
     */
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
        
        timeAndDate.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        timeAndDate.inputView = datePicker
    }
    /*
     actions after the user pressed done
     */
    
    func donePressed() {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        //
        timeAndDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    
/*
    close the MeetingPopUI.
*/
    @IBAction func close(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeAnimate()
    }
/*
    everytime the UI showed.
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.appearance().tintColor = .black 
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        createDatePicker()
        // Do any additional setup after loading the view.
    }
/*
    check if it received memory warning.
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    show the animation.
    reference: github.com/awseeley/Swift-Pop-Up-View-Tutorial/blob/master/PopUp/PopUpViewController.swift.
*/
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
/*
    animation when remove something.
*/
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

}
/*
    part of methods to solve tab bar disappearing problems.
 */
extension Notification.Name {
    static let reload = Notification.Name("reload")
}
