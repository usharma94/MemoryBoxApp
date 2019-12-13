//
//  CustomerSupportViewController.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-12-11.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
// Tested on emulator thus calls and emails do not go through

import UIKit
import CallKit // used for making calls
import MessageUI // used for composing and sending SMS/MMS and email
class CustomerSupportViewController: UIViewController {
    
    
    @IBOutlet weak var btnCall: UIButton!
    
    @IBOutlet weak var btnEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        
        
    }
    
    
    @IBAction func btnCallClick(_ sender: UIButton) {
        print("Trying to call...")
        
        let phoneNumber : String = "1234567890"
        
        // URL format tel://1234567890
        let callString : String = "tel://\(phoneNumber)"
        
        //convert string into URL
        let url = URL(string: callString)
        
        print("URL : \(phoneNumber)")
        
        //check if any application is available to execute the created URL
        if UIApplication.shared.canOpenURL(url!){
            
            //check the version of iOS on the device on which the app is running
            if #available(iOS 10, *){
                //for all the version of iOS 10 onwards
                //if app is available open the URL
                UIApplication.shared.open(url!)
            }else{
                //for iOS version 9 and older
                UIApplication.shared.openURL(url!)
            }
        }else{
            print("Can't place call")
        }
    }
    
    @IBAction func sendEmail(){
         print("Trying to send email...")
         
         //any app that can send an email
         if MFMailComposeViewController.canSendMail(){
             let emailPicker = MFMailComposeViewController()
             
            emailPicker.mailComposeDelegate = self
             emailPicker.setSubject("Test Email")
             emailPicker.setMessageBody("Hello there!, This is a test message", isHTML: true)
             
             self.present(emailPicker, animated: true, completion: nil)
         }
         
     }
    
    func setupButtons(){
        btnCall.layer.cornerRadius = 20
        btnEmail.layer.cornerRadius = 20
    }
    
}
extension CustomerSupportViewController: MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate{
   func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //operations to perform when message composer finished with the results
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        //operations to perform when mail composer finished with the results
        controller.dismiss(animated: true, completion: nil)
    }
}
