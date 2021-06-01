//
//  MovieViewController.swift
//  PopCorn
//
//  Created by Vqpie on 26/04/2021.
//

import UIKit
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

class MovieViewController: UIViewController {
    //Movie de la vue
    var movie : APIResponseMovie? = nil
    
    @IBOutlet weak var Titre: UILabel!
    @IBOutlet weak var SousTitre: UILabel!
    
    @IBOutlet weak var DateSortie: UILabel!
    @IBOutlet weak var Duree: UILabel!
    
    @IBOutlet weak var Image1: UIImageView!
    
    @IBOutlet weak var Image2: UIImageView!
    
    @IBOutlet weak var genre1: UILabel!
    @IBOutlet weak var genre2: UILabel!
    @IBOutlet weak var genre3: UILabel!
    
    @IBOutlet weak var Synopsis: UILabel!
    
    @IBOutlet weak var Link: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupview()
        
    }
    
    //on récupère tous les éléments de l'instance de movie et on rentre les valeurs dans les différents éléments ui
    func setupview(){

        Titre.text = movie!.title
        SousTitre.text = movie!.originalTitle
        DateSortie.text = "Sortie " + movie!.releaseDate
        //on parse le temps en minute pour avoir une donnée en heure
        Duree.text = "Durée " + String(movie!.runtime/60) + " h " + String(movie!.runtime%60)
        
        //chargement des images
        loadImage(from: "https://image.tmdb.org/t/p/w500" + movie!.posterPath, imageUi: Image1)
        loadImage(from: "https://image.tmdb.org/t/p/w500" + movie!.backdropPath, imageUi: Image2)
        genre1.text = movie!.genres[0].name
        if (movie!.genres.count > 1 ){
            genre2.text = movie!.genres[1].name
        }
        else{
            genre2.text = ""
        }
        if (movie!.genres.count > 2 ){
            genre3.text = movie!.genres[2].name
        }
        else{
            genre3.text=""
        }
        Synopsis.text = movie!.overview
        
        

    }
    
    //récupération du lien de la vidéo du trailer et on navigue si on trouve
    @IBAction func openExternalLink(_ sender: Any) {

        fetchApi(url: "https://api.themoviedb.org/3/movie/"+String(movie!.id)+"/videos?api_key=9583271d8b5d5fa2e6cc20a73547f9b3&language=en-US",
                 toDo:  {(data:Data) -> Void in
                    do{
                        let videos: APIResponseVideo = try JSONDecoder().decode(APIResponseVideo.self, from: data) as APIResponseVideo
                        DispatchQueue.main.async {
                            if let url = URL(string: "https://www.youtube.com/watch?v=" + videos.results[0].key){
                            UIApplication.shared.open(url)
                                }
                            }
                        }
                    catch{
                            print(error)
                        }
                 }
                 
               )
        }
    }

