import Foundation

struct Song: Identifiable, Hashable {
    let id: Int
    let title: String
    let url: URL

    static let all: [Song] = [
        Song(id: 1, title: "Key", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/01%20-%20Key.mp3")!),
        Song(id: 2, title: "Door", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/02%20-%20Door.mp3")!),
        Song(id: 3, title: "Subwoofer Lullaby", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/03%20-%20Subwoofer%20Lullaby.mp3")!),
        Song(id: 4, title: "Death", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/04%20-%20Death.mp3")!),
        Song(id: 5, title: "Living Mice", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/05%20-%20Living%20Mice.mp3")!),
        Song(id: 6, title: "Moog City", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/06%20-%20Moog%20City.mp3")!),
        Song(id: 7, title: "Haggstrom", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/07%20-%20Haggstrom.mp3")!),
        Song(id: 8, title: "Minecraft", url: URL(string: "https://ia801607.us.archive.org/17/items/08-minecraft_202302/08%20-%20Minecraft.mp3")!),
        Song(id: 9, title: "Oxygène", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/09%20-%20Oxygène.mp3")!),
        Song(id: 10, title: "Équinoxe", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/10%20-%20Équinoxe.mp3")!),
        Song(id: 11, title: "Mice on Venus", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/11%20-%20Mice%20on%20Venus.mp3")!),
        Song(id: 12, title: "Dry Hands", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/12%20-%20Dry%20Hands.mp3")!),
        Song(id: 13, title: "Wet Hands", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/13%20-%20Wet%20Hands.mp3")!),
        Song(id: 14, title: "Clark", url: URL(string: "https://dn710204.ca.archive.org/0/items/08-minecraft_202302/14%20-%20Clark.mp3")!)
    ]
}
