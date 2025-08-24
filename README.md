# 📅 Meetings Calendar (SwiftUI + Core Data)

A simple SwiftUI app to manage daily meetings with **Core Data** persistence, **local notifications**, and a clean **MVVM + Repository** architecture. Includes a **Splash Screen** and **Onboarding**.

---

## ✨ Features
- Calendar day view — pick a date and see only that day’s meetings  
- Add / Edit / Delete meetings  
- Local notifications at meeting start time  
- Splash screen (logo + tagline)  
- Onboarding (one-time) using `@AppStorage("hasSeenOnboarding")`  
- MVVM + Repository architecture

---

## 🧱 Architecture
```
Views → ViewModels → Repository (Core Data)
└─ NotificationService (local notifications)
```
---

## 🗂 Data Model
**Entity:** `MeetingEntity`

| Attribute   | Type   | Optional | Notes         |
|-------------|--------|----------|---------------|
| id          | UUID   | No       | unique ID     |
| title       | String | No       | meeting title |
| notes       | String | Yes      | optional      |
| startDate   | Date   | No       | start time    |
| endDate     | Date   | No       | end time      |

---

## 📦 Project Structure
```
MeetingsCalendar/
├── App/
│ ├── MeetingsCalendarApp.swift
│ └── RootView.swift
├── Features/
│ ├── Calendar/
│ │ ├── MeetingView.swift
│ │ └── MeetingSheet.swift
│ └── Onboarding/
│ ├── OnboardingView.swift
│ └── OnboardingCard.swift
├── Data/
│ ├── MeetingRepository.swift
│ └── MeetingsContainer.xcdatamodeld
├── ViewModels/
│ └── MeetingViewModel.swift
├── Services/
│ └── NotificationService.swift
└── UI/
└── SplashScreenView.swift
```

---

## 🚀 App Flow
```
SplashScreen → RootView
↳ OnboardingView (first launch only)
↳ MeetingView (calendar + list + sheets)
```

---

## 🖼 Screenshots
<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-24 at 15 17 04" src="https://github.com/user-attachments/assets/8be12479-3fdc-4c67-8093-404af2b03d29" />

<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-24 at 15 17 12" src="https://github.com/user-attachments/assets/24122825-489f-4ff9-a6fc-099472cb0a92" />

<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-24 at 15 17 15" src="https://github.com/user-attachments/assets/725d39d1-1d40-49d6-93b4-0668b378badf" />

<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-24 at 15 19 57" src="https://github.com/user-attachments/assets/8fad4abd-936a-4948-bd96-fa4f02eac783" />

<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-24 at 15 17 19" src="https://github.com/user-attachments/assets/e3e2eaf7-6c04-4f54-a011-5fb2db57722d" />

<img width="300" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-24 at 15 21 01" src="https://github.com/user-attachments/assets/987c49b1-b20d-482a-b6fb-94234bec11d4" />

---

## 🧭 Onboarding (English copy)
- Page 1: **All your meetings in one place**  
  *Pick a date from the calendar and see all meetings instantly.*
- Page 2: **Add & Edit with ease**  
  *Create a new meeting or update existing ones with just a tap.*
- Page 3: **Right-time reminders**  
  *Get notified exactly when your meeting starts.*

Buttons: **Skip**, **Next**, **Get Started**

---

## 🧪 Usage
- Pick a date → see meetings for that day  
- Tap **+** → Add meeting  
- Tap a meeting → Edit or Delete  
- Swipe left on a row → Delete

---

## 🗺 Roadmap
- [ ] Remind me X minutes before  
- [ ] Search & filters  
- [ ] Recurring meetings  
- [ ] iCloud sync  
- [ ] Accessibility improvements

---
