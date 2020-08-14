//
//  File.swift
//  Game Store
//
//  Created by Adji Firmansyah on 27/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var data:Data?
 
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
 
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
 
            DispatchQueue.main.async {
                print("data")
                self.data = data
            }
        }.resume()
 
    }
}

struct ListViewContainer: View {
    @ObservedObject var imageLoader: ImageLoader
 
    init(imageUrl: String) {
        imageLoader  = ImageLoader(imageUrl: imageUrl)
    }
 
    var body: some View {
        Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage.init(named: "mentah")!)
                .resizable()
                .cornerRadius(20)
                .frame(height: 210)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
        
    }
}
 
struct ImageViewContainer: View {
    @ObservedObject var imageLoader: ImageLoader
 
    init(imageUrl: String) {
        imageLoader  = ImageLoader(imageUrl: imageUrl)
    }
 
    var body: some View {
        Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage.init(named: "mentah")!)
                .renderingMode(.original)
                .resizable()
                .frame(width:350,height: 180)
                .cornerRadius(20)
                .padding(.leading, 16)
             /*
            .resizable()
            .cornerRadius(20)
            .frame(height: 210)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
 */
        
    }
}

struct DetailViewContainer: View {
    @ObservedObject var imageLoader: ImageLoader
 
    init(imageUrl: String) {
        imageLoader  = ImageLoader(imageUrl: imageUrl)
    }
 
    var body: some View {
        Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage.init(named: "mentah")!)
                .resizable()
                .frame( height: 200)
                .cornerRadius(25)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct VViewContainer: View {
    @ObservedObject var imageLoader: ImageLoader
 
    init(imageUrl: String) {
        imageLoader  = ImageLoader(imageUrl: imageUrl)
    }
 
    var body: some View {
        Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage.init(named: "mentah")!)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 90,height: 120)
                .clipped()
                .cornerRadius(16)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 2))
                .frame(height: 145, alignment: .top)
                
    }
}
 
struct imageView: View {
 
    let image_url = "https://api.rawg.io/api/games"
 
    var body: some View {
        List{
            ForEach(1..<10){_ in
                ImageViewContainer(imageUrl: self.image_url)
                
            }
        }
    }
}
 
 
 
 
struct imageView_Previews: PreviewProvider {
    static var previews: some View {
        imageView()
    }
}
