//
//  RootView.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 02/03/1447 AH.
//

import SwiftUI

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
