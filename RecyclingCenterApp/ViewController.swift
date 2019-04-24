//
//  ViewController.swift
//  RecyclingCenterApp
//
//  Created by Usuario invitado on 4/22/19.
//  Copyright © 2019 Diana Manzano. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var refRecyclingCenter = DatabaseReference.init()
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldType: UITextField!
    @IBOutlet weak var txtFieldUbication: UITextField!
    @IBOutlet weak var txtFieldPhone: UITextField!
    @IBOutlet weak var txtFieldManagment: UITextField!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    
    @IBOutlet weak var tvcRecyclingCenter: UITableView!
    var recyclingCentersList = [RecyclingCenterModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recyclingCenter = recyclingCentersList[indexPath.row]
        
        let alertController = UIAlertController(title: recyclingCenter.name, message: "Give new values to update", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = recyclingCenter.id
            let name = alertController.textFields?[0].text
            let ubication = alertController.textFields?[1].text
            let type = alertController.textFields?[2].text
            let phone = alertController.textFields?[3].text
            let managment = alertController.textFields?[4].text

            
            self.updateRecyclingCenter(id: id!, name: name!, ubication: ubication!, type: type!, phone: phone!, managment: managment!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteRecyclingCenter(id: recyclingCenter.id!)
        }
        alertController.addTextField{(textField)in
            textField.text = recyclingCenter.name
        }
        alertController.addTextField{(textField)in
            textField.text = recyclingCenter.ubication
        }
        alertController.addTextField{(textField)in
            textField.text = recyclingCenter.type
        }
        alertController.addTextField{(textField)in
            textField.text = recyclingCenter.phone
        }
        alertController.addTextField{(textField)in
            textField.text = recyclingCenter.managment
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteRecyclingCenter(id: String){
        refRecyclingCenter.child(id).setValue(nil)
    }
    
    func updateRecyclingCenter(id : String, name: String, ubication: String, type: String, phone : String, managment : String){
        let recyclingCenter = [
            "id" : id,
            "name" : name,
            "ubication" : ubication,
            "type" : type,
            "phone" : phone,
            "managment" : managment
        ]
        refRecyclingCenter.child(id).setValue(recyclingCenter)
        lblMessage.text = "Recycling Center Update"
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recyclingCentersList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRecyclingCenter = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let recyclingCenter: RecyclingCenterModel
        recyclingCenter = recyclingCentersList[indexPath.row]
        cellRecyclingCenter.lblName.text = recyclingCenter.name
        return cellRecyclingCenter
    }
    
    @IBAction func btnAddRecyclingCenter(_ sender: UIButton) {
        addRecyclingCenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refRecyclingCenter = Database.database().reference().child("recyclingCenter")
        
        
        refRecyclingCenter.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.recyclingCentersList.removeAll()
                for recyclingCenters in snapshot.children.allObjects as![DataSnapshot]{
                    let recyclingCenterObject = recyclingCenters.value as? [String:  AnyObject]
                    let recyclingCenterName = recyclingCenterObject? ["name"]
                    let recyclingCenterUbication = recyclingCenterObject? ["ubication"]
                    let recyclingCenterType = recyclingCenterObject? ["type"]
                    let recyclingCenterPhone = recyclingCenterObject? ["phone"]
                    let recyclingCenterManagment = recyclingCenterObject? ["managment"]
                    let recyclingCenterId = recyclingCenterObject? ["id"]
                    
                    let recyclingCenter = RecyclingCenterModel(id: recyclingCenterId as! String?, name: recyclingCenterName as! String?, ubication: recyclingCenterUbication as! String?, type: recyclingCenterType as! String?, phone: recyclingCenterPhone as! String?, managment: recyclingCenterManagment as! String?)
                    self.recyclingCentersList.append(recyclingCenter)
                }
                self.tvcRecyclingCenter?.reloadData()
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addRecyclingCenter(){
        let key = refRecyclingCenter.childByAutoId().key
        let recyclingCenter = ["id":key,
                      "name": txtFieldName.text! as String,
                      "ubication": txtFieldUbication.text! as String,
                      "type": txtFieldType.text! as String,
                      "phone": txtFieldPhone.text! as String,
                      "managment": txtFieldManagment.text! as String
                        ]
        refRecyclingCenter.child(key!).setValue(recyclingCenter)
        lblMessage.text = "Recycling Center Added"
        txtFieldName.text = ""
        txtFieldUbication.text = ""
        txtFieldType.text = ""
        txtFieldPhone.text = ""
        txtFieldManagment.text = ""
    }


}

