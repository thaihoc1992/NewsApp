//
//  MainViewController.swift
//  newsApp
//
//  Created by ADMIN on 6/24/21.
//

import UIKit
import Alamofire
import SwiftyJSON


class MainViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsData = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        getData()
    }

    func getData(){
        let url = "https://newsapi.org/v2/top-headlines?sources=bbc-news,cbc-news,nbc-news,fox-news,mtv-news=&page=1&pageSize=10&apiKey=ae6f8aa011a24475b5291f87afa37ca6"
        
        let urlRequest = URL(string: url)!
        AF.request(urlRequest, method: .get, encoding: URLEncoding.default).responseJSON { [weak self] (response) in
            
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let value):
                if let data = News(json: JSON(value)){
                    DispatchQueue.main.async {
                        strongSelf.newsData = data.articles
                        strongSelf.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.article = newsData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(newsData[indexPath.row].title)
        if let url = URL(string: newsData[indexPath.row].url) {
            UIApplication.shared.open(url)
        }
    }
}

