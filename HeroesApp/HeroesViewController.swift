//
//  HeroesViewController.swift
//  HeroesApp
//
//  Created by Mesut Aygün on 30.09.2021.
//

import UIKit

class HeroesViewController: UIViewController {
    
    var heroDetail : heroesModel?
    
    @IBOutlet weak var hereosImage: UIImageView!
    @IBOutlet weak var heroesName: UILabel!
    @IBOutlet weak var heroesAttribute: UILabel!
    @IBOutlet weak var heroesAttack: UILabel!
    @IBOutlet weak var heroesLeg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        UINavigationBar.appearance().backgroundColor = .purple
        
        heroesName.text = heroDetail?.localized_name
        heroesAttribute.text = heroDetail?.primary_attr
        heroesAttack.text = heroDetail?.attack_type
        heroesLeg.text = "\((heroDetail?.legs)!)"
        
        let urlString = "https://api.opendota.com"+(heroDetail?.img)!
        let url = URL(string: urlString)
        DispatchQueue.main.async {
            self.hereosImage.downloaded(from: url!)
        }
        
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
