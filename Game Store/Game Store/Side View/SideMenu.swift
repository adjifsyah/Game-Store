//
//  sideMenu.swift
//  Game Store
//
//  Created by Adji Firmansyah on 24/08/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct SideMenu: View {
    @State var index = "HomeView"
    @State var show = false
    @State var navbar = false
    @State var showImagePicker = false
    @ObservedObject var userSetting = UserSetting()
    @Environment(\.managedObjectContext) var context
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    (self.show ? Color.black.opacity(0.05) : Color.clear).edgesIgnoringSafeArea(.all)
                    ZStack(alignment: .leading) {
                        VStack(alignment : .leading,spacing: 25) {
                            HStack(spacing: 15) {
                               /*
                                    Image(systemName: "person.crop.circle")
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .cornerRadius(50)
                               */
                                    Button(action: {
                                        self.showImagePicker.toggle()
                                    }) {
                                        Image(systemName: "person.crop.circle")
                                            .font(.system(size: 80))
                                            .foregroundColor(.gray)
                                    }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(self.userSetting.name.isEmpty ? "Name Lengkap" : self.userSetting.name  )")
                                        .fontWeight(.bold)
                                    
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            self.index = "Profile"
                                            self.show.toggle()
                                            self.navbar.toggle()
                                        }
                                    }) {
                                        Text("Lihat Profil")
                                            .font(.system(size: 14))
                                    }
                                }
                            }.padding(.bottom, 50)
                            Button(action: {
                                self.index = "HomeView"
                                withAnimation {
                                    self.show.toggle()
                                }
                            }) {
                                HStack {
                                    Text("Home")
                                        .padding(.leading)
                                        .foregroundColor(.black)
                                }
                            }
                            Button(action: {
                                self.index = "Favorite"
                                withAnimation(.spring()) {
                                    self.show.toggle()
                                    self.navbar.toggle()
                                }
                            }) {
                                HStack {
                                    Text("Favorite")
                                        .padding(.leading)
                                        .foregroundColor(.black)
                                }
                            }
                            Button(action: {
                                self.index = "Settings"
                                withAnimation(.spring()){
                                    self.show.toggle()
                                }
                            }) {
                                HStack {
                                    Text("Setting")
                                        .padding(.leading)
                                        .foregroundColor(.black)
                                }
                            }
                            Spacer()
                        }.padding(.leading)
                            .padding(.top)
                            .scaleEffect(self.show ? 1 : 0)
                        ZStack(alignment: .topTrailing) {
                            HomeView(show: self.$show, navbar: self.$navbar,index: self.$index)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.show ? geometry.size.width/1.3: 0)
                                .disabled(self.show ? true : false)
                        }
                    }
                }
            }.navigationBarTitle(" ",displayMode: .inline)
                .navigationBarHidden(true)
        }
    }
}



struct AnotherView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("No Data")
        }
    }
}
