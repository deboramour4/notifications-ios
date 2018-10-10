//
//  ViewController.swift
//  NotificationStudies
//
//  Created by Débora Oliveira on 08/10/18.
//  Copyright © 2018 Débora Oliveira. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func createNotificationCategories() {
        let replyAction = UNNotificationAction(identifier: "reply", title: "Reply now", options: [])
        let heartEyesAction = UNNotificationAction(identifier: "heartEyes", title: "😍", options: [])
        let seeMessageAction = UNNotificationAction(identifier: "seeMessage", title: "See message", options: [])
        
        let responseCategory = UNNotificationCategory(identifier: "responseCategory", actions: [replyAction, heartEyesAction, seeMessageAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([responseCategory])
    }
    
    func simpleNotification() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "A simple notification."
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ipsum urna, hendrerit a augue sed, consectetur sodales nulla. Maecenas sed nisl quis magna facilisis dictum. Nunc sollicitudin commodo venenatis. Morbi a tincidunt odio."
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func attachmentNotification() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else { return }
        guard let attachment = try? UNNotificationAttachment(identifier: "VideoNotification", url: URL(fileURLWithPath: path), options: nil) else { return }
        
        
        let content = UNMutableNotificationContent()
        content.title = "A cool countdown video."
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ipsum urna, hendrerit a augue sed, consectetur sodales nulla."
        content.sound = UNNotificationSound.default
        content.attachments = [attachment]
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func actionsNotification() {
        createNotificationCategories()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "A notification with actions."
        content.body = "Lorem ipsum."
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "responseCategory"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func simpleAction(_ sender: Any) {
        simpleNotification()
        print("Simple notification scheduled.")
    }
    
    @IBAction func attachmentAction(_ sender: Any) {
        attachmentNotification()
        print("Attachment notification scheduled.")
    }
    
    @IBAction func actionsAction(_ sender: Any) {
        actionsNotification()
        print("Actions notification scheduled.")
    }
    
    @IBAction func richAction(_ sender: Any) {
    }
    
}

extension ViewController : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        
        //let request = response.notification.request
        
        if identifier == "reply" {
            print("Reply action called.")
        } else if identifier == "heartEyes"  {
            print("😍 action called.")
        } else if identifier == "seeMessage" {
            print("See message action called.")
        }
        
        completionHandler()
    }
}
