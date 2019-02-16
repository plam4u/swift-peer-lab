//
//  ViewController.swift
//  MovieCollectionView
//
//  Created by Plamen Andreev on 02/02/2019.
//  Copyright © 2019 DMI Inc. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit

class ViewController: UIViewController {

  var movies = [Movie]()
  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    downloadFile()
  }

  func downloadFile() {
    let urlString = "https://tvpremiumhd.club/hd/peliculas.m3u"
    let url = URL(string: urlString)!
    let urlSession = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data else { fatalError() }

      let dataString = String(bytes: data, encoding: .utf8)!
      self.parse(string: dataString)

      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      print("Done!")
    }
    urlSession.resume()
  }

  func parse(string: String) {
    let lines = string.components(separatedBy: "#EXTINF:-1 ")
    for line in lines {
      let prefix = "tvg-logo=\""
      guard line.contains(prefix) else { continue }
      let lineWithoutPrefix = line[line.index(line.startIndex, offsetBy: prefix.count)...]
      let endImageUrlIndex = lineWithoutPrefix.firstIndex(of: "\"")!
      let commaSplit = line.split(separator: ",")
      let titleAndFileString = line[line.index(line.lastIndex(of: "\"")!, offsetBy: 1)...]
      let stuff = titleAndFileString.components(separatedBy: "\r\n")
      let title = String(stuff[0][stuff[0].index(stuff[0].startIndex, offsetBy: 1)...])
      //guard commaSplit.count == 3 else { continue }
      let movie = Movie(imageUrl: String(lineWithoutPrefix[..<endImageUrlIndex]),
                        title: title,
                        fileUrl: stuff[1])
        //title: "Title here",
      //fileUrl: "")
      movies.append(movie)
    }
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let imageView = cell.viewWithTag(123) as! UIImageView
    let label = cell.viewWithTag(456) as! UILabel
    let movie = movies[indexPath.row]
    let urlString = movie.imageUrl
    imageView.kf.setImage(with: URL(string: urlString)!)
    label.text = movie.title
    return cell
  }


}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = movies[indexPath.row]

    let vc = AVPlayerViewController()
    print(movie.fileUrl)
    let player = AVPlayer(url: URL(string: movie.fileUrl)!)
    vc.player = player
    player.play()
    present(vc, animated: true, completion: nil)
  }
}

struct Movie {
  let imageUrl: String
  let title: String
  let fileUrl: String
}
