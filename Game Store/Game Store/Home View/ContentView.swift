//
//  ContentView.swift
//  Game Store
//
//  Created by Adji Firmansyah on 26/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var image : UIImage? = nil
    var body: some View {
        SideMenu()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone X"))
    }
}
