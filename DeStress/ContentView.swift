//
//  ContentView.swift
//  DeStress
//

import SwiftUI
import SwiftData


let captionText: String = "Welcome to ZenBreath. The app helps you to calm down, relax, and focus. Practice mindfulness. Stay calm and focused."

struct ContentView: View {
    
    @Environment(\.modelContext) private var context: ModelContext
    @StateObject private var viewModel: BoxBreathingViewModel

     init() {
         _viewModel = StateObject(wrappedValue: BoxBreathingViewModel(context: Environment(\.modelContext).wrappedValue))
     }
    
    @State private var caption: String = ""
    @State private var showHomeView = false
    @State private var fadeInText = false
    @State private var fadeInButton = false
    

    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            if showHomeView {
                HomeView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.5), value: showHomeView)
                    .modelContainer(for: BreathingStatistic.self) // Ensure context is passed to HomeView
            } else {
                VStack {
                    Spacer()

                    VStack(spacing: 15) {
                        Text("ZenBreath")
                            .font(.custom("AmericanTypewriter", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 2)
                                    .foregroundColor(.white)
                                    .offset(y: 10),
                                alignment: .bottom
                            )

                        Text(caption)
                            .font(.custom("AmericanTypewriter", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .fixedSize(horizontal: false, vertical: true)
                            .opacity(fadeInText ? 1 : 0)
                            .animation(.easeIn(duration: 1.5), value: fadeInText)
                    }
                    .frame(maxWidth: 300)
                    .padding(.horizontal, 20)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            showHomeView = true
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 55, height: 55)
                                .foregroundColor(Color("powderBlue"))
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                    }
                    .opacity(fadeInButton ? 1 : 0)
                    .animation(.easeInOut(duration: 1.5).delay(0.5), value: fadeInButton)
                    .padding(.bottom, 40)
                }
                .padding()
                .onAppear {
                    typeWriter()
                    fadeInText = true
                    fadeInButton = true
                }
            }
        }
        .modelContainer(for: BreathingStatistic.self) // Ensure context is available for all child views
    }

    func typeWriter(at position: Int = 0) {
        if position == 0 { caption = "" }
        if position < captionText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                caption.append(captionText[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
