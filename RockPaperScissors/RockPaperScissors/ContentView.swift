//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bohdan Plastun on 03.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    let moves = ["🪨", "📄", "✂️"]
    let winningMoves = ["📄", "✂️", "🪨"]
    let losingMoves = ["✂️", "🪨", "📄"]
    @State var choiceOfMoves = Int.random(in: 0...2)
    @State var winOrLose = Bool.random()
    @State var userScore = 0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()

                VStack(spacing: 20) {

                    Text("The app has selected")
                        .font(.title)
                        
                    Text(moves[choiceOfMoves])
                        .font(.system(size: 100))
                    
                    Group {
                        Text("You must ")
                            .font(.title2)
                        + Text ("\(winOrLose ? "Win" : "Lose")")
                            .font(.title2)
                            .foregroundColor(winOrLose ? .green : .red)
                    }
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                moveTapped(number)
                            } label: {
                                Text(moves[number])
                                    .font(.system(size: 100))
                            }
                        }
                    }
                    Text("Please choose the right move")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Your score \(userScore)")
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert("Correct", isPresented: $showingScore) {
            Button("Reset", action: reset)
        } message: {
            Text("Your score is a maximum - \(userScore). Reset the game to start over")
        }
    }
    
    func moveTapped(_ number: Int) {
        if winOrLose {
            if moves[number] == winningMoves[choiceOfMoves] {
                userScore += 1
                if userScore >= 10 {
                    showingScore = true
                    return
                }
            } else {
                userScore -= 1
                if userScore <= 0 {
                    userScore = 0
                }
            }
        } else {
            if moves[number] == losingMoves[choiceOfMoves] {
                userScore += 1
                if userScore >= 10 {
                    showingScore = true
                }
            } else {
                userScore -= 1
                if userScore <= 0 {
                    userScore = 0
                }
            }
        }
        
        choiceOfMoves = Int.random(in: 0...2)
        winOrLose.toggle()
    }
    
    func reset() {
        choiceOfMoves = Int.random(in: 0...2)
        winOrLose.toggle()
        userScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
