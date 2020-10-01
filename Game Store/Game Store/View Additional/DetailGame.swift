//
//  DetailGame.swift
//  Game Store
//
//  Created by Adji Firmansyah on 28/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailGame: View {
    @State var gameId : Int
    @ObservedObject var gameDetail = GameDetailApi()
    @ObservedObject var userSetting = UserSetting()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isButton = false
    var DataGames : GameModel
    
    var body: some View {
        VStack (alignment: .leading) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18))
                Text("Kembali")
            }.padding(.horizontal)
            if gameDetail.gameDetail != nil {
                withAnimation {
                    ScrollView {
                        VStack (alignment: .leading,spacing: 5) {
                            ImageViewContainer(imageUrl: gameDetail.gameDetail?.backgroundImage ?? "")
                                .frame( height: 260)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(gameDetail.gameDetail?.name ?? "")")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                    if gameDetail.gameDetail?.genres != nil {
                                        HStack (spacing: 0) {
                                            Text("Genre : ")
                                                .font(.footnote)
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.gray)
                                            ForEach (gameDetail.gameDetail!.genres, id: \.id) { gDetail in
                                                Text("\(gDetail.name ?? ""), ")
                                                    .font(.footnote)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color.gray)
                                                    .lineLimit(2)
                                            }
                                        }
                                    }
                                    if gameDetail.gameDetail?.rating != nil {
                                        Text("Rating : \(gameDetail.gameDetail!.rating!, specifier: "%.2f") ")
                                            .font(.footnote)
                                            .fontWeight(.regular)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                                Spacer()
                                Button(action: {
                                    self.isButton.toggle()
                                    
                                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GameModel")
                                    fetchRequest.predicate = NSPredicate(format: "id ==%d", Int32(self.gameDetail.gameDetail?.id ?? 0))
                                    fetchRequest.fetchLimit = 1
                                    
                                    do {
                                        let dataToDelete = try self.managedObjectContext.fetch(fetchRequest)
                                        
                                        if !dataToDelete.isEmpty {
                                            let dataToDelete = dataToDelete[0] as! NSManagedObject
                                            self.managedObjectContext.delete(dataToDelete)
                                            try? self.managedObjectContext.save()
                                        } else {
                                            let newGame = GameModel(context: self.managedObjectContext)
                                            newGame.name = self.gameDetail.gameDetail?.name
                                            newGame.backgroundImage = self.gameDetail.gameDetail?.backgroundImage
                                            newGame.descriptions = self.gameDetail.gameDetail?.description
                                            newGame.released = self.gameDetail.gameDetail?.released
                                            newGame.rating = self.gameDetail.gameDetail?.rating ?? 0
                                            newGame.id = self.gameDetail.gameDetail?.id ?? 0
                                            print("save")
                                            try? self.managedObjectContext.save()
                                        }
                                    } catch {
                                        print(error)
                                    }
                                    
                                }, label: {
                                    Image(systemName: isButton ? "suit.heart.fill" : "suit.heart" )
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                        .padding(.bottom,35)
                                })
                            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            
                            VStack (alignment: .leading,spacing: 4) {
                                Text("About")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text("\(gameDetail.gameDetail?.description?.withoutHtmlTags ?? "")")
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .opacity(0.9)
                            }.padding()
                        }.edgesIgnoringSafeArea(.all)
                    }
                }.onAppear{self.checkDataAlreadyExist()}
            } else {
                withAnimation {
                    DetailShimmer()
                }
            }
        }.onAppear {self.gameDetail.loadData(gameId: self.gameId)
        }
        .navigationBarTitle(Text(" "), displayMode: .inline)
        .navigationBarHidden(true)
    }
    func checkDataAlreadyExist(){
        // Cek game id di coredata
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GameModel")
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(self.gameDetail.gameDetail?.id ?? 0))
        fetchRequest.fetchLimit = 1
        
        do {
            let gameData = try self.managedObjectContext.fetch(fetchRequest)
            
            //Jika data exist maka delete, jika tidak maka save
            if !gameData.isEmpty {
                self.isButton.toggle()
            }
        } catch {
            print(error)
        }
        
    }
}


struct DetailGame_Previews: PreviewProvider {
    static var previews: some View {
        DetailGame(gameId: 23632, DataGames: GameModel())
    }
}

extension String {
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
                "", options:.regularExpression, range: nil)
    }
}
