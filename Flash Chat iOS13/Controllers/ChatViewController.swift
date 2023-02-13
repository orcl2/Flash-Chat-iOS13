//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var logOutBarButtonItem: UIBarButtonItem!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }
    
    private func configUI() {
        title = K.appName
        navigationItem.hidesBackButton = true
        
        configTableView()
        loadData()
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibCell = UINib(nibName: K.cellNibName, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: K.cellIdentifier)
    }
    
    private func loadData() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { [weak self] querySnapshot, error in
                
                if let error = error {
                    print("Error when tried to retrieve data, \(error.localizedDescription)")
                } else {
                    self?.messages = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        
                        if let sender = data[K.FStore.senderField] as? String,
                           let body = data[K.FStore.bodyField] as? String {
                            let message = Message(sender: sender, body: body)
                            self?.messages.append(message)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        guard let body = messageTextfield.text else {
            return
        }
        
        guard let sender = Auth.auth().currentUser?.email else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: sender,
            K.FStore.bodyField: body,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { error in
            if let error = error {
                print("Error adding document, \(error)")
            } else {
                print("Document added")
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError {
            showAlert(message: signOutError.localizedDescription)
        }
    }

}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        
        cell.label.text = messages[indexPath.row].body
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
 
}
