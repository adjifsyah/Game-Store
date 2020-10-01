//
//  Profile.swift
//  Game Store
//
//  Created by Adji Firmansyah on 03/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @Binding var navbar : Bool
    @Binding var show : Bool
    @Binding var index : String
    @State var edit = false
    @State var text = ""
    @State var name = ""
    @State var email = ""
    @State var showImagePicker : Bool = false
    @ObservedObject var userSetting = UserSetting()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var image : Data = .init(count: 0)
    var userData : GameModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // Costum Navbar
                HStack {
                    Button(action: {
                        self.index = "HomeView"
                        withAnimation {
                            self.navbar.toggle()
                            self.show.toggle()
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Button(action: {
                        if self.image.count != 0 {
                            self.edit.toggle()
                            let userProfile: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserData")
                            userProfile.predicate = NSPredicate(format: "username == %@",self.userData.username ?? "")
                            userProfile.fetchLimit = 1
                            
                            do {
                            let updateData = try self.managedObjectContext.fetch(userProfile)
                            if !updateData.isEmpty {
                            
                            let updateData = updateData[0] as! NSManagedObject
                                self.managedObjectContext.insert(updateData)
                                try? self.managedObjectContext.save()
                            } else {
                            let save = GameModel(context: self.managedObjectContext)
                           // save.imageD = self.image
                            save.username = self.name
                            save.email = self.email
                            print("save")
                            try? self.managedObjectContext.save()
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            self.edit.toggle()
                        }
                    }) {
                        Text(self.edit ? "Selesai" : "Edit")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                if !self.edit {
                    // Tampilan Profile Depan
                    if image.count != 0  {
                        // Tampilan Dari Core Data
                        VStack {
                         /*   Button(action: {
                                
                            }) {
                                Image(uiImage: UIImage(data: self.userData.imageD ?? self.image)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } */
                            VStack {
                                Text("\(userData.username ?? "")")
                                    .font(.system(size: 22))
                                    .bold()
                                Text("\(userData.email ?? "")")
                                    .font(.system(size: 14))
                            }.padding(.top,10)
                        }
                    } else {
                        // Tampilan jika Tidak Memiliki Data
                        VStack {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 100))
                                .foregroundColor(.gray)
                            VStack {
                                Text("Nama Lengkap")
                                    .font(.system(size: 22))
                                    .bold()
                                Text("Email")
                                    .font(.system(size: 14))
                            }.padding(.top,10)
                        }
                    }
                    Divider()
                    Spacer()
                } else {
                    // Tampilan Edit Profile
                    VStack {
                        if image.count != 0 {
                            Button(action: {
                                self.showImagePicker.toggle()
                            }) {
                                Image(uiImage: UIImage(data: self.image)!)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            }
                        } else {
                            Button(action: {
                                self.showImagePicker.toggle()
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 100))
                                    .foregroundColor(.gray)
                            }
                        }
                        VStack {
                            HStack {
                                Text("Nama ")
                                VStack {
                                    TextField("Nama Lengkap", text: $name)
                                        .font(.system(size: 16))
                                        .padding(.horizontal, 30).padding(.top, 8)
                                    Divider()
                                        .padding(.leading, 25)
                                }
                            }
                            HStack {
                                Text("Email ")
                                VStack {
                                    TextField("Email", text: $email)
                                        .font(.system(size: 16))
                                        .padding(.leading,4)
                                        .padding(.horizontal, 30).padding(.top, 8)
                                    Divider()
                                        .padding(.leading, 28)
                                }
                            }
                            Spacer()
                        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
            }.onAppear{self.checkDataAlreadyExist()}
            .sheet(isPresented: self.$showImagePicker, content: {
                ImagePicker(showImagePicker: self.$showImagePicker, image: self.$image).environmentObject(\.managedObjectContext, self.managedObjectContext)
                })
            .navigationBarTitle(" ",displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    func checkDataAlreadyExist(){
        // Cek game id di coredata
        let userProfile: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserData")
        userProfile.predicate = NSPredicate(format: "username == %@", userData.username ?? "")
        userProfile.fetchLimit = 1
        
        do {
            let save = try self.managedObjectContext.fetch(userProfile)
            
            //Jika data exist maka delete, jika tidak maka save
            if !save.isEmpty {
                self.edit.toggle()
            }
        } catch {
            print(error)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    @State static var navbar = false
    @State static var show = false
    @State static var index = " "
    
    static var previews: some View {
        ProfileView(navbar: $navbar, show: $show, index: $index, userData: GameModel())
    }
}
