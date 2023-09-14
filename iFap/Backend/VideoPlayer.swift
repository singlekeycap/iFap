//
//  VideoPlayer.swift
//  iFap
//
//  Created by Dre Dall'Ara on 7/7/23.
//

import Foundation
import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: URL
    
    init(videoURL: URL) {
        self.videoURL = videoURL
    }
    
    var body: some View {
        VideoPlayerWrapper(videoURL: .constant(videoURL))
    }
}

struct VideoPlayerWrapper: UIViewControllerRepresentable {
    @Binding var videoURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback)
        controller.player = AVPlayer(url: videoURL)
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true
        controller.canStartPictureInPictureAutomaticallyFromInline = true
        controller.player?.allowsExternalPlayback = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // No updates needed
    }
}
