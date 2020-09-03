//RohanRenganathan
//  ContentView.swift
//  BullsEye
//
//  Created by Rohan Renganathan on 06/05/2020.
//  Copyright © 2020 Rohan Renganathan. All rights reserved.
//

import SwiftUI
import AVFoundation



struct ContentView: View {
 
    func sliderValueRounded() -> Int {
       Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let difference = amountOff()
        let bonus:Int
        
        if difference == 0 {
            bonus = 100
        }
        else if difference >= 1 && difference <= 10 {
            bonus = 502
        }
            
        else if difference > 10 && difference <= 20 {
            bonus = 25
        }
            
        else {
            bonus = 0
        }
        return bonus
    }

// Alert message shown to the user depending on where they place the slider
    func alertTitle() -> String {
     let difference = abs(target - sliderValueRounded())
        let title:String
        
        if difference == 0 {
            title = "Perfect!"
        }
        else if difference >= 1 && difference <= 10 {
            title = "You almost had it!"
        }
        else if difference > 10 && difference <= 20 {
            title = "Not bad!"
        }
        else  {
         title = "Are you even trying ?!?!"
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        return title
    }
 
    func scoreText() -> String {
        let difference = abs(target - sliderValueRounded())
        let title:String
        
        if difference == 0 {
                title = "You're on fire 🔥 "
            }
            else if difference >= 1 && difference <= 10 {
                title = "Very Close 👌🏾"
            }
            else if difference > 10 && difference <= 20 {
                title = "Try harder 🤞🏾 "
            }
            else  {
             title = "Way too far 🙅🏾‍♂️"
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
            return title
        }
    
// This function called when user clicks start over as it resets all of the statistics
   func startNewGame() {
    playWiiMusic()
    score = 0
    round = 1
    sliderValue = 250.0
    target = Int.random (in: 1...500)
    timeRemaining = 60
    }

// The code begins here
    
//ViewModifier returns the newly styled view
    
    struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
        .foregroundColor(Color.white)
        .modifier(Shadow())
        .font (Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
            .font (Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font (Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
           func body(content: Content) -> some View {
               return content
               .foregroundColor(Color.black)
               .font (Font.custom("Arial Rounded MT Bold", size: 12))
           }
       }
    
  
//@State variable means that Swift will refresh the body every time the variable changes
    @State var alertIsVisible:Bool = false
    @State var sliderValue = 250.0
    @State var target = Int.random(in: 1...500)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51 / 255.0, blue: 102.0 / 255.0)
    
    @State private var isActive = true
    @State private var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showScore:Bool = false
    
    @State var WiiMusicPlaying:Bool = false
    
    var body: some View {
        
        VStack {
            Text("Time: \(timeRemaining)")
                .frame(width: 120, height: 50)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    
            Capsule()
                        .fill(Color.black)
                        .opacity(0.75)
                )
            
            Spacer()
//This is the target row
            HStack {
                Text("Put the BullsEye as close as you can to:").modifier(LabelStyle()).modifier(Shadow())
                Text("\(target)").modifier(ValueStyle()).modifier(Shadow())
            }
            Spacer()
        
//This is the slider row
            HStack {
               Text("1").modifier(LabelStyle()).modifier(Shadow())
                Slider(value: $sliderValue, in: 1...500).accentColor(Color.green)
                Text("500").modifier(LabelStyle()).modifier(Shadow())
            }
            Spacer()
            
//This is the button row
            Button(action: {
//                print("Button pressed!")
                playExplosion(sound: "explosion", type: "mp3")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }
                
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                
                return Alert(title: Text("\(alertTitle())") , message: Text("Slider's value: \(sliderValueRounded())\n" +
                    "You scored \(pointsForCurrentRound()) points this round"), dismissButton: .default(Text(scoreText())) {
                        self.score = self.score + self.pointsForCurrentRound()
                        self.target = Int.random (in: 1...500)
                        self.round = self.round + 1
                    } )
            }
// This is the background image display for the game
            .background(Image("Button")).modifier(Shadow())
            Spacer()
            
            
//This is the score row
            HStack {
                Button(action: {
                    self.startNewGame()
                    playWhoosh(sound: "whoosh", type: "mp3")

                }) {
                    HStack {
                    Image("StartOverIcon")
                    Text("Start over").modifier(ButtonSmallTextStyle()).modifier(Shadow())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text ("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                    Image("InfoIcon").modifier(Shadow())
                    Text("Info").modifier(ButtonSmallTextStyle()).modifier(Shadow())
                }
            }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"))
    .accentColor(midnightBlue)
    .navigationBarTitle("BullsEye")
    
        
        .onAppear {
//            print ("Outside if \(self.WiiMusicPlaying) ")
            if (!self.WiiMusicPlaying) {
                print ("View Appeared!")
                playWiiMusic()
                 self.WiiMusicPlaying = true
            }
        }
        
// Timer counts down from 60 seconds (value assigned to the timer at the start)
        .onReceive(timer) { time in
            guard self.isActive else { return }
            
            if (self.timeRemaining == 12) {
              playTimerSound(sound: "timer", type: "mp3")
            }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            
            if (self.timeRemaining == 12) {
                playTimerSound(sound: "timer", type: "mp3")
            }
                
            if (self.timeRemaining == 0) {
                self.showScore.toggle()
                playWiiMusic()

                self.score = 0
                self.round = 1
                self.timeRemaining = 60
            }
        }
    }
}
    
    
struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}




