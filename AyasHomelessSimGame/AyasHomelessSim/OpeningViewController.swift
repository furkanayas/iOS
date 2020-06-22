//
//  OpeningViewController.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 25.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class OpeningViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var textAreaUsername: UITextField!
    
    @IBAction func buttonPlay(_ sender: Any) {

        
        if(senduserName != "nil")
        {
            performSegue(withIdentifier: "toMain", sender: nil)
        }
        else if(senduserName == "nil")
        {
        
            if(textAreaUsername.text?.isEmpty == true)
            {
                senduserName = "Homeless"
            }
            else
            {
                senduserName = textAreaUsername.text!
            }
           
            performSegue(withIdentifier: "toMain", sender: nil)
        }
        
        
    }
    
 
          
    
    @IBOutlet weak var buttonPlayjunk: UIButton!
          
    @IBOutlet weak var segmentedControl: UISegmentedControl!
            
    @IBOutlet weak var labelTitlejunk: UILabel!
    
    @IBOutlet weak var labeljunk: UILabel!
    
    
    @IBOutlet weak var labelTips: UILabel!
    
    @IBOutlet weak var buttonDeleteJunk: UIButton!
    
    @IBAction func indexChanged(_ sender: Any) {
             switch segmentedControl.selectedSegmentIndex {
             case 0:
                 theLanguage = false //english
                 printEngorTR()

             case 1:
                 theLanguage = true //turkish
                 printEngorTR()

             default:
                 break
             }
             
         }
    
    
    func printEngorTR() {
        
        if(theLanguage == false)  {
            buttonPlayjunk.setTitle("Play", for: .normal)
            buttonDeleteJunk.setTitle("Delete Player", for: .normal)
            labelTitlejunk.text = "Ayas Homeless Simulator"
            labeljunk.text = "Please Enter Username"
            
            labelTips.text = "Tips!\nUnhappy actions cost 2 penalty days!\nIf you died with last action, without clicking new game and opening game again, you can take back your last step!"
            
            segmentedControl.selectedSegmentIndex = 0
            
        }
        else if(theLanguage == true){
             buttonPlayjunk.setTitle("Oyna", for: .normal)
            buttonDeleteJunk.setTitle("Oyuncuyu Sil", for: .normal)
            labelTitlejunk.text = "Ayas Evsiz Simülatörü"
            labeljunk.text = "Oyuncu Adı Giriniz"
            
             labelTips.text = "İpucu!\nMutsuz aksiyonların 2 gün cezası vardır!\nEğer yanlışlıkla öldüyseniz yeni oyuna tıklamadan oyunu kapatıp tekrar açarsanız son hareketinizi geri alabilirsiniz!"
            
            segmentedControl.selectedSegmentIndex = 1
        }
        
    }
    
    
    @IBAction func buttonReset(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")
            
        fetchRequest.predicate = NSPredicate(format: "username = %@", senduserName)
          
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

        
          textAreaUsername.isEnabled = true
          labelUsername.isHidden = false
          senduserName = "nil"
        
    }
    
    var senduserName: String = "nil"
    var theLanguage:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homeless.jpg")!)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
        let managedContext = appDelegate.persistentContainer.viewContext
                
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")
        
        do{
          let players = try managedContext.fetch(fetchRequest)
          if(players.count > 0)
          {
              print("Oyuncu var")
              print(players.count)
             // savedUser = true
              let player = players[0] as! NSManagedObject
              senduserName = player.value(forKey: "username") as! String
            
               theLanguage = player.value(forKey: "language") as! Bool
              printEngorTR()
          }
          
        }
        catch{
            print("problem")
        }
        
        
        if(senduserName != "nil")
        {
            textAreaUsername.text = senduserName
            textAreaUsername.isEnabled = false
            labelUsername.isHidden = true
        }
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if(segue.identifier == "toMain"){
                let destination: GameViewController = segue.destination as! GameViewController
            destination.receiveuserName = senduserName
            destination.language = theLanguage
           }
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
