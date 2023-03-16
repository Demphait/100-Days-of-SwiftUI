//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bohdan Plastun on 30.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingScoreSecond = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var move = 0
    @State private var animationAmount = 0.0
    @State private var buttonOpacity = 1.0
    @State private var scaleEffect = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
//                    .titleStyle() // for challenge day 24, works only without two modifiers below
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in // Don't undestand number where is from?
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        }   label: {
                            // old version
                            // Image(countries[number])
                            // .renderingMode(.original)
                            // .clipShape(Capsule())
                            // .shadow(radius: 5)
                            
                            // new version with seperate struct
                            FlagImage(country: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : 0.0), axis:  (x: 0, y: 1, z: 0))
                        .opacity(number != correctAnswer ? buttonOpacity : 1.0)
                        .scaleEffect(number != correctAnswer ? scaleEffect : 1.0)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Correct", isPresented: $showingScoreSecond) {
            Button("Reset", action: reset)
        } message: {
            Text("Game over. Your score is - \(userScore). Reset the game to start over")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            move += 1
            animationAmount += 360
            buttonOpacity -= 0.75
            scaleEffect -= 0.1
            if move >= 8 {
                showingScoreSecond = true
                return
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            userScore -= 1
            move += 1
            buttonOpacity = 0.25
            scaleEffect = 0.9
            if userScore <= 0 {
                userScore = 0
            }
        }
            showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationAmount = 0
        buttonOpacity = 1.0
        scaleEffect = 1.0
    }
    
    func reset() {
        askQuestion()
        userScore = 0
        move = 0
    }
    
}

// new structs for challenge day 24

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct customTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(customTitle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
