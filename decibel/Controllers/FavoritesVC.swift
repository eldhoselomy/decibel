//
//  FavoritesVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit


class FavoritesVC: BaseVC {

    @IBOutlet weak var favoritesTableView: UITableView!
    let favoritesVM = FavoritesVM()
    
    override func setup() {
        super.setup()
        configureNavigationBar()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLibrary()
    }
    
    private func configureNavigationBar(){
        self.title = Strings.FAVORITES
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func configureTableView(){
        favoritesTableView.estimatedRowHeight = 70
        favoritesTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func updateLibrary(){
        favoritesVM.favoriteSongs = AudioManager.shared.getLibrary().filter { $0.isFavorite }
        favoritesTableView.reloadData()
    }

    
}

extension FavoritesVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesVM.favoriteSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.cellIdentifier) as! MusicCell
        cell.configure(with: favoritesVM.favoriteSongs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

