//
//  ContentView.swift
//  RestartAppDemo
//
//  Created by Suraj Parshad on 05/02/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage ("onboarding") var isOnBoardingActive : Bool = true
    var body: some View {
        ZStack {
            if isOnBoardingActive{
                OnboardingView()
            } else{
                HomeView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
