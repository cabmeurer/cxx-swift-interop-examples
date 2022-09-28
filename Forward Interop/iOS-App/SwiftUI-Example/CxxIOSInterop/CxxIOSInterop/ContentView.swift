//
//  ContentView.swift
//  CxxIOSInterop
//
//  Created by Caleb Meurer on 2/28/22.
//

import SwiftUI
import Cxx

struct ContentView: View {
    var body: some View {
        Text("Cxx function result: \(cxxFunction(7))")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
