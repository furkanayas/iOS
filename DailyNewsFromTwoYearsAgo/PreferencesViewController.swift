//
//  PreferencesViewController.swift
//  AyasNewsPaperFinal
//
//  Created by furkanayas on 28.04.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class PreferencesViewController: UIViewController {

    var situationspreferences: Array<Bool> = []
     
    @IBOutlet weak var AksamSwitch: UISwitch!
    @IBOutlet weak var HaberturkSwitch: UISwitch!
    @IBOutlet weak var HurriyetSwitch: UISwitch!
    @IBOutlet weak var MilliyetSwitch: UISwitch!
    @IBOutlet weak var PostaSwitch: UISwitch!
    @IBOutlet weak var SabahSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //let x = situationspreferences[0] ? true:false
        //Set against to data
        
        
        situationspreferences[0] ? (AksamSwitch.setOn(true, animated: true)) : (AksamSwitch.setOn(false, animated: true))
        situationspreferences[1] ? (HaberturkSwitch.setOn(true, animated: true)) : (HaberturkSwitch.setOn(false, animated: true))
        situationspreferences[2] ? (HurriyetSwitch.setOn(true, animated: true)) : (HurriyetSwitch.setOn(false, animated: true))
        situationspreferences[3] ? (MilliyetSwitch.setOn(true, animated: true)) : (MilliyetSwitch.setOn(false, animated: true))
        situationspreferences[4] ? (PostaSwitch.setOn(true, animated: true)) : (PostaSwitch.setOn(false, animated: true))
        situationspreferences[5] ? (SabahSwitch.setOn(true, animated: true)) : (SabahSwitch.setOn(false, animated: true))
       }

    
    func updateSituations() {
        situationspreferences.removeAll()
                     
        AksamSwitch.isOn ? (situationspreferences.append(true)) : (situationspreferences.append(false))
        HaberturkSwitch.isOn ? (situationspreferences.append(true)) : (situationspreferences.append(false))
        HurriyetSwitch.isOn ? (situationspreferences.append(true)) : (situationspreferences.append(false))
        MilliyetSwitch.isOn ? (situationspreferences.append(true)) : (situationspreferences.append(false))
        PostaSwitch.isOn ? (situationspreferences.append(true)) : (situationspreferences.append(false))
        SabahSwitch.isOn ? (situationspreferences.append(true)) : (situationspreferences.append(false))
    }
    
    @IBAction func savebutton(_ sender: Any) {
        //Update isactive values with new situation array
        updateSituations()
        
        let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = api.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
               
               if(situationspreferences.isEmpty != true){
               var k = 0
               do {
                   let result = try context.fetch(request)
                   for data in result as! [NSManagedObject] {
                       data.setValue(situationspreferences[k], forKey: "isactive")
                       k+=1
                       }
                       try context.save()
                
                
                let alert = UIAlertController(title: "Info", message: "News are saved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))

                self.present(alert, animated: true)
                   }
               catch {
                
                let alert = UIAlertController(title: "Info", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))

                self.present(alert, animated: true)
                
                print("Failed") }
               }
               else{print("Problem accuired")}
         //navigationController?.popToRootViewController(animated: true)
                // performSegue(withIdentifier: "backtoMain", sender: nil)
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
