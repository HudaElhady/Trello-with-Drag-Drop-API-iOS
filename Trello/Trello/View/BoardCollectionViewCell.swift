//
//  BoardCollectionViewCell.swift
//  Trello
//
//  Created by huda elhady on 1/24/19.
//  Copyright © 2019 huda.elhady. All rights reserved.
//

import UIKit
class BoardCollectionViewCell: UICollectionViewCell {
      
      @IBOutlet weak var tableview: UITableView!
      var board: Board?
      weak var boardVC: BoardCollectionViewController?
      override func awakeFromNib() {
            super.awakeFromNib()
            self.layer.cornerRadius = 10
            tableview.dataSource = self
            tableview.delegate = self
      }
      
      func setup(board: Board) {
            self.board = board
            self.tableview.reloadData()
      }
      
      @IBAction func addButtonAction(_ sender: UIButton) {
            let alertController = UIAlertController(title: "Add item", message: "", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: nil)
            alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
                  guard let text = alertController.textFields?.first?.text, !text.isEmpty else{
                        return
                  }
                  guard let data = self.board
                        else { return}
                  data.items.append(text)
                  let indexPath = IndexPath(row: data.items.count - 1, section: 0)
                  
                  self.tableview.insertRows(at: [indexPath], with: .automatic)
                  self.tableview.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            boardVC?.present(alertController, animated: true, completion: nil)
      }
}

extension BoardCollectionViewCell: UITableViewDelegate,UITableViewDataSource
{
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return board?.items.count ?? 0
      }
      func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return board?.title
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = board?.items[indexPath.row]
            return cell
            
      }
}
