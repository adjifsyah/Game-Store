//
//  Home.swift
//  Game Store
//
//  Created by Adji Firmansyah on 28/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var show = false
    @State var txt = ""
    var body: some View {
        VStack {
            HStack{
                if !self.show{
                     Text("GAME STORE")
                        .fontWeight(.bold)
                        .font(.title)
                }
                Spacer()
                HStack{
                    
                    if self.show{
                        TextField("Search Games", text: self.$txt)
                        .padding(10)
                        .font(Font.system(size: 15, weight: .medium, design: .monospaced))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        
                        Button(action: {
                            withAnimation {
                                self.txt = ""
                                self.show.toggle()
                            }
                        }) {
                            Image(systemName: "xmark").foregroundColor(.black)
                        }.padding(.horizontal, 8)
                    }
                    else{
                        Button(action: {
                            withAnimation {
                                self.show.toggle()
                            }
                        }) {
                            Image(systemName: "magnifyingglass").foregroundColor(.black).padding(10)
                        }
                    } 
                }
            .padding(self.show ? 10 : 0)
            .cornerRadius(20)
               
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
            Spacer()
            HView()
            GameItem()
            
        }
            
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            Home()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone Lamaku")
            
            Home()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone Baruku")
        }
    }
    
}

struct HView: View {
    @State var results = [GAME] ()
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    // update data
                    if (results.count==0) {
                        HStack {
                            Spacer()
                        }
                    }
                    

                    ForEach (results, id: \.id) {item in
                        NavigationLink(destination: DetailGame(results: item)) {
                        ImageViewContainer(imageUrl: item.backgroundImage)
                        /*    .resizable()
                        .frame(width:350,height: 180)
                        .cornerRadius(20)
                        .padding(.leading, 16) */
                        }
                    } // end forEach
                }
            }
        }.onAppear(perform: loadData)
        
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.rawg.io/api/games?dates=2019-10-10,2020-10-10&ordering=-added") else {
                    print("Invalid URL")
                        return
        }
        let request = URLRequest(url: url)
        
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                            // we have good data – go back to the main thread
                            DispatchQueue.main.async {
                                print(decodedResponse)
                                self.results = decodedResponse.results
                            }
                        // everything is good, so we can exit
                        return
                    }
                }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}


