//
//  addViewController.swift
//  AyasNewsPaperFinal
//
//  Created by furkanayas on 28.04.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class addViewController: UIViewController {

   // var takendata: NSManagedObject!
    
    var tempdataforimage: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          downloadImage(newsPaperName: "aksam", today: Date())

        //aksam
               //haberturk
               //hurriyet
               //milliyet
               //posta
               //sabah
        
        // Do any additional setup after loading the view.
    }
    
    
     @IBAction func addnewButton(_ sender: Any) {

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
            newRecord.name = "Aksam"
            newRecord.isactive = false
            newRecord.imag = tempdataforimage
                
            do {
                try context.save()
                print("OK ULAN")
                }
            catch{
                print("there is a error")
                }
        
        navigationController?.popToRootViewController(animated: true)
    }

    func downloadImage(newsPaperName: String, today: Date) {
             // let url = URL(string: "https://media-cdn.t24.com.tr/media/papers/full/sabah_2018-01-22.jpg")!
            /*
                  var date = Date()
                  let dateFormatter = DateFormatter()
                  dateFormatter.dateFormat = "yyyy-MM-dd"
                  var str = dateFormatter.string(from: date)
                  
                  print(str)
                   2020-04-27
                   */
            let date = Calendar.current.date(byAdding: .year, value: -2, to: today)
            
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let strdate: String =  dateFormatter.string(from: date!)
            
            let base = "https://media-cdn.t24.com.tr/media/papers/full/"
            let str = base + newsPaperName + "_" + strdate + ".jpg"
            let url: URL = URL(string: (str))!
     
            
            print("Download Started")
            getData(from: url) { data, response, error in guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    //self.imag.image = UIImage(data: data)
                    self.tempdataforimage = data
                }
            }
        }
     
         func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
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
