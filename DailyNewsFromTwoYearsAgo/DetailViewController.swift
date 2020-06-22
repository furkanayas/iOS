//
//  DetailViewController.swift
//  AyasNewsPaperFinal
//
//  Created by furkanayas on 28.04.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIScrollViewDelegate {

    var takendata: NSManagedObject!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
   // var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (takendata != nil){
            
            let name: String = takendata.value(forKey: "name") as! String
              label.text = name
            
            let imagstatu = takendata.value(forKey: "imagstatu") as? Bool
            let date = takendata.value(forKey: "date") as? Date
            let date2 = Calendar.current.date(byAdding: .day, value: 1, to: date!)
            //
           // let tempdata2 =
                //(takendata.value(forKey: "imag") as? Data)!
            
            
            
            let today = Date()
            let datee = Calendar.current.date(byAdding: .year, value: -2, to: today)
            
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if(imagstatu == false)
            {
                downloadImage(newsPaperName: name, today: Date())
            }
            else if (imagstatu == true)
            {

                let tempdata:Data = (takendata.value(forKey: "imag") as? Data)!
                         
                
                switch datee!.compare(date2!) {
   
                case .orderedAscending:
                    imageView.image = UIImage(data: tempdata)
                case .orderedSame:
                    downloadImage(newsPaperName: name, today: Date())
                case .orderedDescending:
                    downloadImage(newsPaperName: name, today: Date())
                }
               
            }
        scrollView.delegate = self
        // Do any additional setup after loading the view.
        }
    }
 
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                 URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
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
     
             let api: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = api.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsPaperEntity")
            
           
            print("Download Started")
            getData(from: url) { data, response, error in guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async {
                    //self.imag.image = UIImage(data: data)
                   // self.tempdataforimage = data
                    self.imageView.image = UIImage(data: data)
                    
                    do {
                        let result = try context.fetch(request)
                        for record in result as! [NSManagedObject] {
                       
                        let name: String = record.value(forKey: "name") as! String
                        let takenname: String = self.takendata.value(forKey: "name") as! String
                           
                            if(name == takenname){
                                
                             record.setValue(data, forKey: "imag")
                             record.setValue(true, forKey: "imagstatu")
                            }
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

               
            }
            
        }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
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
