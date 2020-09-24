//
//  AlbumDetailsViewController.swift
//  Album
//
//  Created by Danya on 9/15/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import UIKit
import SafariServices

class AlbumDetailsViewController: UIViewController {
    
    var viewModel:AlbumModel?
    var albumImageView = UIImageView()
    var scrollView = UIScrollView()
    var goToAlbum = UIButton()
    var stackView   = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumDetailsViewController {
    func setUp() {
        self.title = DisplayableText.albumDetailNavigationTitle
        
        //Get the Feed results Object
        let feedResult = viewModel?.resultsArray?[viewModel?.selectedIndex ?? 0]
        
        // ScrollView
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height + 64.0))
        scrollView.backgroundColor = .white
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        //Album Image view
        albumImageView.frame = CGRect(x: 0.0, y: 20.0, width: self.view.frame.size.width, height: 200)
        albumImageView.backgroundColor = .clear
        albumImageView.downloaded(from: feedResult?.imageUrl ?? "")
        
        //Go to Album Button
        goToAlbum = UIButton(type: UIButton.ButtonType.system)
        goToAlbum.backgroundColor = UIColor.init(red: 45/250, green: 140/250, blue: 123/250, alpha: 1)
        goToAlbum.layer.cornerRadius = 10.0
        goToAlbum.setTitle(DisplayableText.goToAlbumTitle, for: .normal)
        goToAlbum.setTitleColor(.white, for: .normal)
        goToAlbum.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        goToAlbum.addTarget(self, action:#selector(self.goToAlbumButtonClick), for: .touchUpInside)
        self.view.addSubview(goToAlbum)
        self.view.bringSubviewToFront(goToAlbum)
        
        goToAlbum.translatesAutoresizingMaskIntoConstraints = false;
        goToAlbum.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        goToAlbum.widthAnchor.constraint(equalToConstant: 300).isActive = true
        goToAlbum.heightAnchor.constraint(equalToConstant: 50).isActive = true
        goToAlbum.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true

        //Album Name Label
        let albumNameLabel = UILabel()
        albumNameLabel.backgroundColor = .clear
        albumNameLabel.textColor = .black
        albumNameLabel.numberOfLines = 0
        albumNameLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        if let albName = feedResult?.albumName {
            albumNameLabel.text  = DisplayableText.albumName + albName
        }
        albumNameLabel.textAlignment = .left
        
        //Artist Name Label
        let artistNameLabel = UILabel()
        artistNameLabel.backgroundColor = .clear
        artistNameLabel.textColor = .black
        artistNameLabel.numberOfLines = 0
        artistNameLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        if let artistName = feedResult?.artistName {
            artistNameLabel.text  = DisplayableText.artistName + artistName
        }
        artistNameLabel.textAlignment = .left
        
        //Release Date Label
        let releaseDateLabel = UILabel()
        releaseDateLabel.backgroundColor = .clear
        releaseDateLabel.textColor = .black
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        releaseDateLabel.text  = feedResult?.releaseDate
        if let releaseDate = feedResult?.releaseDate {
            releaseDateLabel.text  = DisplayableText.releaseDate + releaseDate
        }

        releaseDateLabel.textAlignment = .left
        
        //Copyright Label
        let copyRightLabel = UILabel()
        copyRightLabel.backgroundColor = .clear
        copyRightLabel.textColor = .black
        copyRightLabel.numberOfLines = 0
        copyRightLabel.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        copyRightLabel.text  = feedResult?.copyRightText
        copyRightLabel.textAlignment = .left


        //Stack View
        stackView.frame = CGRect(x: 10.0, y: albumImageView.frame.height, width: self.view.frame.size.width, height: self.view.frame.maxY - 40.0)
        stackView.translatesAutoresizingMaskIntoConstraints = false;

        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 20.0

        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(copyRightLabel)
        scrollView.addSubview(albumImageView)

        scrollView.addSubview(stackView)
        
        self.scrollView.contentSize = self.scrollView.subviews.reduce(CGRect.zero, {
           return $0.union($1.frame)
        }).size

        setUpConstraints()

    }
    
    func setUpConstraints() {
        stackView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 30.0).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0).isActive = true
        
    }
    
    @objc func goToAlbumButtonClick() {
        let feedResult = viewModel?.resultsArray?[viewModel?.selectedIndex ?? 0]
        if let genreURL = feedResult?.genres.first?.genreURL {
            guard let url = URL(string: genreURL) else {
                return
            }
            let safariVC = SFSafariViewController(url: url)
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(safariVC, animated: true, completion: nil)
            }
        } else {
            //Show alert
            let alert = UIAlertController(title: DisplayableText.alertErrorTitle, message: DisplayableText.alertErrorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: DisplayableText.ok, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AlbumDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
