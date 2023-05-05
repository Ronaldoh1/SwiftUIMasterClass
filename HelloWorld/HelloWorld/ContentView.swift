//
//  ContentView.swift
//  HelloWorld
//
//  Created by RONALD HERNANDEZ on 5/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Link("Go to Apple", destination: URL(string: "https:apple.com")!)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(.indigo)
            Text("iOS")
                .font(.system(size: 180))
                .fontWeight(.black)
                .foregroundStyle(.orange.gradient)
            Text("iOS")
                .font(.system(size: 50))
                .fontWeight(.black)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.orange,.blue, .orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
