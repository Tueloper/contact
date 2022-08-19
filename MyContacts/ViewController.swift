//
//  ContentView.swift
//  Contacts
//
//  Created by Tueloper on 16/08/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnEdit(_ sender: UIButton) {
        fullname.isEnabled = true
        email.isEnabled = true
        phone.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        fullname.becomeFirstResponder()
    }
    
    
    @IBAction func btnSave(_ sender: AnyObject) {
        
        if (contactdb != nil)
        {
            
            contactdb.setValue(fullname.text, forKey: "fullname")
            contactdb.setValue(email.text, forKey: "email")
            contactdb.setValue(phone.text, forKey: "phone")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Contact",in: managedObjectContext)
            let contact = Contact(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            contact.fullname = fullname.text!
            contact.email = email.text!
            contact.phone = phone.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if error != nil {
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
    }
//    != nil
    @IBAction func btnBack(_ sender: AnyObject) {
       self.dismiss(animated: true, completion: nil)
    }
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contactdb:NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (contactdb != nil)
        {
            fullname.text = contactdb.value(forKey: "fullname") as? String
            email.text = contactdb.value(forKey: "email") as? String
            phone.text = contactdb.value(forKey: "phone") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            fullname.isEnabled = false
            email.isEnabled = false
            phone.isEnabled = false
            btnSave.isHidden = true
        }else{
          
            btnEdit.isHidden = true
            fullname.isEnabled = true
            email.isEnabled = true
            phone.isEnabled = true
        }
        fullname.becomeFirstResponder()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil {
            DismissKeyboard()
        }
    }

    @objc func DismissKeyboard(){
        fullname.endEditing(true)
        email.endEditing(true)
        phone.endEditing(true)
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }

}
