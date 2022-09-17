//
//  MoviesGridViewController.swift
//  Flix
//
//  Created by Luis Rivera Rivera on 9/16/22.
//

import UIKit

class MoviesGridViewController: UIViewController {
    var movies = [[String: Any]]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/429617/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // TODO: Store the movies in a property to use elsewhere
                self.movies = dataDictionary["results"] as! [[String : Any]]
                
                // TODO: Reload your collection view data
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        
        let movie = movies[indexPath!.item]
        let destinationVC = segue.destination as! MovieDetailViewController
        destinationVC.movie = movie
    }
    
    
}

extension MoviesGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as! MovieGridCollectionViewCell
        
        let movie = movies[indexPath.item]
        let posterPath = movie["poster_path"] as! String
        
        cell.posterImageView.af.setImage(withURL: moviePosterURLFrom(path: posterPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func moviePosterURLFrom(path: String) -> URL {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseUrl + path)
        
        return posterURL!
    }
}
