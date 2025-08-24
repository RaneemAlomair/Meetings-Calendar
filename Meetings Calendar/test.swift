//
//
//
//
//import SwiftUI
//
//struct CalendarDayView: View {
//    @StateObject private var vm = MeetingDayViewModel()
//
//    @State private var showAdd = false
//    @State private var editing: MeetingEntity? = nil
//    @State private var showEdit = false
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                DatePicker("",
//                           selection: $vm.selectedDate,
//                           displayedComponents: .date)
//                    .datePickerStyle(.graphical)
//                    .tint(.pink)
//                    .onChange(of: vm.selectedDate) { _ in vm.loadForSelectedDay() }
//
//                if vm.meetings.isEmpty {
//                    ContentUnavailableView("No meetings for this day",
//                                           systemImage: "calendar.badge.exclamationmark",
//                                           description: Text("Tap + to add a meeting"))
//                        .padding(.top, 8)
//                } else {
//                    List {
//                        ForEach(vm.meetings) { m in
//                            Button {
//                                editing = m
//                                showEdit = true
//                            } label: {
//                                HStack {
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(m.title ?? "Untitled")
//                                            .font(.headline)
//                                        HStack(spacing: 8) {
//                                            if let start = m.startDate {
//                                                Text(start, style: .time)
//                                            }
//                                            if let end = m.endDate {
//                                                Text("– \(end.formatted(date: .omitted, time: .shortened))")
//                                            }
//                                        }.foregroundStyle(.secondary)
//                                        if let notes = m.notes, !notes.isEmpty {
//                                            Text(notes).font(.caption).foregroundStyle(.secondary)
//                                        }
//                                    }
//                                    Spacer()
//                                    Image(systemName: "calendar").foregroundStyle(.pink)
//                                }
//                            }
//                        }
//                        .onDelete(perform: vm.delete)
//                    }
//                    .listStyle(.plain)
//                }
//            }
//            .padding(.horizontal)
//            .navigationTitle("My Calendar")
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button { showAdd = true } label: { Image(systemName: "plus") }
//                }
//            }
//            .sheet(isPresented: $showAdd) {
//                AddMeetingSheet(selectedDay: vm.selectedDate) { title, notes, start, end in
//                    vm.add(title: title, notes: notes, start: start, end: end)
//                }
//            }
//            .sheet(isPresented: $showEdit) {
//                if let editing {
//                    EditMeetingSheet(meeting: editing) { title, notes, start, end in
//                        vm.update(editing, title: title, notes: notes, start: start, end: end)
//                    }
//                }
//            }
//            .onAppear { vm.loadForSelectedDay() }
//        }
//    }
//}
//
//// شيت الإضافة (Title, Notes, Start, End فقط)
//struct AddMeetingSheet: View {
//    let selectedDay: Date
//    var onSave: (String, String?, Date, Date) -> Void
//    @Environment(\.dismiss) private var dismiss
//
//    @State private var title = ""
//    @State private var notes = ""
//    @State private var start: Date
//    @State private var end: Date
//
//    init(selectedDay: Date, onSave: @escaping (String, String?, Date, Date) -> Void) {
//        self.selectedDay = selectedDay
//        self.onSave = onSave
//        let cal = Calendar.current
//        let base = cal.date(bySettingHour: cal.component(.hour, from: Date()) + 1,
//                            minute: 0, second: 0, of: selectedDay) ?? selectedDay
//        _start = State(initialValue: base)
//        _end   = State(initialValue: cal.date(byAdding: .minute, value: 60, to: base) ?? base)
//    }
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    TextField("Title", text: $title)
//                    TextField("Notes", text: $notes)
//                }
//                Section("Time") {
//                    DatePicker("Start", selection: $start)
//                    DatePicker("End", selection: $end)
//                }
//            }
//            .navigationTitle("Add Meeting")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
//                        guard end >= start else { return }
//                        onSave(title, notes.isEmpty ? nil : notes, start, end)
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
//
//// شيت التعديل
//struct EditMeetingSheet: View {
//    let meeting: MeetingEntity
//    var onSave: (String, String?, Date, Date) -> Void
//    @Environment(\.dismiss) private var dismiss
//
//    @State private var title: String
//    @State private var notes: String
//    @State private var start: Date
//    @State private var end: Date
//
//    init(meeting: MeetingEntity, onSave: @escaping (String, String?, Date, Date) -> Void) {
//        self.meeting = meeting
//        self.onSave = onSave
//        _title = State(initialValue: meeting.title ?? "")
//        _notes = State(initialValue: meeting.notes ?? "")
//        _start = State(initialValue: meeting.startDate ?? Date())
//        _end   = State(initialValue: meeting.endDate ?? Date().addingTimeInterval(3600))
//    }
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    TextField("Title", text: $title)
//                    TextField("Notes", text: $notes)
//                }
//                Section("Time") {
//                    DatePicker("Start", selection: $start)
//                    DatePicker("End", selection: $end)
//                }
//            }
//            .navigationTitle("Edit Meeting")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) { Button("Close") { dismiss() } }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
//                        guard end >= start else { return }
//                        onSave(title, notes.isEmpty ? nil : notes, start, end)
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//}
//
