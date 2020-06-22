//
//  AppDelegate.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 25.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


 //   var window: UIWindow?
    
    var listArrADEng: Array<listObject> = []
    var listArrADTr: Array<listObject> = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let dataeng: Data =  readLocalFile(forName: "ObjectEng")!
        parseEng(jsonData: dataeng)
                    
        let datatr: Data =  readLocalFile(forName: "ObjectTurk")!
        parseTR(jsonData: datatr)
        
        return true
    }
    
    private func readLocalFile(forName name: String) -> Data? {
          do {
              if let bundlePath = Bundle.main.path(forResource: name,
                                                   ofType: "json"),
                  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                  return jsonData
              }
          } catch {
              print(error)
          }
          
          return nil
      }
        
      private func parseEng(jsonData: Data) {
            do {
               // let decodedData = try JSONDecoder().decode(listObject.self, from: jsonData)
                let objs: [listObject] = try JSONDecoder().decode([listObject].self, from: jsonData)
               
               listArrADEng = objs
               
                print("parse successed")
            }
            catch {
                print("decode error")
            }
        }
    
    private func parseTR(jsonData: Data) {
        do {
           // let decodedData = try JSONDecoder().decode(listObject.self, from: jsonData)
            let objs: [listObject] = try JSONDecoder().decode([listObject].self, from: jsonData)
           
           listArrADTr = objs
           
            print("parse successed")
        }
        catch {
            print("decode error")
        }
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AyasHomelessSim")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

