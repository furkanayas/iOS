//
//  PlayerViewController.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 26.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class PlayerViewController: UIViewController {

        
    @IBOutlet weak var labelName: UILabel!

    @IBOutlet weak var labelDays: UILabel!
    @IBOutlet weak var labelHouse: UILabel!
    
    @IBOutlet weak var labelTransport: UILabel!
    
    @IBOutlet weak var labelEducation: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var labelNamejunk: UILabel!
    @IBOutlet weak var labelDaysjunk: UILabel!
    @IBOutlet weak var labelHousejunk: UILabel!
    @IBOutlet weak var labelTransportjunk: UILabel!
    @IBOutlet weak var labelEducationjunk: UILabel!
    
    
    var thelang: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(thelang == false)
        {
            labelNamejunk.text = "Name"
            labelDaysjunk.text = "Days"
            labelHousejunk.text = "Home"
            labelTransportjunk.text = "Transport"
            labelEducationjunk.text = "Education"
            
        }
        else if (thelang == true)
        {
            labelNamejunk.text = "Evsiz Adı"
            labelDaysjunk.text = "Gün"
            labelHousejunk.text = "Ev"
            labelTransportjunk.text = "Taşıt"
            labelEducationjunk.text = "Eğitim"
        }
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homeless.jpg")!)
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")

        var playerShelters: Array<String> = []
        var playerTransports: Array<String> = []
        var playerCertificates: Array<String> = []
        
        do{
            let players = try managedContext.fetch(fetchRequest)
                         
            if(players.count > 0)
            {
                let player = players[0] as! NSManagedObject
                labelName.text = player.value(forKey: "username") as? String
                let daynum:Int16 = player.value(forKey: "day") as! Int16
                labelDays.text =  String(daynum) + " days"
                
                let pshelter = player.value(forKey: "shelter") as! String
                playerShelters = pshelter.split(separator: "+").map { String($0) }
                             
                let ptransport = player.value(forKey: "transport") as! String
                playerTransports = ptransport.split(separator: "+").map { String($0) }
                             
                let pcertificate = player.value(forKey: "certificate") as! String
                playerCertificates = pcertificate.split(separator: "+").map { String($0) }
       
                
                labelHouse.text = playerShelters.last
                labelEducation.text = playerCertificates.last
                labelTransport.text = playerTransports.last
        
            }
            else if(players.count == 0)
            {
                print("player yok")
            }
            else
            {
                print("0 değil 0 dan büyük degil")
                 // loadfirstPlayer(username: receiveuserName)
            }
          
        }
        catch{
            print("problem")
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
