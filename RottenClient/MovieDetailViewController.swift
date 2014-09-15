//
//  MovieDetailViewController.swift
//  RottenClient
//
//  Created by Alex Choi on 9/13/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: MovieModel?
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var movieScoreLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("viewDidLoad")
        
        if movie != nil {
            
            println("view did load movie dtails")
            
            movieTitleLabel.text =          movie?.title
            movieScoreLabel.text =          movie?.criticsScore()
            movieDescriptionTextView.text =    movie?.description
            movieRatingLabel.text =         movie?.rating
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
