//
//  ContentView.swift
//  PinchApp
//
//  Created by RONALD HERNANDEZ on 5/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffSet: CGSize = .zero
    
    // MARK: - Function
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffSet = .zero
        }
    }
    
    
    // MARK: - Content
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK:- Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffSet.width, y: imageOffSet.height)
                    .scaleEffect(imageScale)
                // MARK: - Tap Gesture
                    .onTapGesture {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                resetImageState()
                            }
                        }
                    }
                // MARK Drag Gesture
                    .gesture(
                    DragGesture()
                        .onChanged  { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffSet = value.translation
                            }
                        }
                        .onEnded({ _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        })
                    )
            }// Z Stack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            }
        } // Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
