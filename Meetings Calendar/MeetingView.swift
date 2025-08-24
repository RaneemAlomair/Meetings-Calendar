//
//  MeetingView.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 25/02/1447 AH.
//

import SwiftUI

struct MeetingView: View {
    var backgroundColor = Color.background
    @StateObject var vm = MeetingViewModel()
    
    @State private var showAdd = false
    @State private var editing: MeetingEntity? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 16) {
                    DatePicker("",
                        selection: $vm.selectedDate,
                        displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(.pink)
                        .onChange(of: vm.selectedDate) { _ in
                            vm.loadMeetings()
                        }

                    if vm.meetings.isEmpty {
                        ContentUnavailableView("No meetings for this day",
                            systemImage: "calendar.badge.exclamationmark",
                            description: Text("Tap + to add a meeting"))
                            .padding(.top, 8)
                    } else {
                        List {
                            ForEach(vm.meetings) { m in
                                Button {
                                    editing = m
                                } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(m.title ?? "Untitled")
                                            .font(.headline)
                                        HStack(spacing: 8) {
                                            if let start = m.startDate {
                                                Text(start, style: .time)
                                            }
                                            if let end = m.endDate {
                                                Text("– \(end.formatted(date: .omitted, time: .shortened))")
                                            }
                                        }
                                        .foregroundStyle(.secondary)
                                        if let notes = m.notes, !notes.isEmpty {
                                            Text(notes)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundStyle(.pink)
                                }
                            }
                        }
                        .onDelete { offsets in
                                offsets.map { vm.meetings[$0] }.forEach { vm.deleteMeeting($0) }
                            }
                    }
                    .listStyle(.plain)
                    .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("My Calendar")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAdd = true }
                        label: {
                            Image(systemName: "plus")
                                .foregroundColor(.pink)
                        }
                    }
                }
                .sheet(isPresented: $showAdd) {
                    MeetingSheet(vm: vm, meetingToEdit: nil)
                }
                
                .sheet(item: $editing) { meeting in
                    MeetingSheet(vm: vm, meetingToEdit: meeting)
                }
            }
        }
    }
}

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


#Preview {
    MeetingView()
}

