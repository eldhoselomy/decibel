//
//  MusicLibraryVM.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import Foundation

protocol MusicLibraryVMDelegate: class {
    func didFetchLibrary()
    func didFailedToFetchLibrary(error: String)
}

class MusicLibraryVM{
    
    var songs: [Track] = []
    var filteredSongs: [Track] = []
    weak var delegate: MusicLibraryVMDelegate?
    
    func fetchLibrary(){
        Services.songs.get { [weak self]  (result) in
            switch result{
            case .success(let library):
                self?.songs = library.songs
                self?.filteredSongs = library.songs
                self?.delegate?.didFetchLibrary()
            case .failure(let error):
                self?.delegate?.didFailedToFetchLibrary(error: error.localizedDescription)
            }
        }
    }
}
