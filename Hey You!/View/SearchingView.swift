//
//  SearchingForConnectionView.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-24.
//

import SwiftUI

struct SearchingView: View {
    @State private var isAnimating = false
    @State private var showExplainer = false

    private var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }

    var body: some View {
        VStack(spacing: 70) {
            Image("searching")
                .resizable()
                .frame(width: 150, height: 150)
                .modifier(self.makeOrbitEffect(
                  diameter: 100
                ))
                .animation(Animation
                  .linear(duration: 2)
                  .repeatForever(autoreverses: false)
                )
                .animation(self.isAnimating ? foreverAnimation : .default)
                .onAppear { self.isAnimating = true }
                .onDisappear { self.isAnimating = false }

            VStack {
                Text("Searching for your light...")
                Text("Make sure it's powered on!")
            }

            VStack {
                Button("Not sure what this is?") {
                    showExplainer = true
                }
            }
        }.sheet(isPresented: $showExplainer) {
            ExplainerView(isPresented: $showExplainer)
        }
    }

    func makeOrbitEffect(diameter: CGFloat) -> some GeometryEffect {
      return OrbitEffect(
        percent: self.isAnimating ? 1.0 : 0.0,
        radius: diameter / 2.0)
    }
}

struct OrbitEffect: GeometryEffect {
  let initialAngle = CGFloat.random(in: 0 ..< 2 * .pi)

  var percent: CGFloat = 0
  let radius: CGFloat

  var animatableData: CGFloat {
    get { return percent }
    set { percent = newValue }
  }

  func effectValue(size: CGSize) -> ProjectionTransform {
    let angle = 2 * .pi * percent + initialAngle
    let pt = CGPoint(
      x: cos(angle) * radius,
      y: sin(angle) * radius)
    return ProjectionTransform(CGAffineTransform(translationX: pt.x, y: pt.y))
  }
}
