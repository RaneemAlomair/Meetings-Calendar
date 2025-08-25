//
//  MeetingView.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 02/03/1447 AH.
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

#Preview {
    MeetingView()
}
