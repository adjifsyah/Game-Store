//
//  CardShimmer.swift
//  Game Store
//
//  Created by Adji Firmansyah on 19/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct ImageShimmer: View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    var body: some View {
        ZStack {
            Color.black.opacity(0.09)
                .frame(width: 350,height: 180)
                .cornerRadius(20)
            Color.white
                .frame(width: 350,height: 180) 
                .cornerRadius(20)
                .mask(
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: self.show ? center : -center))
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
    }
}

struct ScrollShimmer: View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    var body: some View {
        ZStack {
            Color.black.opacity(0.09)
                .frame(width: 90,height: 120)
                .cornerRadius(16)
            Color.white
                .frame(width: 90,height: 120)
                .cornerRadius(16)
                .mask(
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: self.show ? center : -center))
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
    }
}

struct DetailShimmer : View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    var body : some View{
        VStack (alignment: .leading){
            ZStack{
                Color.black.opacity(0.09)
                    .frame(height: 260)
                    .cornerRadius(0)
                
                Color.white
                    .frame(height: 260)
                    .cornerRadius(0)
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                            .rotationEffect(.init(degrees: 70))
                            .offset(x: self.show ? center : -center))
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 250,height: 18, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 250,height: 18, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        .padding(.trailing)
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 180,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 150,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 110,height: 14, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 80,height: 14, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                    }
                    Spacer()
                    ZStack {
                        Color.black.opacity(0.09)
                            .frame(width: 30,height: 24)
                            .cornerRadius(4)
                        
                        Color.white
                            .frame(width: 30,height: 24)
                            .cornerRadius(4)
                            .mask(
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                    .rotationEffect(.init(degrees: 70))
                                    .offset(x: self.show ? center : -center))
                    }.frame(width: 30)
                        .padding(.bottom,35)
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                VStack (alignment: .leading,spacing: 12) {
                    ZStack {
                        Color.black.opacity(0.09)
                            .frame(width: 70,height: 15, alignment:.leading)
                            .cornerRadius(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Color.white
                            .frame(width: 70,height: 15, alignment:.leading)
                            .cornerRadius(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .mask(
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                    .rotationEffect(.init(degrees: 70))
                                    .offset(x: self.show ? center : -center))
                    }
                    VStack (spacing: 8) {
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center))
                        }
                        ZStack {
                            Color.black.opacity(0.09)
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Color.white
                                .frame(width: 370,height: 15, alignment:.leading)
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .mask(
                                    Rectangle()
                                        .fill(
                                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom))
                                        .rotationEffect(.init(degrees: 70))
                                        .offset(x: self.show ? center : -center)
                            )
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            Spacer()
        }.navigationBarTitle("",displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){
                    self.show.toggle()
                }
        }
    }
}

struct CardShimmer_Previews: PreviewProvider {
    static var previews: some View {
        ImageShimmer()
    }
}
