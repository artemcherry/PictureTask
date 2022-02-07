//
//  PictureViewController.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 02.02.2022.
//

import UIKit
import RealmSwift

final class PictureViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var pictures = [PictureModel]()
    private let cell = PictureCell()
    private var dataService = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        getMultiplePicutres()

        
    }
    
    private func collectionViewSetup() {
        let nibFile = UINib(nibName: "PictureCell", bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func addToFavourite(cell: UICollectionViewCell) {
        guard let index = collectionView.indexPath(for: cell) else { return }
        dataService.addToFavourite(model: pictures[index.row])
    }
    

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 1 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.pictures = self.dataService.loadPictures()
                self.collectionView.reloadData()
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.pictures = []
                self.getMultiplePicutres()
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - DataSource
extension PictureViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? PictureCell else { return UICollectionViewCell() }
        cell.viewLink = self
        cell.setupView(pictureInfo: pictures[indexPath.row])
        return cell
    }
}

//MARK: - FlowLayout
extension PictureViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 2
        let paddingWidth = 3 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 4
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 4
    }
}

//MARK: - Networking
extension PictureViewController {
    
    private func getMultiplePicutres() {
        for _ in 0...9 {
        self.getPicture()
    }
    }
    
    private func getPicture() {
        guard segmentControl.selectedSegmentIndex == 0 else { return }
        dataService.getPictures { pictures, error in
            if let pictures = pictures {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.pictures.append(contentsOf: pictures)
                    self.collectionView.reloadData()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Delegate/Pagination
extension PictureViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard segmentControl.selectedSegmentIndex == 0 else { return }
        if(scrollView.contentOffset.y >= (collectionView.contentSize.height - scrollView.frame.size.height )) {
            getMultiplePicutres()
        }
    }
}

