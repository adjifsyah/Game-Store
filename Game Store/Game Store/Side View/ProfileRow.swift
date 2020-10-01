//
//  ProfileRow.swift
//  Game Store
//
//  Created by Adji Firmansyah on 20/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//
/*
import Foundation
import SwiftUI

struct ProfileRow : View {
    @State var showImagePicker = false
    @Binding var image: UIImage?
    @ObservedObject var userSetting = UserSetting()
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(uiImage: image ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }.padding(.vertical)
                Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    Text("Ganti Photo")
                }
                VStack {
                    HStack {
                        Text("Nama ")
                        VStack {
                            TextField("Nama Lengkap", text: $userSetting.name)
                                .font(.system(size: 16))
                                .padding(.horizontal, 30).padding(.top, 8)
                            Divider()
                                .padding(.leading, 25)
                        }
                    }
                    HStack {
                        Text("Email ")
                        VStack {
                            TextField("Email", text: $userSetting.email)
                                .font(.system(size: 16))
                                .padding(.leading,4)
                                .padding(.horizontal, 30).padding(.top, 8)
                            Divider()
                                .padding(.leading, 28)
                        }
                    }
                    Spacer()
                }
            }.navigationBarTitle("",displayMode: .inline)
                .navigationBarHidden(true)
                .sheet(isPresented: $showImagePicker, onDismiss: {
                  self.showImagePicker = false
                }, content: {
                    ImagePicker(showImagePicker: self.$showImagePicker, image: self.$image)
                })
        }
    }
}

*/
