//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Luis Rivera Rivera on 9/16/22.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    var videoURL: URL!
    
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let request = URLRequest(url: videoURL)
        webView.load(request)
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
