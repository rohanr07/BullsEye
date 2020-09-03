//RohanRenganathan
//  AboutView.swift
//  BullsEye
//
//  Created by Rohan Renganathan on 07/05/2020.
//  Copyright © 2020 Rohan Renganathan. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let blue = Color(red: 29.0 / 255.0, green: 107.0 / 255.0, blue: 145.0 / 255.0)
    
    struct AboutHeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            playInfoSong(sound: "song", type: "mp3")
            return content
            .foregroundColor(Color.black)
            .font (Font.custom("Arial Rounded MT Bold", size: 30))
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
    }
    
    struct AboutBodyStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font (Font.custom("Arial Rounded MT Bold", size: 16))
            .padding(.leading, 60)
            .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }

  var body: some View {
    Group {
        VStack {
            Text("🎯 BullsEye 🎯").modifier(AboutHeadingStyle())
            Text("This is BullsEye, the game where you can win points and earn fame by dragging a slider").modifier(AboutBodyStyle()).lineLimit(nil)
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are the more points you score").modifier(AboutBodyStyle()).lineLimit(nil)
            Text("Enjoy! \n \n Rohan Renganathan").multilineTextAlignment(.center).modifier(AboutBodyStyle())
        }
        .navigationBarTitle("About BullsEye")
      .background(blue)
    }
  .background(Image("Background"))
  }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
