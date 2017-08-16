/**
 Cosc345 Asn 2, TimeTablePopUpViewController.swift
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit

class TimeTablePopUpViewController: UIViewController {
    
    @IBOutlet weak var addToTimeTable: UIView!
    
    @IBOutlet weak var classLabel: UILabel!

    @IBOutlet weak var classText: UITextField!
  
    @IBOutlet weak var startTime: UITextField!
    
    @IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var finishTime: UITextField!
    
    @IBOutlet weak var locationLable: UILabel!
    
    @IBOutlet weak var locationText: UITextField!
    
    var monday: BooleanLiteralType! = false
    var tuesday: BooleanLiteralType! = false
    var wednesday: BooleanLiteralType! = false
    var thursday : BooleanLiteralType! = false
    var friday : BooleanLiteralType! = false
    
    let datePicker = UIDatePicker()
    
    var column: Int!
    var row: Int!
    
    /* checkboxes for user to check a day */
    @IBAction func daycheckbox(_ sender: UIButton) {
        // Instead of specifying each button we are just using the sender (button that invoked) the method
        if (sender.isSelected == true)
        {
            print(sender.titleLabel!.text!)
            if (sender.titleLabel!.text! == "Monday"){
                monday = false
            }else if (sender.titleLabel!.text == "Tuesday"){
                tuesday = false
            } else if (sender.titleLabel!.text! == "Wednesday"){
                wednesday = false
                
            }else if (sender.titleLabel!.text! == "Thursday"){
                thursday = false
                
            }else if (sender.titleLabel!.text! == "Friday"){
                friday = false
            }
          
            sender.setBackgroundImage(UIImage(named: "uncheckedBox.png"), for: UIControlState.normal)
            sender.isSelected = false;
            //need to remove if already selected day
        }
        else
        {
            if (sender.titleLabel!.text! == "Monday"){
                monday = true
            }else if (sender.titleLabel!.text == "Tuesday"){
                tuesday = true
                
            } else if (sender.titleLabel!.text! == "Wednesday"){
                wednesday = true
               
                
            }else if (sender.titleLabel!.text! == "Thursday"){
                thursday = true
                
                
            }else if (sender.titleLabel!.text! == "Friday"){
                friday = true
               
            }
            sender.setBackgroundImage(UIImage(named: "checkbox.png"), for: UIControlState.normal)
            sender.isSelected = true;
            schedule.append(" " + sender.titleLabel!.text!)
        }
    }
    /* when user closes the Pop up UI.*/
    @IBAction func close(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeAnimate()
    }
    /* if user wants to insert a record into a block that already have the record, the overide warning will show. */
    func alertMessage (title: String, alert: String, location: Int, content: String){
        let alert = UIAlertController(title: title, message: alert, preferredStyle: UIAlertControllerStyle.alert)
        //override
       let override = UIAlertAction(title: "Over ride", style: .default) {
            (action) in
             items[location] = content
        
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {
           (alert) in
        }
        alert.addAction(override)
       alert.addAction(cancel)
       present(alert,animated: true, completion: nil)
    
    }
    /* when user hits submit */
    @IBAction func submit(_ sender: Any) {
        

        if (classText.text != "" && locationText.text != "" && startTime.text != "")
     {
        
   
        schedule.append(classText.text! + "\n" + locationText.text! + "\n" + startTime.text!)
        print(startTime.text!);
        
        
        let ttime = startTime.text
        var ttimeArr = ttime!.components(separatedBy: ":")
        let clock = ttimeArr[0]
        var row = Int(clock)! - 8
        let rest = ttimeArr[1]
        var restArr = rest.components(separatedBy: " ")
        let afterevening = restArr[1]
        
        if (afterevening == "PM" && Int(clock) != 12) {
            row = row + 12
        }
        
        if (monday == true){
            column = 0
            if(items[column+row*5] != ""){
            alertMessage(title: "Override Error", alert: "There is already an event at this time", location: column+row*5, content: classText.text! + "\n" + locationText.text! + "\n" + startTime.text!)
            }else{
            
            items[column+row*5] = classText.text! + "\n" + locationText.text! + "\n" + startTime.text!
        }
        }
        if (tuesday == true){
            column = 1
            if(items[column+row*5] != ""){
                alertMessage(title: "Override Error", alert: "There is already an event at this time", location: column+row*5, content: classText.text! + "\n" + locationText.text! + "\n" + startTime.text!)
            }
                 items[column+row*5] = classText.text! + "\n" + locationText.text! + "\n" + startTime.text!
        }
        if (wednesday == true){
            column = 2
            if(items[column+row*5] != ""){
                alertMessage(title: "Override Error", alert: "There is already an event at this time", location: column+row*5, content: classText.text! + "\n" + locationText.text! + "\n" + startTime.text!)
                 items[column+row*5] = classText.text! + "\n" + locationText.text! + "\n" + startTime.text!
            }
        }
        if (thursday == true){
            column = 3
            if(items[column+row*5] != ""){
                alertMessage(title: "Override Error", alert: "There is already an event at this time", location: column+row*5, content: classText.text! + "\n" + locationText.text! + "\n" + startTime.text!)
                 items[column+row*5] = classText.text! + "\n" + locationText.text! + "\n" + startTime.text!
            }
        }
        if (friday == true){
            column = 4
            if(items[column+row*5] != ""){
                alertMessage(title: "Override Error", alert: "There is already an event at this time", location: column+row*5, content: classText.text! + "\n" + locationText.text! + "\n" + startTime.text!)
            }
                 items[column+row*5] = classText.text! + "\n" + locationText.text! + "\n" + startTime.text!
        }
        
   
        }
        self.view.removeFromSuperview()
        self.removeAnimate()
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    /* a object which enables user to select a date rather than inputing it */
    func createDatePicker()
    {
        //format picker
        datePicker.datePickerMode = .time
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated:false)
        
        startTime.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        startTime.inputView = datePicker
    }
    /* when user finished selecting a date then they press done to put the date to the text field */
    func donePressed() {
        //format date
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
        
        startTime.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    /* everytime the TimeTablePopUpViewController is called */
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.appearance().tintColor = .black
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        createDatePicker()

        // Do any additional setup after loading the view.
    }
    /* check if it received any warnings */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* a function to specify the animation process
       reference:github.com/awseeley/Swift-Pop-Up-View-Tutorial/blob/master/PopUp/PopUpViewController.swift
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
    /* a function to remove Animation */
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
