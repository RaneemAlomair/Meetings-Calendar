//
//  MeetingViewModel.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 25/02/1447 AH.
//

import SwiftUI

class MeetingViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var meetings: [MeetingEntity] = []
    
    private let repo = MeetingRepository.shared
    private let notifier = NotificationService.shared
        
        init() {
            notifier.requestAuthorization()
            loadMeetings()
        }
        
        func loadMeetings() {
            meetings = repo.fetchMeetings(on: selectedDate)
        }
        
        func addMeeting(title: String, notes: String?, start: Date, end: Date) {
            let new = repo.addMeeting(title: title, notes: notes, startDate: start, endDate: end)
            if let id = new.id { notifier.schedule(meetingId: id, title: title, fireDate: start) }
            loadMeetings()
        }
    
        func updateMeeting(_ meeting: MeetingEntity, title: String, notes: String?, start: Date, end: Date) {
            if let id = meeting.id { notifier.cancel(meetingId: id) }          // ألغِ الإشعار القديم
            repo.updateMeeting(meeting,                                       // مرري الكيان أولاً
                           title: title,
                           notes: notes,
                           startDate: start,
                           endDate: end)
            if let id = meeting.id { notifier.schedule(meetingId: id, title: title, fireDate: start) }
            loadMeetings()
        }
    
        func deleteMeeting(_ meeting: MeetingEntity) {
            if let id = meeting.id { notifier.cancel(meetingId: id) }
            repo.deleteMeeting(meeting)
            loadMeetings()
        }
    
}


