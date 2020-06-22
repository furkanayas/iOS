//
//  GameViewController.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 25.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        var playerShelters: Array<String> = []
        var playerTransports: Array<String> = []
        var playerCertificates: Array<String> = []
        
        let listObj: listObject = listedgameData[indexPath.row]
        
        let managedContext = appDelegate.persistentContainer.viewContext
           
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")

            do{
                let players = try managedContext.fetch(fetchRequest)
                let player = players[0] as! NSManagedObject

                let pmoney = player.value(forKey: "money") as! Int64
                let phealth = player.value(forKey: "health") as! Int16
                let phunger = player.value(forKey: "health") as! Int16
                let phappiness = player.value(forKey: "health") as! Int16
                let pday = player.value(forKey: "day") as! Int16
                
                let setmoney:Int64 = pmoney + listObj.price!
     
                var sethealth:Int16 = phealth + listObj.health!
                if(sethealth >= 100){(sethealth = 100)}
                var sethunger:Int16 = phunger + listObj.hunger!
                if(sethunger >= 100){ (sethunger = 100)}
                var sethappiness:Int16 = phappiness + listObj.happiness!
                if(sethappiness >= 100) { (sethappiness = 100)}
                var setday:Int16 = pday + 1
               
                
                 let otype = listObj.type!
                
                //sokak+kulübe+apartman
                var pshelter = player.value(forKey: "shelter") as! String
                playerShelters = pshelter.split(separator: "+").map { String($0) }
                
                var ptransport = player.value(forKey: "transport") as! String
                playerTransports = ptransport.split(separator: "+").map { String($0) }
                
                var pcertificate = player.value(forKey: "certificate") as! String
                playerCertificates = pcertificate.split(separator: "+").map { String($0) }
                
                var cetificatBlock: Bool = false
                
                if(sethealth < 0){
                    //died
                    performSegue(withIdentifier: "toEnd", sender: nil)
                }
                else if(sethunger < 0){
                    //also died
                    performSegue(withIdentifier: "toEnd", sender: nil)
                }
                else{
     
                    if(sethappiness < 0){
                    //unhappy 1 day penalty
                        setday += 2
                    }
                    
                    if(setmoney < 0){
                        //can't afford
                        
                        if(language == false) {
                            let alert = UIAlertController(title: "You can't afford", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: " Ok", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        }
                        else if(language == true) {
                            let alert = UIAlertController(title: "Paranız yetersiz", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: " Tamam", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        }

                        
                    }
                    else if(otype != 6){
                      
   
                        if(otype == 1)  { //shelter
                          

                            if(playerShelters.contains(listObj.name!))
                            {
                                fastAlert(str: "You already have " + listObj.name!)
                                 cetificatBlock = true
                            }
                            else{
                                player.setValue(setmoney, forKey: "money")
                                pshelter += "+" + listObj.name!
                                player.setValue(pshelter, forKey: "shelter")
                            }
                           
                            
                        }
                        else if(otype == 2) {//transport
                            
                            if(playerTransports.contains(listObj.name!))
                            {
                                fastAlert(str: "You already have " + listObj.name!)
                                 cetificatBlock = true
                            }
                            else{
                                player.setValue(setmoney, forKey: "money")
                                ptransport += "+" + listObj.name!
                                player.setValue(ptransport, forKey: "transport")
                            }
                            
                           
                            
                        }
                        else if(otype == 3){//certificate
                            
                            if(playerCertificates.contains(listObj.name!))
                            {
                                fastAlert(str: "You already have " + listObj.name!)
                                cetificatBlock = true
                            }
                            else{
                                
                                var isok: Bool = true
                                 //İlkokul Primary School - Ortaokul Middle School - Lise High School- Üniversite University - Ehliyet Driving License - Yabancı Dil Foreign Language - Pasaport Passport - İşletme Sertifikası MBA Certificate
                                
                                if(listObj.name! == "Ortaokul" || listObj.name! == "Middle School"){
                                    if(playerCertificates.contains("İlkokul") == false && playerCertificates.contains("Primary School") == false){
                                        language ? fastAlert(str: "İlkokul gerekli") : fastAlert(str: "You need Primary School")
                                        isok = false
                                    }
                                    
                                }
                                else if(listObj.name! == "Lise" || listObj.name! == "High School"){
                                    if(playerCertificates.contains("Ortaokul") == false && playerCertificates.contains("Middle School") == false){
                                        language ? fastAlert(str: "Ortaokul gerekli") : fastAlert(str: "You need Middle School")
                                         isok = false
                                    }
                                }
                                else if(listObj.name! == "Üniversite" || listObj.name! == "University"){
                                    if(playerCertificates.contains("Lise") == false && playerCertificates.contains("High School") == false){
                                        language ? fastAlert(str: "Lise gerekli") : fastAlert(str: "You need High School")
                                         isok = false
                                    }
                                }
                                else if(listObj.name! == "İşletme Sertifikası" || listObj.name! == "MBA Certificate"){
                                    if(playerCertificates.contains("Üniversite") == false && playerCertificates.contains("University") == false){
                                        language ? fastAlert(str: "Üniversite gerekli") : fastAlert(str: "You need University")
                                         isok = false
                                    }
                                }
                                
                                if(isok == true){
                                    player.setValue(setmoney, forKey: "money")
                                    pcertificate += "+" + listObj.name!
                                    player.setValue(pcertificate, forKey: "certificate")
                                }
  
                            }
                           
                        }

                        
                    }
                    else if(otype == 6) {//jobs can be required certificates
                        
                        let oname: String = listObj.name!
                        
                        if(oname == "Sweep Streets" || oname == "Yerleri Süpür"){
                            
                            if(playerCertificates.contains("İlkokul") == true || playerCertificates.contains("Primary School") == true){
                                 player.setValue(setmoney, forKey: "money")
                            }
                            else if(playerCertificates.contains("İlkokul") == false || playerCertificates.contains("Primary School") == false){
                                language ? fastAlert(str: "İlk Okul Diploması gerekli!") : fastAlert(str: "You need Primary School certificate!")
                                cetificatBlock = true
                            }
                        }
                        else if(oname == "Waitressing" || oname == "Garsonluk"){
                                
                                if(playerCertificates.contains("Ortaokul") == true || playerCertificates.contains("Middle School") == true){
                                     player.setValue(setmoney, forKey: "money")
                                }
                                else if(playerCertificates.contains("Ortaokul") == false || playerCertificates.contains("Middle School") == false){
                                    language ? fastAlert(str: "Orta Okul Diploması gerekli!") : fastAlert(str: "You need Middle School certificate!")
                                    cetificatBlock = true
                                }
                        }
                        else if(oname == "Packet Delivery" || oname == "Sipariş Dağıt" || oname == "Taksi Sür" || oname == "Taxi Driving"){
                            
                            if((playerCertificates.contains("Ehliyet") == true && playerCertificates.contains("Ortaokul") == true) || (playerCertificates.contains("Driving License") == true && playerCertificates.contains("Middle School") == true)){
                                  player.setValue(setmoney, forKey: "money")
                             }
                             else if((playerCertificates.contains("Ortaokul") == false && playerCertificates.contains("Ehliyet")) == false || (playerCertificates.contains("Middle School") == false && playerCertificates.contains("Driving License") == false)){
                                 language ? fastAlert(str: "Ortaokul ve Ehliyet gerekli!") : fastAlert(str: "You need Middle School & Driving License")
                                 cetificatBlock = true
                             }
                        }
                        else if(oname == "Ders Ver" || oname == "Give Lesson"){
                            if(playerCertificates.contains("Lise") == true || playerCertificates.contains("High School") == true){
                                            player.setValue(setmoney, forKey: "money")
                            }
                            else if(playerCertificates.contains("Lise") == false || playerCertificates.contains("High School") == false){
                                    language ? fastAlert(str: "Lise gerekli!") : fastAlert(str: "You need High School!")
                                        cetificatBlock = true
                                    }
                        }
                        else if(oname == "Müdür Ol" || oname == "Be a Manager"){
                                if(playerCertificates.contains("Üniversite") == true || playerCertificates.contains("University") == true){
                                          player.setValue(setmoney, forKey: "money")
                                 }
                                   else if(playerCertificates.contains("Üniversite") == false || playerCertificates.contains("University") == false){
                                           language ? fastAlert(str: "Üniversite gerekli!") : fastAlert(str: "You need University!")
                                                cetificatBlock = true
                                  }
                        }
                        else if(oname == "Yönetici Ol" || oname == "Be a Senior Manager"){
                            if((playerCertificates.contains("Yabancı Dil") == true &&  playerCertificates.contains("Üniversite") == true) || (playerCertificates.contains("Foreign Language") == true && playerCertificates.contains("University") == true)){
                                  player.setValue(setmoney, forKey: "money")
                             }
                             else if((playerCertificates.contains("Yabancı Dil") == false && playerCertificates.contains("Üniversite") == false) || (playerCertificates.contains("Foreign Language") == false && playerCertificates.contains("University") == false) ){
                                 language ? fastAlert(str: "Yabancı Dil ve Üniversite gerekli!") : fastAlert(str: "You need Foreign Language & University!")
                                 cetificatBlock = true
                             }
                        }
                        else if(oname == "Şirket İşlet" || oname == "Manage a Company"){
                        if((playerCertificates.contains("Yabancı Dil") == true &&  playerCertificates.contains("Üniversite") == true &&  playerCertificates.contains("İşletme Sertifikası") == true) || (playerCertificates.contains("Foreign Language") == true && playerCertificates.contains("University") == true && playerCertificates.contains("MBA Certificate") == true)){
                                      player.setValue(setmoney, forKey: "money")
                                }
                             else if((playerCertificates.contains("Yabancı Dil") == false && playerCertificates.contains("Üniversite") == false) || (playerCertificates.contains("Foreign Language") == false && playerCertificates.contains("University") == false)){
                                                        language ? fastAlert(str: "İşletme Sertifikası, Yabancı Dil ve Üniversite gerekli!") : fastAlert(str: "You need MBA Certificate, Foreign Language & University!")
                                                        cetificatBlock = true
                                }
                          }
                        
                        //   Yönetici Ol Be a Senior Manager - Şirket İşlet Manage a Company
                        //İlkokul Primary School - Ortaokul Middle School - Lise High School- Üniversite University - Ehliyet Driving License - Yabancı Dil Foreign Language - Pasaport Passport - İşletme Sertifikası MBA Certificate
                    }
                    
                    if(cetificatBlock == false)
                    {
                        player.setValue(sethappiness, forKey: "happiness")
                        player.setValue(sethealth, forKey: "health")
                        player.setValue(sethunger, forKey: "hunger")
                        player.setValue(setday, forKey: "day")
                       
                    }
                     
                    sendday = pday
                 
                }
     
                 
                do {
                    try managedContext.save()

                    print("player güncellendi")
                }
                catch{
                    print("there is a error")
                }
                 
            }
            catch{
                print("problem")
            }
        
            
              
            printPlayer()
       

        }
    
    
    func fastAlert(str:String){
        
        if(language == false) {
                    let alert = UIAlertController(title: str, message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: " Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
                else if(language == true) {
                    let alert = UIAlertController(title: str, message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: " Tamam", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        let _:Int = listSize
        
        return listSize
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath as IndexPath) as! ListTableViewCell
        
        let obj: listObject = listedgameData[indexPath.row]
        
        cell.labelName.text = obj.name!
        cell.labelHealth.text = String(obj.health!)
        cell.labelHunger.text = String(obj.hunger!)
        cell.labelHappiness.text = String(obj.happiness!)
        cell.labelPrice.text = String(obj.price!)

        return cell
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
       
       
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedgroup = 1
            language ? ( labelSection.text = "Ev") : ( labelSection.text = "Home")
        case 1:
            selectedgroup = 2
             language ? ( labelSection.text = "Taşıt") : ( labelSection.text = "Transport")
        case 2:
            selectedgroup = 3
             language ? ( labelSection.text = "Diploma") : ( labelSection.text = "License")
        case 3:
            selectedgroup = 4
             language ? ( labelSection.text = "Yemek") : ( labelSection.text = "Food")
        case 4:
            selectedgroup = 5
             language ? ( labelSection.text = "Sağlık") : ( labelSection.text = "Health")
        case 5:
            selectedgroup = 6
             language ? ( labelSection.text = "İş") : ( labelSection.text = "Job")
        default:
            break
        }
        
        reloadList()
    }
    
    func reloadList() {
        var size: Int = 0
        listedgameData.removeAll()
        for k in 0...(listArr.count - 1){
               
            if(listArr[k].type == Int16(selectedgroup))
            {
                listedgameData.append(listArr[k])
                size = size + 1
            }
        }

        listSize = size
        theTable.reloadData()
    }
    
    var selectedgroup = 1
    var listSize:Int = 0
    var listedgameData: Array<listObject> = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var receiveuserName: String!
     
    var language: Bool!
    var listArr: Array<listObject> = []
  

    var sendday: Int16 = 0
    
    @IBOutlet weak var barHealth: UIProgressView!
    @IBOutlet weak var barHunger: UIProgressView!
    @IBOutlet weak var barHappiness: UIProgressView!
    @IBOutlet weak var labelSection: UILabel!
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelMoney: UILabel!

    @IBOutlet weak var labelHealth: UILabel!
    @IBOutlet weak var labelHunger: UILabel!
    @IBOutlet weak var labelHappiness: UILabel!
    
    // let player = players[0] as! NSManagedObject <- Player's Core Data Object
    
    @IBOutlet weak var buttonPlayerjunk: UIButton!
    
    @IBOutlet weak var labelHealthjunk: UILabel!
    
    @IBOutlet weak var labelHungerjunk: UILabel!
    @IBOutlet weak var labelHappinessjunk: UILabel!
    @IBOutlet weak var labelMoneyjunk: UILabel!
    
    @IBOutlet weak var labelDayjunk: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    
    @IBOutlet weak var labelNamejunk: UILabel!
    
    
    
    @IBAction func buttonPlayerAction(_ sender: Any) {
         performSegue(withIdentifier: "toPlayer", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonPlayerjunk.layer.borderWidth = 2
        buttonPlayerjunk.layer.borderColor = UIColor.systemBlue.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homeless.jpg")!)
           
        languagePackage(lang: language)
  
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")

        do{
            let players = try managedContext.fetch(fetchRequest)
                       
            if(players.count > 0)
            {
                let player = players[0] as! NSManagedObject
                let pname = player.value(forKey: "username") as! String
                if(pname == receiveuserName)
                {
                    print("Player bulundu")
                }
      
            }
            else if(players.count == 0)
            {
                print("player yok")
                loadfirstPlayer(username: receiveuserName)
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

  
        printPlayer()
        reloadList()
    }
    
    
    func printPlayer()
    {
     
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")

        do{
            let players = try managedContext.fetch(fetchRequest)
            let player = players[0] as! NSManagedObject

            labelName.text = player.value(forKey: "username") as? String
            labelMoney.text = String(player.value(forKey: "money") as! Int64)
            labelHealth.text = String(player.value(forKey: "health") as! Int16)
            labelHunger.text = String(player.value(forKey: "hunger") as! Int16)
            labelHappiness.text = String(player.value(forKey: "happiness") as! Int16)
            labelDay.text = String(player.value(forKey: "day") as! Int16)
            barHealth.progress = Float(player.value(forKey: "health") as! Int16) / 100
            barHunger.progress = Float(player.value(forKey: "hunger") as! Int16) / 100
            barHappiness.progress = Float(player.value(forKey: "happiness") as! Int16) / 100
            
        }catch{ print("problem") }
       
    }
    
    func loadfirstPlayer(username: String) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let Entity = NSEntityDescription.entity(forEntityName: "PlayerEntity", in: managedContext)
      //  let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")
               
        let newPlayer = PlayerEntityCore(entity: Entity!, insertInto: managedContext)
        
        newPlayer.username = username
        newPlayer.money = 100
        newPlayer.happiness = 100
        newPlayer.health = 100
        newPlayer.hunger = 100
        newPlayer.certificate = "None"
        newPlayer.shelter = "Street"
        newPlayer.transport = "Feet"
        newPlayer.day = 1
        newPlayer.language = language
        //newPlayer.transport?.append("feet")
        
        
        do {
            try managedContext.save()
            print("player kaydedildi")
            }
        catch{
            print("there is a error")
            }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
        
    
        if(segue.identifier == "toEnd"){
            let destination: DeadViewController = segue.destination as! DeadViewController
            destination.deletingusername = receiveuserName
            destination.languag = language
            destination.day = sendday
        }
        if(segue.identifier == "toPlayer"){
            let destination: PlayerViewController = segue.destination as! PlayerViewController
            destination.thelang = language
        }
        
    }
    
    
    func languagePackage(lang: Bool)
    {
        
        if(lang == false)
        {
            listArr = appDelegate.listArrADEng
            labelSection.text = "Home"
            labelNamejunk.text = "Name"
            labelHealthjunk.text = "Health"
            labelHungerjunk.text = "Hunger"
            labelHappinessjunk.text = "Happiness"
            labelMoneyjunk.text = "Money"
            labelDayjunk.text = "Days"
            buttonPlayerjunk.setTitle("Player", for: .normal)
            
            segmentedControl.setTitle("Home", forSegmentAt: 0)
            segmentedControl.setTitle("Transport", forSegmentAt: 1)
            segmentedControl.setTitle("License", forSegmentAt: 2)
            segmentedControl.setTitle("Food", forSegmentAt: 3)
            segmentedControl.setTitle("Health", forSegmentAt: 4)
            segmentedControl.setTitle("Job", forSegmentAt: 5)
        }
        else if(lang == true)
        {
            
            listArr = appDelegate.listArrADTr
             labelSection.text = "Ev"
            labelNamejunk.text = "Kullanıcı"
            labelHealthjunk.text = "Sağlık"
            labelHungerjunk.text = "Açlık"
            labelHappinessjunk.text = "Mutluluk"
            labelMoneyjunk.text = "Para"
            labelDayjunk.text = "Gün"
            buttonPlayerjunk.setTitle("Oyuncu", for: .normal)
            
            segmentedControl.setTitle("Ev", forSegmentAt: 0)
            segmentedControl.setTitle("Taşıt", forSegmentAt: 1)
            segmentedControl.setTitle("Diploma", forSegmentAt: 2)
            segmentedControl.setTitle("Yemek", forSegmentAt: 3)
            segmentedControl.setTitle("Sağlık", forSegmentAt: 4)
            segmentedControl.setTitle("İş", forSegmentAt: 5)
            
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
