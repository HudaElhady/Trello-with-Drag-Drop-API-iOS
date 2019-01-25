//
//  BoardCollectionViewController.swift
//  Trello
//
//  Created by huda elhady on 1/24/19.
//  Copyright © 2019 huda.elhady. All rights reserved.
//

import UIKit
class BoardCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
      var boards = [
            Board(title: "Todo", items: ["Database Migration", "Schema Design", "Storage Management", "Model Abstraction"]),
            Board(title: "In Progress", items: ["Push Notification", "Analytics", "Machine Learning"]),
            Board(title: "Done", items: ["System Architecture", "Alert & Debugging"])
      ]
      override func viewDidLoad() {
            super.viewDidLoad()
            setupAddButtonItem()
            updateCollectionViewItem(with: view.bounds.size)
      }
      
      private func updateCollectionViewItem(with size: CGSize) {
            guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                  return
            }
            layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
      }
      
      override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            updateCollectionViewItem(with: size)
      }
      
      func setupAddButtonItem()  {
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBoard))
            navigationItem.rightBarButtonItem = addButton
            
      }
      @objc func addBoard()  {
            let alertController = UIAlertController(title: "Add List", message: nil, preferredStyle: .alert)
            alertController.addTextField(configurationHandler: nil)
            alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
                  guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                        return
                  }
                  
                  self.boards.append(Board(title: text, items: []))
                  
                  let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
                  
                  self.collectionView.insertItems(at: [addedIndexPath])
                  self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true)
      }
      override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return boards.count
      }
      
      override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
            
            cell.setup(board: boards[indexPath.item])
            return cell
      }
}
