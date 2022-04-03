//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rodrigo Tarouco on 30/03/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var selectedFlag = ""
    @State private var endOfGameTitle = ""
    @State private var endOfTheGame = false
    @State private var numberOfQuestions = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    if scoreTitle == "Wrong" {
                        VStack {
                            Text("Wrong! That's the flag of \(selectedFlag)")
                            Text("Your score is \(score)")
                        }
                    } else {
                        Text("Your score is \(score)")
                    }
                }
                .alert(endOfGameTitle, isPresented: $endOfTheGame) {
                    Button("Restart", action: reset)
                } message: {
                    Text("Your final score was \(score)")
                }
            }.padding()
        }
    }
    func flagTapped(_ number: Int) {
        selectedFlag = countries[number]
        numberOfQuestions += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        if numberOfQuestions == 8 {
            endOfGameTitle = "The Game is over!"
            endOfTheGame = true
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
        numberOfQuestions = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
