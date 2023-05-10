//
//  OnboardingView.swift
//  Restart
//
//  Created by RONALD HERNANDEZ on 5/5/23.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth = UIScreen.main.bounds.width - 80 // stablish constriants for horizontal movement
    @State private var buttonOffSet: CGFloat = 0
    
    @State private var isAnimating = false
    
    @State private var imageOffSet: CGSize = .zero
    
    @State private var indicatorOpacity: Double = 1.0
    
    @State private var textTitle = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - Header
                Spacer()
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)//Identifiable view
                    
                    Text("""
                       It's not how much we give but how much love we put into giving.
                       """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(30)
                }// Header
                .opacity(isAnimating ? 1 : 0 )
                .offset(y: isAnimating ? 0: -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - Center
                
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffSet.width * -1)
                        .blur(radius: abs(imageOffSet.width / 5))
                        .animation(.easeOut(duration: 2), value: imageOffSet.width)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1: 0)
                        .animation(.easeOut(duration: 0.75), value: isAnimating)
                        .offset(x: imageOffSet.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffSet.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffSet.width) <= 150 {
                                        imageOffSet = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                    
                                }.onEnded { _ in
                                    // reset
                                    imageOffSet  = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                    
                                }
                        ) //: Gesture
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                }// Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    ,alignment: .bottom
                )
                
                Spacer()
                
                // MARK: - Footer
                
                
                ZStack {
                    // static background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // call to action
                Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    // capsule dynamic
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffSet + 80)
                        Spacer()
                    }
                    // circle dragable
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }.foregroundColor(.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: buttonOffSet)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        if gesture.translation.width > 0 && buttonOffSet <= buttonWidth - 80 {
                                            buttonOffSet = gesture.translation.width
                                        }
                                    }
                                    .onEnded { gesture in
                                        withAnimation(Animation.easeOut(duration: 0.6)) {
                                            if buttonOffSet > buttonWidth / 2 {
                                                hapticFeedback.notificationOccurred(.success)
                                                playSound(sound: "chimeup", type: "mp3")
                                                buttonOffSet = buttonWidth - 80
                                                isOnboardingViewActive = false
                                            } else {
                                                hapticFeedback.notificationOccurred(.warning)
                                                buttonOffSet = 0
                                            }
                                        }
                                    }
                            ) // Gesture
                        Spacer()
                    }
                        
                    
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
           }
        } //: ZSTack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
