//
//  CommitsViewController.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 28/11/22.
//

import UIKit

class CommitsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var commits = [CommitsModels.Commit]()
    let interactor = CommitsInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.register(.init(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: "CommitTableViewCell")
        interactor.delegate = self
        tableView.dataSource = self
        interactor.getCommits()
    }
}

extension CommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitTableViewCell", for: indexPath) as! CommitTableViewCell
        cell.setup(commits[indexPath.item].commit)
        return cell
    }
}

extension CommitsViewController: CommitsInteractorDelegate {
    func reloadList(_ commits: [CommitsModels.Commit]) {
        self.commits = commits
        tableView.reloadData()
    }
}
