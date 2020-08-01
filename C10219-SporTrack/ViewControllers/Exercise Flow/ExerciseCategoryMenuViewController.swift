//
//  ExerciseCategoryMenuViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit

class ExerciseCategoryMenuViewController: UIViewController {
    
    //MARK: - Members
    @IBOutlet weak var exerciseCategoryCV: UICollectionView!
    var selectedIndex:IndexPath?
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let i = (navigationController?.viewControllers.count)!
        let previousViewController = navigationController?.viewControllers[i-1]
        previousViewController?.navigationItem.title = K.Titles.CategoryScreenTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseCategoryCV.dataSource = self
        exerciseCategoryCV.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ExerciseMenuViewController
        vc.selectedCategoryIndex = self.selectedIndex
    }
}

//MARK: - CollectionView Protocols
extension ExerciseCategoryMenuViewController :  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        K.ExerciseCategoryMenuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseCategoryCV.dequeueReusableCell(withReuseIdentifier: K.exerciseCategoryMennuCell, for: indexPath) as!        ExerciseCategoryCollectionViewCell
        cell.imageView.image = UIImage(named: K.ExerciseCategoryMenuItems[indexPath.row].imageName)
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/15
        cell.imageView.clipsToBounds = true
        cell.title.text = "\(K.ExerciseCategoryMenuItems[indexPath.row].title)"
        return cell
    }
}

extension ExerciseCategoryMenuViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        performSegue(withIdentifier: K.Segues.exerciseCategoryToExerciseMenuSegue, sender: self)
    }
}

