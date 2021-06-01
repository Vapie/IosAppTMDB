//
//  CollectionViewController.swift
//  PopCorn
//
//  Created by Vqpie on 27/04/2021.
//

import UIKit

private let reuseIdentifier = "Cell"


import Foundation


private let sectionInsets = UIEdgeInsets(
  top: 50.0,
  left: 20.0,
  bottom: 50.0,
  right: 20.0)

extension CollectionViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       sizeForItemAt indexPath: IndexPath
     ) -> CGSize {
       // 2
       let paddingSpace = sectionInsets.left * (2 + 1)
       let availableWidth = view.frame.width - paddingSpace
       let widthPerItem = availableWidth / 2
       
       return CGSize(width: widthPerItem, height: widthPerItem)
     }
     
     // 3
     func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       insetForSectionAt section: Int
     ) -> UIEdgeInsets {
       return sectionInsets
     }
     
     // 4
     func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       minimumLineSpacingForSectionAt section: Int
     ) -> CGFloat {
       return sectionInsets.left
     }
}
class CollectionViewController: UICollectionViewController {
    
 
    
    private func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionView, sizeForItemAt indexPath:IndexPath	)->CGSize{
        return CGSize.init(width: view.frame.width, height: 250)
     
    }
    
    //@IBOutlet var coll: UICollectionView!
    
    //init(){
     //   super.init(collectionViewLayout: UICollectionViewFlowLayout())

    //}
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//
    
    var categories:[Categorie] = [
              
    ]
    //quand la vue charge on va charger les données, puis on met la vue à jour une fois les données reçues
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApi(url: "https://api.themoviedb.org/3/genre/movie/list?api_key=9583271d8b5d5fa2e6cc20a73547f9b3&language=en-US",
                 toDo:  {(data:Data) -> Void in
                    do{
                        let json = try JSONDecoder().decode(APIResponseCategorie.self, from: data) as APIResponseCategorie
                        DispatchQueue.main.async {
                            
                            self.categories=json.genres
                            self.collectionView.reloadData()
                        
                                    }
                        } catch{
                            print(error)
                    }
                 }
               )

            self.setupViews()
    }
    
    func setupViews(){
        print("sertuped")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register( UINib(nibName:"CategorieCollectionViewCell", bundle:nil ), forCellWithReuseIdentifier: CategorieCollectionViewCell.reuseId)
        
        
        //https://api.themoviedb.org/3/genre/movie/list?api_key=9583271d8b5d5fa2e6cc20a73547f9b3&language=en-US
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorieCollectionViewCell.reuseId, for: indexPath) as! CategorieCollectionViewCell
        
        print("cell creation")
        		
        
        let categorie  = categories[indexPath.row]
        cell.nom.text = categorie.name
        
        // Configure the cell
    
        return cell
        	
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller : MoviesViewController = MoviesViewController()
        controller.categorieId = categories[indexPath.row].id
        present(controller, animated: false)
        
    }

    
}
