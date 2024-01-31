import UIKit
import AVKit

class FavoritesController: UIViewController {

    private var tableView = UITableView()
    var likedSongss: [LikedSong] = []
    private var videoPlayer: AVPlayer?
    
    private let welcome: UILabel = {
        let welcome = UILabel()
        welcome.text = "Liked Songs"
        welcome.font = .systemFont(ofSize: 35, weight: .heavy)
        welcome.textColor = .systemIndigo
        return welcome
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
        
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(welcome)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        welcome.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            welcome.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            welcome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: welcome.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addLikedMediaItem(_ mediaItem: LikedSong) {
        DispatchQueue.main.async {
            self.likedSongss.append(mediaItem)
            let indexPath = IndexPath(row: self.likedSongss.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func removeLikedMediaItem(_ mediaItem: LikedSong) {
        DispatchQueue.main.async {
            if let indexToRemove = self.likedSongss.firstIndex(where: { $0.trackName == mediaItem.trackName }) {
                self.likedSongss.remove(at: indexToRemove)
                let indexPath = IndexPath(row: indexToRemove, section: 0)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension FavoritesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedSongss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let likedMediaItem = likedSongss[indexPath.row]
        cell.textLabel?.text = likedMediaItem.trackName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaItem = likedSongss[indexPath.row]
        guard let videoUrl = URL(string: mediaItem.previewURL ?? "") else {
            print("Invalid or nil URL for video playback.")
            return
        }

        videoPlayer = AVPlayer(url: videoUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = videoPlayer

        present(playerViewController, animated: true) {
            self.videoPlayer?.play()
        }
    }
}
