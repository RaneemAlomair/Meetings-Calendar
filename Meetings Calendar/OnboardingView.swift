//
//  OnboardingView.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 01/03/1447 AH.
//

import SwiftUI

// MARK: - Root (switch between Onboarding and App)
struct RootView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        if hasSeenOnboarding {
            MeetingView()
        } else {
            OnboardingView()
        }
    }
}

// MARK: - Model
struct OnboardingPage: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

// MARK: - Onboarding
struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var index = 0
    
    private let pages: [OnboardingPage] = [
        .init(imageName: "onb_calendar",
              title: "All your meetings in one place",
              subtitle: "Pick a date from the calendar and see all meetings instantly."),
        .init(imageName: "onb_grid",
              title: "Add & Edit with ease",
              subtitle: "Create a new meeting or update existing ones with just a tap."),
        .init(imageName: "onb_hourglass",
              title: "Right-time reminders",
              subtitle: "Get notified exactly when your meeting starts.")
    ]
    
    var body: some View {
        VStack {
    
            HStack {
                Button("Skip") { hasSeenOnboarding = true }
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            
            // Pages
            TabView(selection: $index) {
                ForEach(Array(pages.enumerated()), id: \.offset) { i, page in
                    OnboardingCard(page: page)
                        .tag(i)
                        .padding(.horizontal, 24)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            
            HStack(spacing: 8) {
                ForEach(pages.indices, id: \.self) { i in
                    Circle()
                        .fill(i == index ? Color.pink : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 8)
            
            
            Button(action: nextOrFinish) {
                Text(index == pages.count - 1 ? "Get Started" : "Next")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
            }
            .padding(.bottom, 24)
        }
    }
    
    private func nextOrFinish() {
        if index < pages.count - 1 {
            withAnimation { index += 1 }
        } else {
            hasSeenOnboarding = true
        }
    }
}

// MARK: - Card
struct OnboardingCard: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 18) {
            Spacer(minLength: 20)
            
            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 260)
                .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
            
            Text(page.title)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 4)
            
            Text(page.subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            
            Spacer(minLength: 10)
        }
    }
}



#Preview {
    OnboardingView()
}
