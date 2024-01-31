//
//  SearchController.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 22.12.2023.
//

import UIKit
import AVKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
    private var mediaItems: [MediaItem] = []
    var likedSongs: [LikedSong] = []
    private let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Music"
        searchBar.layer.cornerRadius = 20
        view.addSubview(searchBar)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Search Bar constraints
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Table View constraints
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchMedia(with: searchTerm, mediaType: "music")
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Networking
    
    private func searchMedia(with term: String, mediaType: String) {
        let url = createSearchURL(for: term, mediaType: mediaType)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(SearchResult.self, from: data)
                    self.mediaItems = result.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    private func createSearchURL(for term: String, mediaType: String) -> URL {
        let baseUrl = "https://itunes.apple.com/search"
        let limit = 500
        
        var components = URLComponents(string: baseUrl)!
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "media", value: mediaType),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        return components.url!
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return mediaItems.count
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaItem = mediaItems[indexPath.row]
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let mediaItem = mediaItems[indexPath.row]

        cell.textLabel?.text = mediaItem.trackName
        loadImage(for: mediaItem, into: cell.imageView)

        // Configure the like button
        let likeButton = UIButton(type: .system)
        likeButton.tintColor = .red
        
        // Set the button's images for normal and selected states
        let heartImage = likedSongs.contains(where: { $0.trackName == mediaItem.trackName }) ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: heartImage), for: .normal)

        // Set target-action for the like button
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        likeButton.tag = indexPath.row

        // Set the like button as the accessory view
        cell.accessoryView = likeButton

        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        return cell
    }

    
    @objc func likeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let mediaItem = mediaItems[index]

        if let indexInLikedSongs = likedSongs.firstIndex(where: { $0.trackName == mediaItem.trackName }) {
            // Removing the song from likes
            likedSongs.remove(at: indexInLikedSongs)
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            
            // Update FavoritesController
            updateFavoritesControllerWith(likedSong: LikedSong(trackName: mediaItem.trackName, previewURL: mediaItem.previewUrl), shouldAdd: false)
        } else {
            // Adding the song to likes
            let likedSong = LikedSong(trackName: mediaItem.trackName, previewURL: mediaItem.previewUrl)
            likedSongs.append(likedSong)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)

            // Update FavoritesController
            updateFavoritesControllerWith(likedSong: likedSong, shouldAdd: true)
        }
    }

    private func updateFavoritesControllerWith(likedSong: LikedSong, shouldAdd: Bool) {
        DispatchQueue.main.async {
            if let favoritesController = self.tabBarController?.viewControllers?[2] as? FavoritesController {
                if shouldAdd {
                    favoritesController.addLikedMediaItem(likedSong)
                }
                else {
                    favoritesController.removeLikedMediaItem(likedSong)
                }
            }
            else {
                print("Workkk.")
            }
        }
    }

    // MARK: - Image Loading

    private func loadImage(for mediaItem: MediaItem, into imageView: UIImageView?) {
        guard let imageUrl = URL(string: mediaItem.artworkUrl100) else { return }

        if let cachedImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
            imageView?.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                    DispatchQueue.main.async {
                        imageView?.image = image
                        self.tableView.reloadRows(at: [IndexPath(row: self.mediaItems.firstIndex(of: mediaItem) ?? 0, section: 0)], with: .none)
                    }
                }
            }.resume()
        }
    }
}

