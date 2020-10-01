//
//  Home.swift
//  Game Store
//
//  Created by Adji Firmansyah on 28/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct HomeView : View {
    @Binding var show : Bool
    @Binding var navbar : Bool
    @Binding var index : String
    @State var back = false
    @State var isSearch = false
    @State var image : UIImage? = nil
    var body : some View {
        ZStack {
            VStack(spacing: 0) {
                if self.isSearch == !self.back {
                    SearchView(back: $back)
                } else {
                    if !self.navbar {
                        ZStack {
                            HStack{
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        self.show.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .resizable()
                                        .frame(width: 20, height: 15)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                                Button(action: {
                                    self.isSearch.toggle()
                                }) {
                                    Image(systemName : "magnifyingglass")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(.black)
                                }
                            }
                            Text("Game Store")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    }
                    ZStack {
                        VStack (alignment: .leading) {
                            ScrollingView()
                        }.opacity(self.index == "HomeView" ? 1 : 0)
                        ProfileView(navbar: $navbar, show: $show, index: $index, userData: GameModel()).opacity(self.index == "Profile" ? 1 : 0)
                        FavoriteView(index: $index,navbar: $navbar, show: $show).opacity(self.index == "Favorite" ? 1 : 0)
                        Settings().opacity(self.index == "Settings" ? 1 : 0)
                    }
                }
            }.background(Color.white)
                .cornerRadius(15)
        }
    }
}

struct Home_Previews: PreviewProvider {
    @State static var show = false
    @State static var navbar = false
    @State static var index = " "
    static var previews: some View {
        Group{
            HomeView(show: $show, navbar: $navbar, index: $index)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone Lamaku")
            
            HomeView(show: $show, navbar: $navbar, index: $index)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone Baruku")
        }
    }
}



struct Settings : View {
    var body : some View {
        GeometryReader {_ in
            VStack {
                Text("Settings")
            }
        }
    }
}
