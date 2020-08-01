//
//  ExerciseMenuViewController.swift
//  C10219-SporTrack
//
//  Created by Tom Cohen on 13/06/2020.
//  Copyright © 2020 com.Tomco.iOs. All rights reserved.
//


import UIKit

class ExerciseMenuViewController: UIViewController {
    
    
    @IBOutlet weak var exerciseMenuCV: UICollectionView!
    var selectedCategoryIndex:IndexPath?
    var selectedExerciseIndex:IndexPath?
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].title) \(K.Titles.ExercisesScreenTitle)"
        exerciseMenuCV.dataSource = self
        exerciseMenuCV.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ExerciseTimerViewController
        vc.selectedCategoryIndex = self.selectedCategoryIndex
        vc.selectedExerciseIndex = self.selectedExerciseIndex
    }
}

//MARK: - CollectionView Protocols
extension ExerciseMenuViewController :  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exerciseMenuCV.dequeueReusableCell(withReuseIdentifier: K.exerciseMenuCell, for: indexPath) as! ExerciseCollectionViewCell
        cell.imageView.image = UIImage(named: K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![indexPath.row].imageName)
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/15
        cell.imageView.clipsToBounds = true
        cell.title.text = "\(K.ExerciseCategoryMenuItems[selectedCategoryIndex!.row].exercises![indexPath.row].title)"
        return cell
    }
}

extension ExerciseMenuViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedExerciseIndex = indexPath
        performSegue(withIdentifier: K.Segues.exerciseMenuToTimerSegue, sender: self)
    }
}

