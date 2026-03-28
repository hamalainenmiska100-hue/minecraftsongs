import AVFoundation
import Foundation

enum LoopMode: String, CaseIterable {
    case normal
    case shuffleForever
    case singleForever
}

@MainActor
final class PlayerEngine: ObservableObject {
    @Published var songs = Song.all
    @Published var currentSong: Song = Song.all[0]
    @Published var isPlaying = false
    @Published var loopMode: LoopMode = .normal
    @Published var crossfadeSeconds: Double = 0
    @Published var showDeveloperOverlay = false

    private var player = AVPlayer(url: Song.all[0].url)

    func play(song: Song) {
        currentSong = song
        player.replaceCurrentItem(with: AVPlayerItem(url: song.url))
        player.play()
        isPlaying = true
    }

    func togglePlayback() {
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    func next() {
        switch loopMode {
        case .singleForever:
            play(song: currentSong)
        case .shuffleForever:
            let filtered = songs.filter { $0.id != currentSong.id }
            if let picked = filtered.randomElement() {
                play(song: picked)
            }
        case .normal:
            guard let idx = songs.firstIndex(of: currentSong) else { return }
            let nextIdx = (idx + 1) % songs.count
            play(song: songs[nextIdx])
        }
    }

    func handle(url: URL) {
        guard url.scheme == "amethyst" else { return }
        switch url.host {
        case "play": play(song: currentSong)
        case "shuffle": loopMode = .shuffleForever; next()
        case "repeat": loopMode = .singleForever; play(song: currentSong)
        default: break
        }
    }
}
