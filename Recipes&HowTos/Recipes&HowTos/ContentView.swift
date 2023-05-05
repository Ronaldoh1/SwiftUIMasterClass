//
//  ContentView.swift
//  Recipes&HowTos
//
//  Created by RONALD HERNANDEZ on 5/5/23.
//

import SwiftUI

extension Image {
    
    func imageModifiers() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .imageModifiers()
            .frame(width: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
    
}

struct ContentView: View {
    private let imageURL = "https://credo.academy/credo-academy@3x.png"
    var body: some View {
        // MARK: - 1. Basic
        //AsyncImage(url: URL(string: imageURL))
        
        // MARK: - Scale
//        AsyncImage(url: URL(string: imageURL), scale: 3.5)
        // MARK: Place Holder
//        AsyncImage(url: URL(string: imageURL)) { image in
//            image.imageModifiers()
//
//        } placeholder: {
//            Image(systemName: "photo.circle.fill")
//                .iconModifier()
//        }
//        .padding(40)
        
        // MARK: - Phase
//        AsyncImage(url: URL(string: imageURL)) { phase in
//            // Success
//            // Failure
//            // Empty
//            if let image = phase.image {
//                image.imageModifiers()
//            } else if phase.error != nil {
//                Image(systemName: "ant.circle.fill").iconModifier()
//            } else {
//                Image(systemName: "photo.circle.fill").iconModifier()
//            }
//        }
        
        // MARK: 5. Animation
        AsyncImage(url: URL(string: imageURL),transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25)))  { phase in
            switch phase {
            case .success(let image):
                image.imageModifiers()
                    .transition(.move(edge: .bottom))
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            
            @unknown default:
                ProgressView()
            }
            
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
