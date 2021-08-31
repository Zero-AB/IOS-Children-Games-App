//
//  ViewController.swift
//  Assignment3
//
//  Created by Andrew Bell on 3/10/20.
//  Copyright © 2020 Andrew Bell. All rights reserved.
//

import UIKit

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var membutton: UIButton!
    
    @IBOutlet weak var sortingbutton: UIButton!
    
    @IBOutlet weak var popbutton: UIButton!
    
    @IBOutlet weak var easybutton: UIButton!
    
    @IBOutlet weak var mediumbutton: UIButton!
    
    @IBOutlet weak var hardbutton: UIButton!
    
    @IBOutlet weak var playbutton: UIButton!
    
    @IBOutlet weak var highscorebutton: UIBarButtonItem!
    
    var GameDestination = 0
    
    var GameDifficulty = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //for navigation title
        
        let vctitle = UIImage(named: "vclogo")
        let vctitleimageView = UIImageView(image: vctitle)
        
        self.navigationItem.titleView = vctitleimageView
        
        //for right navigation bar button
        
        highscorebutton.title = "High Scores"
        
        //for background
        let bg = UIImage(named: "back-main")
        let transparentbg = bg?.image(alpha: 0.4)
        background.image = transparentbg
        
        //for first game button
        
        membutton.setImage(UIImage(named: "memory")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //for second game button
        
        sortingbutton.setImage(UIImage(named: "sorting-icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //for third game button
        
        popbutton.setImage(UIImage(named: "balloon-game-logo3")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //for easy button
        
        easybutton.setImage(UIImage(named: "easy")?.withRenderingMode(.alwaysOriginal), for: .normal)
    
        //for medium button
        
        mediumbutton.setImage(UIImage(named: "medium")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //for hard button
        
        hardbutton.setImage(UIImage(named: "hard")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //for play button
        
        playbutton.setImage(UIImage(named: "PlayButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
    }

    
    @IBAction func membuttonpressed(_ sender: UIButton) {
        
            membutton.backgroundColor = UIColor.green
            sortingbutton.backgroundColor = UIColor.clear
            popbutton.backgroundColor = UIColor.clear
            GameDestination = 1
                     
    }
    

    @IBAction func sortbuttonpressed(_ sender: UIButton) {
       
            membutton.backgroundColor = UIColor.clear
            sortingbutton.backgroundColor = UIColor.green
            popbutton.backgroundColor = UIColor.clear
            GameDestination = 2
                             
    }
    
    
    @IBAction func popbuttonpressed(_ sender: UIButton) {
       
            membutton.backgroundColor = UIColor.clear
            sortingbutton.backgroundColor = UIColor.clear
            popbutton.backgroundColor = UIColor.green
            GameDestination = 3
        
    }
    
    
    @IBAction func easybuttonpressed(_ sender: UIButton) {
        
        easybutton.backgroundColor = UIColor.green
        mediumbutton.backgroundColor = UIColor.clear
        hardbutton.backgroundColor = UIColor.clear
        GameDifficulty = 1
        
    }
    
    @IBAction func mediumbuttonpressed(_ sender: UIButton) {
        
        easybutton.backgroundColor = UIColor.clear
        mediumbutton.backgroundColor = UIColor.green
        hardbutton.backgroundColor = UIColor.clear
        GameDifficulty = 2
        
    }
    
    @IBAction func hardbuttonpressed(_ sender: UIButton) {
        
        easybutton.backgroundColor = UIColor.clear
        mediumbutton.backgroundColor = UIColor.clear
        hardbutton.backgroundColor = UIColor.green
        GameDifficulty = 3
        
    }
    
    
    @IBAction func playbuttonpressed(_ sender: UIButton) {
        
        //first check to see a difficulty was selected
        
        if (GameDifficulty == 0) {
            let alert = UIAlertController(title: "Sorry", message: "Please choose a difficulty first", preferredStyle: .alert)
             
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
             
             present(alert, animated: true)
            
        }
        
        else {
        
        //then check to see if a game was selected
            
        if (GameDestination == 1) {
        performSegue(withIdentifier: "tomemgame", sender: self)
        }
        
        else if (GameDestination == 2) {
        performSegue(withIdentifier: "tosortgame", sender: self)
        }
        
        else if (GameDestination == 3) {
        performSegue(withIdentifier: "topopgame", sender: self)
        }
        
        else {
            let alert = UIAlertController(title: "Sorry", message: "Please choose a game first", preferredStyle: .alert)
             
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
             
             present(alert, animated: true)
            
            }
        
        }
    }
    
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        
        //for segue to memory game
             if segue.identifier == "tomemgame" {
                   
                   if let mtm = segue.destination as? MemoryGame {
                    mtm.memorydifficulty = self.GameDifficulty
                     
                   }
             }
        
        //for segue to sorting game
            if segue.identifier == "tosortgame" {
              
                if let mts = segue.destination as? SortingGame {
                 mts.sortingdifficulty = self.GameDifficulty
                
              }
        }
        
        //for segue to pop game
            if segue.identifier == "topopgame" {
              
                if let mtp = segue.destination as? PopGame {
                 mtp.poppingdifficulty = self.GameDifficulty
                
              }
        }
        
        
        
    }
    
    
    
    
}

