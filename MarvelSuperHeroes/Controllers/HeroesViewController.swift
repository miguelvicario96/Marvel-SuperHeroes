//
//  ViewController.swift
//  MarvelSuperHeroes
//
//  Created by Miguel Vicario on 11/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import Kingfisher

//MARK: - HeroesViewController
public class HeroesViewController: UIViewController {

    //MARK: - Instance Properties
    private let service = SHService.shared
    private let estimatedWidth = 160.0
    private let cellMarginSize = 5.0
    public var superheroesArray: [Superhero] = []
    
    //MARK: - View
    public var heroesView: HeroesView! {
        guard isViewLoaded else { return nil }
        return (view as! HeroesView)
    }
    
    //MARK: - Object Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        fetchSuperheroes()
        setUpGridView()
    }
    
    //MARK: - Methods
    public func setUpGridView() {
        let flow = heroesView.heroesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(cellMarginSize)
        flow.minimumLineSpacing = CGFloat(cellMarginSize)
    }
    
    public func fetchSuperheroes() {
        service.serviceCall { (data, error) in
            let parseResult = self.service.parsingResult(Superheroes.self, data: data, error: error)
            switch parseResult {
            case let .success(superheros):
                self.superheroesArray = superheros.superheroes
                self.heroesView.heroesCollectionView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
}

//MARK: - UICollectionViewDataSource()
extension HeroesViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superheroesArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCell", for: indexPath) as! HeroesCollectionViewCell

        //Hero Photo
        let imageURL = URL(string: superheroesArray[indexPath.row].photo)
        heroesCell.heroImage.kf.indicatorType = .activity
        heroesCell.heroImage.kf.setImage(with: imageURL)
        
        return heroesCell
    }
}

//MARK: - UICollectionViewDelegate()
extension HeroesViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        vc.selectedSuperhero = superheroesArray[indexPath.row]
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout()
extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        let height = collectionView.frame.size.height / 3
        return CGSize(width: width, height: height)
    }
    
    func calculateWidth() -> CGFloat {
        let estimateWidth = CGFloat(estimatedWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimateWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}

extension HeroesViewController: DetailViewDelegate {
    
    public func didFinish(_ vc: DetailViewController) {
        self.navigationController?.popViewController(animated: true)
    }
}
