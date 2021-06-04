import SwiftUI
import AVKit

public struct HelpView: View {
    var text: String
    @Environment(\.colorScheme) var colorScheme
    
    // video player
    var player = AVQueuePlayer()
    var playerLooper: AVPlayerLooper
    var asset: AVAsset
    var item: AVPlayerItem
    
    public init(text: String, videoName: String) {
        self.text = text
        asset = AVAsset(url: Bundle.main.url(forResource: videoName, withExtension: "MOV")!)
        item = AVPlayerItem(asset: asset)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            Text("Instructions")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .frame(width: 300, height: 100)
                .padding()
            
            // image frame animation
            VideoPlayer(player: player)
                .background(Color.white)
                .frame(width: 549.5, height: 333)
                .onAppear() {
                    player.play()
                }
                
            Text(text)
                .font(.system(size: 26, design: .rounded))
                .frame(width: 680, height: 100, alignment: .center)
                .padding(20)
                
        }.padding(20)
        .foregroundColor(colorScheme == .dark ? .white : .gray)
    }
}
