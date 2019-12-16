//
//  DetailViewController.swift
//  MarvelSuperHeroes
//
//  Created by Miguel Vicario on 11/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

//MARK: - DetailViewDelegate
public protocol DetailViewDelegate: class {
    func didFinish(_ vc: DetailViewController)
}

//MARK: - DetailViewController
public class DetailViewController: UIViewController {
    
    //MARK: - Instance Properties
    private let menuOptions: [String] = ["Real Name", "Height", "Power", "Abilities", "Groups"]
    public var selectedSuperhero: Superhero!
    public weak var delegate: DetailViewDelegate?
    private var animation: Animation!
    private var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            selectedIndexPathDidChange(selectedIndexPath)
        }
    }
    
    //MARK: - View
    public var detailView: DetailView! {
        guard isViewLoaded else { return nil }
        return (view as! DetailView)
    }
    
    //MARK: - Object Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.heroNameLabel.text = selectedSuperhero.name
        detailView.descriptionLabel.text = selectedSuperhero.realName
    }
    
    //MARK: - Actions
    @IBAction public func goBackAction(_ sender: Any) {
        delegate?.didFinish(self)
    }
    
    //MARK: - Methods
    private func selectedIndexPathDidChange(_ indexPath: IndexPath) {
        let descriLabel: UILabel = detailView.descriptionLabel
        var color: UIColor!
        
        switch indexPath.row {
        case 0:
            animation = Animation(label: descriLabel,
                                  text: selectedSuperhero.realName)
            color = UIColor(named: "Light-Blue")
        case 1:
            animation = Animation(label: descriLabel,
                                  text: selectedSuperhero.height)
            color = UIColor(named: "Light-Yellow")
        case 2:
            animation = Animation(label: descriLabel,
                                  text: selectedSuperhero.power)
            color = UIColor(named: "Dark-Yellow")
        case 3:
            animation = Animation(label: descriLabel,
                                  text: selectedSuperhero.abilities)
            color = UIColor(named: "Light-Orange")
        case 4:
            animation = Animation(label: descriLabel,
                                  text: selectedSuperhero.groups)
            color = UIColor(named: "Pink")
        default:
            break
        }
        
        self.view.backgroundColor = color
        animation.animation()
    }
}

//MARK: - UICollectionViewDataSource()
extension DetailViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMenuCell",
                                                      for: indexPath) as! DetailMenuCollectionViewCell
        
        if indexPath == selectedIndexPath {
            cell.titleLabel.textColor = UIColor.black
            cell.lineView.isHidden = false
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        } else {
            cell.titleLabel.textColor = UIColor(named: "Light-Gray")
            cell.lineView.isHidden = true
        }
        
        cell.titleLabel.text = menuOptions[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDataSource()
extension DetailViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DetailMenuCollectionViewCell
        
        cell.titleLabel.textColor = UIColor.black
        cell.lineView.isHidden = false
        selectedIndexPath = indexPath
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DetailMenuCollectionViewCell
        
        cell.titleLabel.textColor = UIColor(named: "Light-Gray")
        cell.lineView.isHidden = true
    }
}
