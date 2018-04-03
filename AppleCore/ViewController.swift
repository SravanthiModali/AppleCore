//
//  ViewController.swift
//  AppleCore
//
//  Created by Modali,Naga Sravanthi on 3/29/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func populate(_ sender: UIButton) {
        let moc = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
        
        let fish0 = NSEntityDescription.insertNewObject(forEntityName: "Fish", into: moc) as! FishMO
        fish0.species = "Carp"
        fish0.size = 12.3
        
        
        let fish1 = NSEntityDescription.insertNewObject(forEntityName: "Fish", into: moc) as! FishMO
        fish1.species = "Clown"
        fish1.size = 1.5
        
        
        let fish2 = NSEntityDescription.insertNewObject(forEntityName: "Fish", into: moc) as! FishMO
        fish2.species = "Shark"
        fish2.size = 1234.50
        
        let lakeVictoria = NSEntityDescription.insertNewObject(forEntityName: "Lake", into: moc) as! LakeMO
        lakeVictoria.name = "Victoria"
        lakeVictoria.volume = 100000.0
        
        
        let lakeMichigan = NSEntityDescription.insertNewObject(forEntityName: "Lake", into: moc) as! LakeMO
        lakeMichigan.name = "Michigan"
        lakeMichigan.volume = 120000.0
        
        
        
        lakeVictoria.addToHasFish(fish0)
        lakeVictoria.addToHasFish(fish2)
        
        lakeMichigan.addToHasFish(fish0)
        lakeMichigan.addToHasFish(fish1)
        
        
        do {
            try moc.save()
            print("we saved it")
        }
        catch {
            print("error trying to save: \(error)")
        }
    }
    
    @IBAction func fetchAll(_ sender: UIButton) {
        
        let moc = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
        
        
        let fetchRequest:NSFetchRequest<FishMO> = NSFetchRequest(entityName: "Fish")
        do {
            let allFish = try moc.fetch(fetchRequest)
            for fish in allFish {
                print(fish.species!, fish.size)
                if let lakes = fish.inLake {
                    for lake in lakes {
                        print((lake as! LakeMO).name!)
                    }
                }
                
                
            }
        } catch {
            print("oops! fetch failure")
        }
    }
    
    
    @IBAction func fetchCarp(_ sender: UIButton) {
        let moc = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
        
        
        let fetchRequest:NSFetchRequest<FishMO> = NSFetchRequest(entityName: "Fish")
//        fetchRequest.predicate = NSPredicate(format: "species BeginsWith %@", "Carp")
        fetchRequest.predicate = NSPredicate(format: "size > ",12.0)
        do {
            let allFish = try moc.fetch(fetchRequest)
            for fish in allFish {
                print(fish.species!, fish.size)
                if let lakes = fish.inLake {
                    for lake in lakes {
                        print((lake as! LakeMO).name!)
                    }
                }
                
                
            }
        } catch {
            print("oops! fetch failure")
        }
    }
    
    
}

