//
//  ProfileVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class ProfileVC: BaseVC {

    @IBOutlet weak var profileTableView: UITableView!
    private let profileVM = ProfileVM()
    
    override func setup() {
        super.setup()
        self.title = Strings.PROFILE
    }

    func configureTable(){
        profileTableView.estimatedRowHeight = 70
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.tableFooterView = UIView()
    }

}

extension ProfileVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileVM.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row > 0 else{
            return tableView.dequeueReusableCell(withIdentifier: ProfileCell.cellIdentifier)!
        }
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellIdentifier) as! SettingsCell
        settingsCell.configure(with: profileVM.settings[indexPath.row])
        return settingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = profileVM.settings[indexPath.row]
        switch selectedOption {
        case .call:
            Utils.call(number: profileVM.profile.phone)
        case .email:
            sendMail()
        case .resume:
            showResume()
        case .portfolio:
            showURL(url: profileVM.profile.portfolio)
        default:
            return
        }
    }
}

extension ProfileVC: MFMailComposeViewControllerDelegate{
    func sendMail(){
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([profileVM.profile.email])
            mailComposerVC.setSubject("Support Request")
            self.present(mailComposerVC, animated: true, completion: nil)
        }else{
            print("No emails configured in your device")
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC{
    func showURL(url: String){
        guard let webURL = URL(string: url) else{
            return
        }
        let safariVC = SFSafariViewController(url: webURL)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func showResume(){
        guard let webVC = storyboard?.instantiateViewController(identifier: WebVC.storyboardID) else{
            return
        }
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
