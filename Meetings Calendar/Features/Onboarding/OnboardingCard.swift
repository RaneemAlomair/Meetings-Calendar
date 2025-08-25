//
//  OnboardingCard.swift
//  Meetings Calendar
//
//  Created by Raneem Alomair on 02/03/1447 AH.
//

import SwiftUI

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
