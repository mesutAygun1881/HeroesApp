//
//  ViewController.swift
//  HeroesApp
//
//  Created by Mesut Aygün on 30.09.2021.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource ,UISearchBarDelegate {
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var heroesInfo  = [heroesModel]()
    var filteredData : [Any]!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        searchBar.delegate = self
        self.filteredData = self.heroesInfo
        tableView.delegate = self
        tableView.dataSource = self
        title = "HEROES"
        navigationController?.navigationBar.prefersLargeTitles = true
        downloadData {
            self.tableView.reloadData()
        }
    }
    
    
    //MARK -> json parse
    func downloadData(completed : @escaping ()->()){
        
        //MARK -> create URL
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        
        //MARK -> urlsession
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do{
                    self.heroesInfo = try JSONDecoder().decode([heroesModel].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    
                }
            }
        }.resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return heroesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
            
            cell.textLabel?.text = heroesInfo[indexPath.row].localized_name.capitalized
            return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroesViewController {
            destination.heroDetail = heroesInfo[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    }

