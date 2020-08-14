//
//  DetailGame.swift
//  Game Store
//
//  Created by Adji Firmansyah on 28/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct DetailGame: View {
    @State var results : GAME
    var body: some View {
        
        VStack {
            ScrollView {
                VStack (alignment: .leading,spacing: 5){
                    DetailViewContainer(imageUrl: results.backgroundImage)
                   /*     .resizable()
                        .frame( height: 200)
                        .cornerRadius(25)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)) */
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(results.name)
                                .font(.system(size: 24))
                                .bold()
                            Text("Publisher")
                                .font(.system(size: 18))
                                .foregroundColor(Color.gray)
                                .padding(.bottom)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
                    VStack (alignment: .leading,spacing: 4){
                        Text("About")
                            .font(.system(size: 18))
                            .bold()
                        Text("Deskripsi bla bla bla")
                            .font(.system(size: 14))
                    }.padding()
                }
            }
        }.onAppear(perform: loadData)
    }
    func loadData() {
        guard let detailUrl = URL(string: "https://api.rawg.io/api/games/\(results.id)") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: detailUrl)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(GAME.self, from: data) {
                    //
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.results = decodedResponse
                    }
                    
                    //
                    return
                }
            }
            
            //
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct DetailGame_Previews: PreviewProvider {
    @State var result : GAME
    
    static var previews: some View {
        
        DetailGame(results: GAME())
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        
    }
}

