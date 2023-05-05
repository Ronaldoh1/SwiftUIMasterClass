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
        AsyncImage(url: URL(string: imageURL), scale: 3.5)
        // MARK: Place Holder
        AsyncImage(url: URL(string: imageURL)) { image in
            image.imageModifiers()
                
        } placeholder: {
            Image(systemName: "photo.circle.fill")
                .iconModifier()
        }
        .padding(40)
        
        // MARK: - Extension
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
