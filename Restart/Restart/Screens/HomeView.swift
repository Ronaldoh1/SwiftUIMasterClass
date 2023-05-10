//
//  HomeView.swift
//  Restart
//
//  Created by RONALD HERNANDEZ on 5/5/23.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @AppStorage("onboarding") var isOnboardingViewActive = false
    // MARK: - Body
    
    @State private var isAnimating = false

    var body: some View {
        VStack {
           // MARK - Header
           Spacer()
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(
                    Animation
                        .easeOut(duration: 4)
                        .repeatForever()
                    , value: isAnimating)
            }
            
            // MARK: - Center
            Text("The time that leads to mastery is dependent on the intensity of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            
            Button(action: {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewActive = true
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)

        }// VSTACK
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
