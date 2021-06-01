//
//  MoviesViewController.swift
//  PopCorn
//
//  Created by Vqpie on 26/04/2021.
//

import UIKit


import Foundation



class MoviesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var categorieId: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    
    //configuration des sous-vues du tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //on donne les éléments réutilisables pour la réutilsation des cell( optimisation de la mémoire
        let cell = tableView.dequeueReusableCell(withIdentifier:MovieTableViewCell.reuseId,for:indexPath) as! MovieTableViewCell
        //on récupère le movie qui correspond à cette élément
        let movie = movies[indexPath.row]
        // si on à 
        if(movie.title != movie.originalTitle ){
            cell.underTitle.text=movie.originalTitle
        }
        else{
            cell.underTitle.text=""
        }
        cell.title.text = movie.title
        loadImage(from: "https://image.tmdb.org/t/p/w500" + movie.posterPath,imageUi: cell.affiche)
        return cell
        
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    	
    var movies:[Film] = [
              
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApi(url: "https://api.themoviedb.org/3/discover/movie?api_key=9583271d8b5d5fa2e6cc20a73547f9b3&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate&with_genres="+String(categorieId),
                 toDo:  {(data:Data) -> Void in
                    do{
                        let json = try JSONDecoder().decode(APIResponseMovies.self, from: data) as APIResponseMovies
                        DispatchQueue.main.async {
                            self.movies=json.results
                            self.tableView.reloadData()
                        
                                    }
                        } catch{
                            print(error)
                    }
                 }
               )

            self.setupViews()
    }
    
    func setupViews(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.register( UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieTableViewCell.reuseId)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fetchApi(url: "https://api.themoviedb.org/3/movie/"+String(movies[indexPath.row].id)+"?api_key=9583271d8b5d5fa2e6cc20a73547f9b3&language=en-US",
                 toDo:  {(data:Data) -> Void in
                    do{
                        let movie = try JSONDecoder().decode(APIResponseMovie.self, from: data) as APIResponseMovie
                        DispatchQueue.main.async {
                            let movieviewcontroller = MovieViewController(nibName: "MovieViewController", bundle: nil)
                            movieviewcontroller.movie = movie
                            self.present( movieviewcontroller , animated: true )
                            
                                    }
                        } catch{
                            print(error)
                    }
                 }
               )
        
    }
}

