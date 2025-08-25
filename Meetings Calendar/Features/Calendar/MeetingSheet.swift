//
//  MeetingSheet.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 02/03/1447 AH.
//
import SwiftUI
// MARK: - SHEET
struct MeetingSheet: View {
    @ObservedObject var vm: MeetingViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var meetingToEdit: MeetingEntity?
    
    @State private var title = ""
    @State private var notes = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Notes (optional)", text: $notes)
                
                Section("Time") {
                    DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("End", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                }
                if meetingToEdit != nil {
                    Button("Delete", role: .destructive) {
                        if let meeting = meetingToEdit {
                            vm.deleteMeeting(meeting)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle(meetingToEdit == nil ? "Add Meeting" : "Edit Meeting")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { presentationMode.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let meeting = meetingToEdit {
                            vm.updateMeeting(meeting, title: title, notes: notes, start: startDate, end: endDate) // تعديل
                        } else {
                            vm.addMeeting(title: title, notes: notes, start: startDate, end: endDate) // إضافة
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                if let m = meetingToEdit { // لو تعديل نعبي القيم
                    title = m.title ?? ""
                    notes = m.notes ?? ""
                    startDate = m.startDate ?? Date()
                    endDate = m.endDate ?? Date()
                }
            }
        }
        .accentColor(.pink)
    }
}
