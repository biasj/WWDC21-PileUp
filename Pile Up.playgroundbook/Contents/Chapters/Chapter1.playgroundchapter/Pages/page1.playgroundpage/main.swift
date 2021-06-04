//#-hidden-code
import PlaygroundSupport
import SwiftUI
import Module

PlaygroundPage.current.setLiveView(
    ContentView()
        .environmentObject(PuzzleGame())

)

PlaygroundPage.current.wantsFullScreenLiveView = true
//#-end-hidden-code
//: # Pile Up
//: ## Welcome to my puzzle!! 🧩
//: This puzzle was developed as a tribute to my family, especially to my mom and dad who love puzzles and passed it on to me 🥰
//: ## Description 💻
//: The objective of this puzzle is to pile all blocks of the same colors inside the highlighted spot matching its colors, but don't worry, because further instructions will be specified during the experience.
//: ## Color Accessibility 🟡🔵🟢🔴
//: In case you have some kind of color blindness or difficulty seeing colors, keep in mind that blocks that have dots on the same corner, are the same colors. And that you should pile all blocks of the same colors at the place where it has a marked corner matching the dots position.
