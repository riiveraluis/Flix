//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Luis Rivera Rivera on 9/13/22.
//

import AlamofireImage
import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String: Any]!
    var movieURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backdropPath = movie["backdrop_path"] as! String
        backdropImageView.af.setImage(withURL: movieBackdropURLFrom(path: backdropPath))
        
        
        let posterPath = movie["poster_path"] as! String
        posterImageView.af.setImage(withURL: moviePosterURLFrom(path: posterPath))
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseURL = "https://www.youtube.com/watch?v="
        let movieID = String(movie["id"] as! Int)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                let trailers = dataDictionary["results"] as! [[String : Any]]
                
                let trailerKey = trailers[0]["key"] as! String
                
                self.movieURL = URL(string: baseURL + trailerKey)!
            }
        }
        task.resume()
        
        
    }
    
    func moviePosterURLFrom(path: String) -> URL {
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseUrl + path)
        return posterURL!
    }
    
    func movieBackdropURLFrom(path: String) -> URL {
        let baseUrl = "https://image.tmdb.org/t/p/w780"
        let backDropURL = URL(string: baseUrl + path)
        return backDropURL!
    }
    
    @IBAction func posterTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: Constants.videoSegue, sender: self)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationVC = segue.destination as! MovieTrailerViewController
        // Pass the selected object to the new view controller.
        destinationVC.videoURL = movieURL
    }
}
