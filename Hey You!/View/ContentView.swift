//
//  ContentView.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-19.
//

import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ConnectionModel()
    
    var body: some View {
        ZStack {
            model.danceColor
                .edgesIgnoringSafeArea(.all)

//            VStack {
//                switch model.connectionState {
//                case .connected:
                    ConnectedView(model: model)
//                case .searching:
//                    SearchingView()
//                case .noConnection:
//                    TimeoutView()
//                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
