//
//  Api_Connect.swift
//  PopCorn
//
//  Created by Vqpie on 31/05/2021.
//

import Foundation
import UIKit



func fetchApi(url:String, toDo:  @escaping (Data) -> Void){
    let ChallengesURL = URL(string: url)
                if let unwrappedURL = ChallengesURL {
                    let request = URLRequest(url: unwrappedURL)
                    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if let data = data {
                                toDo(data)
                        }
                    }
                    dataTask.resume()
                }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

func loadImage(from url: String,imageUi : UIImageView) {
    guard let imageURL = URL(string: url) else { return }

        // just not to cause a deadlock in UI!
    DispatchQueue.global().async {
        guard let imageData = try? Data(contentsOf: imageURL) else { return }

        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            imageUi.image = image
        }
    }
}
