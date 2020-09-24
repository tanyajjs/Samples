//
//  AlbumsViewController.swift
//  Album
//
//  Created by Danya on 9/14/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    let albumModel = AlbumModel()
    let albumTableView = UITableView()
    var activityView = UIActivityIndicatorView()
    var activityContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
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

extension AlbumsViewController {
    func setUp() {
        self.view.backgroundColor = UIColor.lightGray
        setUpNavigation()
        setTableView()
        fetchAlbumList()
    }
    
    func setTableView() {
        self.view.addSubview(albumTableView)
        albumTableView.translatesAutoresizingMaskIntoConstraints = false
        albumTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        albumTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        albumTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        albumTableView.dataSource = self
        albumTableView.delegate = self
        albumTableView.register(AlbumCellTableViewCell.self, forCellReuseIdentifier: "AlbumCell")
    }
    
    func setUpNavigation() {
        navigationItem.title = DisplayableText.albumListNavigationTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 220/250, green: 250/250, blue: 246/250, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
    }
    
    func fetchAlbumList() {
        self.showActivityIndicator()
        albumModel.getAlbumList { (status) in
            if status == true {
                DispatchQueue.main.async { // Correct
                    self.hideActivityIndicator()
                    self.albumTableView.reloadData()
                }
            } else {
                DispatchQueue.main.async { // Correct
                    self.hideActivityIndicator()
                    //Show an alert
                    let alert = UIAlertController(title: DisplayableText.alertErrorTitle, message: DisplayableText.alertErrorMessage, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: DisplayableText.ok, style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func showActivityIndicator() {
        activityContainerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height) // Set X and Y whatever you want
        activityContainerView.backgroundColor = .white

        activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false;

        activityContainerView.addSubview(activityView)
        self.view.addSubview(activityContainerView)
        activityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 25).isActive = true

        activityView.startAnimating()
    }

    func hideActivityIndicator(){
        activityContainerView.removeFromSuperview()
        activityView.stopAnimating()
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumModel.selectedIndex = indexPath.row
        let vc : AlbumDetailsViewController = AlbumDetailsViewController();
        vc.viewModel = self.albumModel
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumModel.resultsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCellTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.feedResult = self.albumModel.resultsArray?[indexPath.row]
        return cell
    }
}
