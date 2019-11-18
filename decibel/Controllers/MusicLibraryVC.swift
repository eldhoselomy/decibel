//
//  MusicLibraryVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class MusicLibraryVC: BaseVC {
    
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var miniPlayerView: MiniPlayerView!
    
    private let musicLibraryVM = MusicLibraryVM()
    
    override func setup() {
        super.setup()
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
        configureGestures()
        fetchMusic()
    }
    
    
    private func configureNavigationBar(){
        self.title = Strings.LIBRARY
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func configureSearchBar(){
        let searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchBar.delegate = self
        self.navigationItem.searchController = searchVC
    }
    
    private func configureTableView(){
        songsTableView.estimatedRowHeight = 70
        songsTableView.rowHeight = UITableView.automaticDimension
        songsTableView.separatorStyle = .none
    }
    
    private func fetchMusic(){
        musicLibraryVM.delegate = self
        musicLibraryVM.fetchLibrary()
    }
    
    private func configureGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPlayer))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showPlayer))
        swipeGesture.direction = .up
        miniPlayerView.addGestureRecognizer(tapGesture)
        miniPlayerView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func showPlayer(){
        showMusicPlayer()
    }
    
    private func showMiniPlayer(song: Track){
        songsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: miniPlayerView.frame.height, right: 0)
        miniPlayerView.configure(with: song)
        miniPlayerView.isHidden = false
    }
    
    private func hideMiniPlayer(){
        songsTableView.contentInset = UIEdgeInsets.zero
        miniPlayerView.isHidden = true
    }
    
    fileprivate func showMusicPlayer(){
        guard let musicPlayerVC = storyboard?.instantiateViewController(identifier: MusicPlayerVC.storyboardID) as? MusicPlayerVC else{
            return
        }
        self.present(musicPlayerVC, animated: true, completion: nil)
    }
}

extension MusicLibraryVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicLibraryVM.filteredSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.cellIdentifier) as! MusicCell
        cell.configure(with: musicLibraryVM.filteredSongs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let songs = musicLibraryVM.filteredSongs[indexPath.row ..< musicLibraryVM.filteredSongs.count]
        AudioManager.shared.playAudio(songs: Array(songs))
        showMiniPlayer(song: musicLibraryVM.filteredSongs[indexPath.row])
        showMusicPlayer()
    }
    
}

extension MusicLibraryVC: MusicLibraryVMDelegate{
    
    func didFetchLibrary() {
        AudioManager.shared.setLibrary(songs: musicLibraryVM.songs)
        DispatchQueue.main.async { [weak self] in
            self?.songsTableView.separatorStyle = .singleLine
            self?.songsTableView.reloadData()
        }
    }
    
    func didFailedToFetchLibrary(error: String) {
        songsTableView.separatorStyle = .none
        print(error)
    }
}

extension MusicLibraryVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            musicLibraryVM.filteredSongs = musicLibraryVM.songs
            songsTableView.reloadData()
            return
        }
        musicLibraryVM.filteredSongs = musicLibraryVM.songs.filter{$0.song.lowercased().contains(searchText.lowercased())}
        songsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        musicLibraryVM.filteredSongs = musicLibraryVM.songs
        songsTableView.reloadData()
    }
}

