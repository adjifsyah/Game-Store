//
//  FavoriteView.swift
//  Game Store
//
//  Created by Adji Firmansyah on 02/09/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @State var isFavorite = false
    @Binding var index : String
    @Binding var navbar : Bool
    @Binding var show : Bool
    @ObservedObject var gameDetail = GameDetailApi()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: GameModel.entity(),
        sortDescriptors: [], predicate : NSPredicate(format: "id == id")
    ) var games: FetchedResults<GameModel>
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 0) {
                Button(action: {
                    withAnimation {
                        self.index = "Home"
                        self.navbar.toggle()
                        self.show.toggle()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 0))
                }
                Text("Favorite")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
                Divider()
                
                if games.isEmpty {
                    VStack {
                        Spacer()
                        Text("No Game Favorite")
                            .padding(.horizontal)
                        Spacer()
                    }.frame(maxWidth: .infinity)
                } else {
                    VStack {
                        List {
                            ForEach (games, id: \.self) { item in
                                NavigationLink(destination: DetailGame(gameId: Int(item.id), DataGames: item)) {
                                    HStack {
                                        ImageViewContainer(imageUrl: item.backgroundImage ?? "")
                                            .scaledToFill()
                                            .frame(width: 80,height: 90)
                                            .clipped()
                                            .cornerRadius(10)
                                        VStack (alignment: .leading) {
                                            Text("\(item.name ?? "")")
                                                .bold()
                                                .lineLimit(1)
                                                .font(.system(size: 18))
                                                .foregroundColor(.black)
                                                .padding(.top,4)
                                            Text("Rating: \(item.rating, specifier: "%.2f")")
                                                .font(.system(size: 14))
                                            Spacer()
                                            Text("Released: \(item.released ?? "")")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }.onDelete(perform: deleteGame)
                        }
                    }
                }
                
            }.navigationBarTitle(" ",displayMode: .inline)
                .navigationBarHidden(true)
        }
    }
    func deleteGame(at offsets: IndexSet) {
        offsets.forEach { index in
            let games = self.games[index]
            self.managedObjectContext.delete(games)
        }
        saveContext()
    }
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}


struct FavoriteView_Previews: PreviewProvider {
    @State static var index = ""
    @State static var navbar = false
    @State static var show = false
    static var previews: some View {
        FavoriteView(index: $index, navbar: $navbar, show: $show)
    }
}
