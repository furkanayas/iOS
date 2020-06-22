//
//  MainTableViewController.swift
//  AyasNewsPaperFinal
//
//  Created by furkanayas on 28.04.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    var newsPaperList: Array<AnyObject> = []
    
    var situationsmain: Array<Bool> = []
    
    var orderBool = true
    
    var tempdataforimage: Data!
    
    var downloadBool = false
    //aksam
    //haberturk
    //hurriyet
    //milliyet
    //posta
    //sabah
    
    let newsNames: [String] = ["aksam", "haberturk", "hurriyet", "milliyet", "posta", "sabah"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = api.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
        
        newsPaperList = try! context.fetch(request)
        
        if(newsPaperList.isEmpty){ loadNews() }
         
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }
    
        
    /*
     let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
               let context = api.persistentContainer.viewContext
               //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
               let data: NSManagedObject = newsPaperList[0] as! NSManagedObject
               let date = data.value(forKey: "date") as? Date
     */
    func loadNews()
    {
 
        for k in 0...(newsNames.count - 1) {
            let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = api.persistentContainer.viewContext
            let Entity = NSEntityDescription.entity(forEntityName: "NewsPaperEntity", in: context)
                               
            let newRecord = NewsPaperEntityCore(entity: Entity!, insertInto: context)
            
            let today = Date()
            let datee = Calendar.current.date(byAdding: .year, value: -2, to: today)
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
            //let strdate: String =  dateFormatter.string(from: date!)

            newRecord.date = datee!
            newRecord.name = newsNames[k]
            newRecord.isactive = true
            newRecord.imagstatu = false
            
            let imagename:String = newsNames[k] + ".jpg"
            
            let tempimage = UIImage(named: imagename)
            
            //logo given before detailed image paged download
            newRecord.logo = tempimage?.pngData() as! Data
     
            //it just for not nill, it's update in Detail
            newRecord.imag = tempimage?.pngData() as! Data
            do {
                try context.save()
                }
            catch{
                print("there is a error")
                }
            }
        
    }
        
 
     
      

 
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsPaperList.count
    }

    override func viewDidAppear(_ animated: Bool) {

        let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = api.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
        
        newsPaperList = try! context.fetch(request)
        
        tableView.reloadData()
        /*
        tableView.reloadData()
        
        if(situationsmain.isEmpty != true){
        var k = 0
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                data.setValue(situationsmain[k], forKey: "isactive")
                k+=1
                }
                try context.save()
            }
        catch { print("Failed") }
        }
  */

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! MainTableViewCell
         
        let data: NSManagedObject = newsPaperList[indexPath.row] as! NSManagedObject
        
        let status = data.value(forKey: "isactive") as? Bool
        
        if(status == true) {
            
            cell.nameofNewsPaperMainCell.text = data.value(forKey: "name") as? String

            let tempimagdata = (data.value(forKey: "logo") as? Data)!
            let tempimag = UIImage(data: tempimagdata)
            cell.imageofNewsPaperMainCell.image = tempimag

            return cell
        }
        else {
            return UITableViewCell()
        }
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
                let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = api.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
        
                let data: NSManagedObject = newsPaperList[indexPath.row] as! NSManagedObject
        /*
         IT'S HARD DELETE WHEN OPEN
            if(editingStyle == .delete){
                   context.delete(newsPaperList[indexPath.row] as! NSManagedObject)
                   newsPaperList.remove(at: indexPath.row)
                   tableView.deleteRows(at: [indexPath], with: .automatic)
                   
                   do{
                       try context.save()
                   }
                   catch{ print("Failed!") }
               }*/
                if(editingStyle == .delete){
                    
                    let status = data.value(forKey: "isactive") as? Bool
                    if(status == true){
                    data.setValue(false, forKey: "isactive")
                    do{
                        try context.save()
                        tableView.reloadData()
                    }
                    catch{
                        print("Failed!")
                    }
                    }
                    else{print("already false")}
                }
    }
    
    @IBAction func preferencesButton(_ sender: Any) {
         performSegue(withIdentifier: "preferencesSegue", sender: nil)
        // performSegue(withIdentifier: "addSegue", sender: nil)
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailSegue"){
            let destination: DetailViewController = segue.destination as! DetailViewController
            destination.takendata = newsPaperList[tableView.indexPathForSelectedRow!.row] as? NSManagedObject //as!
        }
        
        if(segue.identifier == "preferencesSegue"){
            let destination: PreferencesViewController = segue.destination as! PreferencesViewController
                  
            let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = api.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
                                
            destination.situationspreferences.removeAll()
            situationsmain.removeAll()
            
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    let active = data.value(forKey: "isactive") as? Bool
                    if(active == true){
                        situationsmain.append(true)
                        }
                    else if(active == false){
                        situationsmain.append(false)
                        }
                    }
                          
                } catch { print("Failed") }
               
            destination.situationspreferences = situationsmain
        }
        
      }
    
    @IBAction func orderButton(_ sender: Any) {
        //orderBool  true A to Z  default
        //orderBool false Z to A
        
        if(newsPaperList.isEmpty == false){
            if(orderBool == true){
                self.newsPaperList.sort(by:{$0.name<$1.name})
                self.tableView.reloadData()
            }
            else if(orderBool == false){
                self.newsPaperList.sort(by:{$0.name>$1.name})
                self.tableView.reloadData()
            }
        }
        else {
            print("List is empty")
        }

        orderBool = orderBool ? false : true
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
