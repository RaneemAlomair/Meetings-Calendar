//
//  MeetingRepository.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 25/02/1447 AH.
//

import SwiftUI
import CoreData

class MeetingRepository: ObservableObject {
    static let shared = MeetingRepository()
    let container: NSPersistentContainer
    @Published var savedEntities: [MeetingEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Meeting")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func fetchMeetings(on day: Date) -> [MeetingEntity] {
        let cal = Calendar.current
        let start = cal.startOfDay(for: day)
        let end   = cal.date(byAdding: .day, value: 1, to: start)!

        let req: NSFetchRequest<MeetingEntity> = MeetingEntity.fetchRequest()
        req.predicate = NSPredicate(
            format: "%K >= %@ AND %K < %@",
            #keyPath(MeetingEntity.startDate), start as NSDate,
            #keyPath(MeetingEntity.startDate), end as NSDate
        )
        req.sortDescriptors = [NSSortDescriptor(key: #keyPath(MeetingEntity.startDate), ascending: true)]

        do { return try context.fetch(req) }
        catch { print("fetch(on:):", error); return [] }
    }
    
    
    @discardableResult
    func addMeeting(title: String, notes: String?, startDate: Date, endDate: Date) -> MeetingEntity {
        let newMeeting = MeetingEntity(context: context)
        newMeeting.id = UUID()
        newMeeting.title = title
        newMeeting.notes = notes
        newMeeting.startDate = startDate
        newMeeting.endDate = endDate
        save()
        return newMeeting
    }
    
    func updateMeeting(_ meeting: MeetingEntity, title: String, notes: String?, startDate: Date, endDate: Date) {
        meeting.title = title
        meeting.notes = notes
        meeting.startDate = startDate
        meeting.endDate = endDate
        save()
    }

    
    func deleteMeeting(_ meeting: MeetingEntity) {
        context.delete(meeting)
        save()
    }
    
    func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    
}
