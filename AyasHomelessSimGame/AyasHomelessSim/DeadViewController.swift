//
//  DeadViewController.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 26.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class DeadViewController: UIViewController {

    @IBOutlet weak var labelDead: UILabel!
    
    var deletingusername: String!
    
    var languag:Bool = false
    var day:Int16 = 0
    
    @IBOutlet weak var labelDays: UILabel!
    
    
    @IBOutlet weak var labelDaysJunk: UILabel!
    
    @IBAction func buttonAgain(_ sender: Any) {
            
        deletePlayer()
        performSegue(withIdentifier: "toStart", sender: nil)
        
    }
    
    
    @IBOutlet weak var buttonAgainoutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(languag == false)
        {
            labelDaysJunk.text = "You Survived"
            labelDead.text = "You Died!\n" + deletingusername
            buttonAgainoutlet.setTitle("New Game", for: .normal)
        }
        else if(languag == true)
        {
            labelDaysJunk.text = "Yaşam Süren"
            labelDead.text = "Öldün!\n" + deletingusername
            buttonAgainoutlet.setTitle("Yeni Oyun", for: .normal)
        }
        
        labelDays.text = String(day)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homeless.jpg")!)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func deletePlayer() {
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let managedContext = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")
               /*
           fetchRequest.predicate = NSPredicate(format: "username = %@", deletingusername)*/
             
             do{
                 let players = try managedContext.fetch(fetchRequest)
                 
                 if(players.count > 0){
                     let objectToDelete = players[0] as! NSManagedObject
                     managedContext.delete(objectToDelete)
                     do{
                         try managedContext.save()
                     }
                     catch{
                         print("silemedi")
                     }
                 }

                 }
                 catch{
                 print("problem")
                 }

   
           
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
        
        if(segue.identifier == "toStart"){
            let destination: OpeningViewController = segue.destination as! OpeningViewController
           // destination.deletingusername = receiveuserName
        }
        
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  
    */

}
