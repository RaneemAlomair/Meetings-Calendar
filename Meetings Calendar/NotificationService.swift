//
//  NotificationService.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 27/02/1447 AH.
//

import SwiftUI
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            granted, err in
            if let err = err {
            print("Notification auth error:", err) }
            print("Notifications granted?", granted)
        }
    }
    
    func schedule(meetingId: UUID, title: String, fireDate: Date) {
        // لا نحدد إشعار للماضي
        guard fireDate > Date() else { return }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body  = DateFormatter.localizedString(from: fireDate, dateStyle: .none, timeStyle: .short)
        content.sound = .default

        // نكوّن التاريخ كـ DateComponents (محلي)
        let comps = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)

        let request = UNNotificationRequest(identifier: meetingId.uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request) { err in
            if let err = err { print("schedule error:", err) }
        }
    }
    
    
    func cancel(meetingId: UUID) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [meetingId.uuidString])
    }
    
    
}
