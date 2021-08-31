//
//  SortingGame.swift
//  Assignment3
//
//  Created by Andrew Bell on 3/11/20.
//  Copyright © 2020 Andrew Bell. All rights reserved.
//

import UIKit
import AVFoundation

class SortingGame: UIViewController, UIGestureRecognizerDelegate {
    
    let sortlabel = UILabel()
    let sorttitle = UIView()
    
    let zero = UIImage(named: "cartoon-number-0")
    let one = UIImage(named: "cartoon-number-1")
    let two = UIImage(named: "cartoon-number-2")
    let three = UIImage(named: "cartoon-number-3")
    let four = UIImage(named: "cartoon-number-4")
    let five = UIImage(named: "cartoon-number-5")
    let six = UIImage(named: "cartoon-number-6")
    let seven = UIImage(named: "cartoon-number-7")
    let eight = UIImage(named: "cartoon-number-8")
    let nine = UIImage(named: "cartoon-number-9")
    let semicolon = UILabel()
    
    let air1 = UIImage(named: "1-1")
    let air2 = UIImage(named: "1-2")
    let air3 = UIImage(named: "1-3")
    let air4 = UIImage(named: "1-4")
    let air5 = UIImage(named: "1-5")
    let water1 = UIImage(named: "2-1")
    let water2 = UIImage(named: "2-2")
    let water3 = UIImage(named: "2-3")
    let water4 = UIImage(named: "2-4")
    let water5 = UIImage(named: "2-5")
    let land1 = UIImage(named: "3-1")
    let land2 = UIImage(named: "3-2")
    let land3 = UIImage(named: "3-3")
    let land4 = UIImage(named: "3-4")
    let land5 = UIImage(named: "3-5")
    
    var firstsortimageView = UIImageView()
    var secondsortimageView = UIImageView()
    var thirdsortimageView = UIImageView()
    var fourthsortimageView = UIImageView()
    var fifthsortimageView = UIImageView()
    var sixthsortimageView = UIImageView()
    var seventhsortimageView = UIImageView()
    var eigthsortimageView = UIImageView()
    var ninthsortimageView = UIImageView()
    var tenthsortimageView = UIImageView()
    var eleventhsortimageView = UIImageView()
    var twelfthsortimageView = UIImageView()
    
    var sortingdifficulty = 0
    
    var sortcount = 0
    
    var cheerSoundPlayer = AVAudioPlayer()
    
    var sorttimeduration = 0
    var sortpointtimeduration = 0
    var sortcountdown = Timer()
    var sorttimer2 = Timer()
    var sorttotalpoints = 0
    
    var sortarrayKey = 0
    var sortimage = UIImage()
    
    var originalcenter = CGPoint()
    
    var loc = CGPoint()
    var f = CGRect()
    var g = CGRect()
    var tagofimage = 0
    
    var sub1 = 5
    var sub2 = 10
    
    var loaded = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //for sort navigation title
        
        sortlabel.text = "Sorting Game"
        sortlabel.sizeToFit()
        sortlabel.center = sorttitle.center
        sortlabel.textAlignment = NSTextAlignment.center
        sorttitle.addSubview(sortlabel)
        self.navigationItem.titleView = sorttitle
        sorttitle.sizeToFit()
        
        //check difficulty
        
        print("Sorting Difficulty: \(sortingdifficulty)")
        
        //set background of sorting game
        
        let sortingbackgroundImage = UIImage.init(named: "air-land-water")
        let sortingbackgroundImageView = UIImageView.init(frame: CGRect(x: 0, y: 225, width: 1030, height: 500))

        sortingbackgroundImageView.image = sortingbackgroundImage
        sortingbackgroundImageView.contentMode = .scaleAspectFill
        
        self.view.insertSubview(sortingbackgroundImageView, at: 0)
        
        //set image area for game
        
        let sortingareaimageview = UIImageView(frame: CGRect(x:0, y: 0, width: 1030, height: 225))
        sortingareaimageview.backgroundColor = UIColor(red: 0.4863, green: 0.8627, blue: 0.9765, alpha: 1.0)
        self.view.insertSubview(sortingareaimageview, at: 0)
        
        //set timer image to bottom left corner
               
        let sortingt = "time"
        let sortingtimer = UIImage(named: sortingt)
        let sortingtimerimageView = UIImageView(image: sortingtimer!)
               
        sortingtimerimageView.frame = CGRect(x: 5, y: 715, width: 110, height: 50)
        sortingtimerimageView.contentMode = .scaleAspectFit
        self.view.addSubview(sortingtimerimageView)
        
        //set points image to bottom right corner
        
        let sortingp = "score"
        let sortingpoints = UIImage(named: sortingp)
        let sortingpointsimageView = UIImageView(image: sortingpoints!)
        
        sortingpointsimageView.frame = CGRect(x: 710, y: 710, width: 140, height: 70)
        sortingpointsimageView.contentMode = .scaleAspectFit
        self.view.addSubview(sortingpointsimageView)
        
        //create timer and countdown
        
        sortcountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SortingGame.sorttimeaction), userInfo: nil, repeats: true)
        
        //set timer based on difficulty
        
        if (sortingdifficulty == 1) {sorttimeduration = 60}
        else if (sortingdifficulty == 2) {sorttimeduration = 45}
        else if (sortingdifficulty == 3) {sorttimeduration = 30}
        
        //call timer function class and display next to timer image
        
        let stc = timercd()
        self.view.addSubview(stc)
        
        //call point count function and display next to score image
        
        let spc = countingpoints()
        self.view.addSubview(spc)
        
        
        //create game based on difficulty
        
        if (sortingdifficulty == 1) {easydifficulty()
            sortcount = 8
        }
        else if (sortingdifficulty == 2) {mediumdifficulty()
            sortcount = 10
        }
        else if (sortingdifficulty == 3) {harddifficulty()
            sortcount = 12
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("did appear")
        
        
        
        if (sortingdifficulty == 1) {sorttimeduration = 60}
        else if (sortingdifficulty == 2) {sorttimeduration = 45}
        else if (sortingdifficulty == 3) {sorttimeduration = 30}
        
        sorttotalpoints = 0
        
        //call timer function class and display next to timer image
        
        let stc = timercd()
        self.view.addSubview(stc)
        
        //call point count function and display next to score image
        
        let spc = countingpoints()
        self.view.addSubview(spc)
        
        
        //create game based on difficulty
        
        if (loaded > 0) {
            
        sub1 = 5
        sub2 = 10
            
        firstsortimageView.removeFromSuperview()
        secondsortimageView.removeFromSuperview()
        thirdsortimageView.removeFromSuperview()
        fourthsortimageView.removeFromSuperview()
        fifthsortimageView.removeFromSuperview()
        sixthsortimageView.removeFromSuperview()
        seventhsortimageView.removeFromSuperview()
        eigthsortimageView.removeFromSuperview()
        ninthsortimageView.removeFromSuperview()
        tenthsortimageView.removeFromSuperview()
        eleventhsortimageView.removeFromSuperview()
        twelfthsortimageView.removeFromSuperview()
            
            
        if (sortingdifficulty == 1) {easydifficulty()
            sortcount = 8
        }
        else if (sortingdifficulty == 2) {mediumdifficulty()
            sortcount = 10
        }
        else if (sortingdifficulty == 3) {harddifficulty()
            sortcount = 12
        }
        
        }
       
    }
    
    
    
    func timercd() -> UIImageView{
        
        semicolon.text = ":"
        semicolon.font = semicolon.font.withSize(35)
        var minutessection = UIImageView()
        var tensecondssection = UIImageView()
        var secondssection = UIImageView()
    
        //change the minute section based on timer
        if (sorttimeduration >= 120) {minutessection = UIImageView(image: two!)}
        else if (sorttimeduration < 120 && sorttimeduration >= 60) {minutessection = UIImageView(image: one!)}
        else {minutessection = UIImageView(image: zero!)}
        
        //change the ten seconds based on timer
        if (((sorttimeduration % 60)/10) == 0) {tensecondssection = UIImageView(image: zero!)}
        else if (((sorttimeduration % 60)/10) == 1) {tensecondssection = UIImageView(image: one!)}
        else if (((sorttimeduration % 60)/10) == 2) {tensecondssection = UIImageView(image: two!)}
        else if (((sorttimeduration % 60)/10) == 3) {tensecondssection = UIImageView(image: three!)}
        else if (((sorttimeduration % 60)/10) == 4) {tensecondssection = UIImageView(image: four!)}
        else if (((sorttimeduration % 60)/10) == 5) {tensecondssection = UIImageView(image: five!)}
        else {tensecondssection = UIImageView(image: six!)}
        
        //change the seconds based on timer
        if (sorttimeduration % 10 == 0) {secondssection = UIImageView(image: zero!)}
        else if (sorttimeduration % 10 == 1) {secondssection = UIImageView(image: one!)}
        else if (sorttimeduration % 10 == 2) {secondssection = UIImageView(image: two!)}
        else if (sorttimeduration % 10 == 3) {secondssection = UIImageView(image: three!)}
        else if (sorttimeduration % 10 == 4) {secondssection = UIImageView(image: four!)}
        else if (sorttimeduration % 10 == 5) {secondssection = UIImageView(image: five!)}
        else if (sorttimeduration % 10 == 6) {secondssection = UIImageView(image: six!)}
        else if (sorttimeduration % 10 == 7) {secondssection = UIImageView(image: seven!)}
        else if (sorttimeduration % 10 == 8) {secondssection = UIImageView(image: eight!)}
        else {secondssection = UIImageView(image: nine!)}
            
        semicolon.frame = CGRect(x: 40, y: -2, width: 15, height: 35)
        minutessection.frame = CGRect(x: 10, y: 0, width: 25, height: 35)
        tensecondssection.frame = CGRect(x: 60, y: 0, width: 25, height: 35)
        secondssection.frame = CGRect(x: 90, y: 0, width: 25, height: 35)
        minutessection.contentMode = .scaleAspectFit
        tensecondssection.contentMode = .scaleAspectFit
        secondssection.contentMode = .scaleAspectFit
        
        let memorytimercountdown = UIImageView(frame: CGRect(x: 120, y: 722, width: 125, height: 38))
        memorytimercountdown.backgroundColor = UIColor(red: 0.4863, green: 0.8627, blue: 0.9765, alpha: 1.0)
        memorytimercountdown.addSubview(minutessection)
        memorytimercountdown.addSubview(semicolon)
        memorytimercountdown.addSubview(tensecondssection)
        memorytimercountdown.addSubview(secondssection)
        return memorytimercountdown
    }
    
    func countingpoints() -> UIImageView{
        
        var hundredpointssection = UIImageView()
        var tenpointssection = UIImageView()
        var singlepointssection = UIImageView()
        
        //change the hundred points section based on total points
        if (((sorttotalpoints % 1000)/100) == 0) {hundredpointssection = UIImageView(image: zero!)}
        else if (((sorttotalpoints % 1000)/100) == 1) {hundredpointssection = UIImageView(image: one!)}
        else if (((sorttotalpoints % 1000)/100) == 2) {hundredpointssection = UIImageView(image: two!)}
        else if (((sorttotalpoints % 1000)/100) == 3) {hundredpointssection = UIImageView(image: three!)}
        else if (((sorttotalpoints % 1000)/100) == 4) {hundredpointssection = UIImageView(image: four!)}
        else if (((sorttotalpoints % 1000)/100) == 5) {hundredpointssection = UIImageView(image: five!)}
        else if (((sorttotalpoints % 1000)/100) == 6) {hundredpointssection = UIImageView(image: six!)}
        else if (((sorttotalpoints % 1000)/100) == 7) {hundredpointssection = UIImageView(image: seven!)}
        else if (((sorttotalpoints % 1000)/100) == 8) {hundredpointssection = UIImageView(image: eight!)}
        else {hundredpointssection = UIImageView(image: nine!)}
        
       
        //change the tens points section based on total points
        if (((sorttotalpoints % 100)/10) == 0) {tenpointssection = UIImageView(image: zero!)}
        else if (((sorttotalpoints % 100)/10) == 1) {tenpointssection = UIImageView(image: one!)}
        else if (((sorttotalpoints % 100)/10) == 2) {tenpointssection = UIImageView(image: two!)}
        else if (((sorttotalpoints % 100)/10) == 3) {tenpointssection = UIImageView(image: three!)}
        else if (((sorttotalpoints % 100)/10) == 4) {tenpointssection = UIImageView(image: four!)}
        else if (((sorttotalpoints % 100)/10) == 5) {tenpointssection = UIImageView(image: five!)}
        else if (((sorttotalpoints % 100)/10) == 6) {tenpointssection = UIImageView(image: six!)}
        else if (((sorttotalpoints % 100)/10) == 7) {tenpointssection = UIImageView(image: seven!)}
        else if (((sorttotalpoints % 100)/10) == 8) {tenpointssection = UIImageView(image: eight!)}
        else {tenpointssection = UIImageView(image: nine!)}
        
        
        //change the single points section based on total points
        if (sorttotalpoints % 10 == 0) {singlepointssection = UIImageView(image: zero!)}
        else if (sorttotalpoints % 10 == 1) {singlepointssection = UIImageView(image: one!)}
        else if (sorttotalpoints % 10 == 2) {singlepointssection = UIImageView(image: two!)}
        else if (sorttotalpoints % 10 == 3) {singlepointssection = UIImageView(image: three!)}
        else if (sorttotalpoints % 10 == 4) {singlepointssection = UIImageView(image: four!)}
        else if (sorttotalpoints % 10 == 5) {singlepointssection = UIImageView(image: five!)}
        else if (sorttotalpoints % 10 == 6) {singlepointssection = UIImageView(image: six!)}
        else if (sorttotalpoints % 10 == 7) {singlepointssection = UIImageView(image: seven!)}
        else if (sorttotalpoints % 10 == 8) {singlepointssection = UIImageView(image: eight!)}
        else {singlepointssection = UIImageView(image: nine!)}
        
        hundredpointssection.frame = CGRect(x: 30, y: 0, width: 25, height: 35)
        tenpointssection.frame = CGRect(x: 60, y: 0, width: 25, height: 35)
        singlepointssection.frame = CGRect(x: 90, y: 0, width: 25, height: 35)
        singlepointssection.contentMode = .scaleAspectFit
        tenpointssection.contentMode = .scaleAspectFit
        hundredpointssection.contentMode = .scaleAspectFit
        
        if (sorttotalpoints < 100) {hundredpointssection.isHidden = true}
        else if (sorttotalpoints >= 100) {hundredpointssection.isHidden = false}
        
        if (sorttotalpoints < 10) {tenpointssection.isHidden = true}
        else if (sorttotalpoints >= 10) {tenpointssection.isHidden = false}
        
        let memorypointcount = UIImageView(frame: CGRect(x: 855, y: 726, width: 125, height: 38))
        memorypointcount.backgroundColor = UIColor(red: 0.4863, green: 0.8627, blue: 0.9765, alpha: 1.0)
        memorypointcount.addSubview(singlepointssection)
        memorypointcount.addSubview(tenpointssection)
        memorypointcount.addSubview(hundredpointssection)
        return memorypointcount
        
    }
    
    func easydifficulty() {
        var sortimgs = [air1, air2, air3, air4, air5, water1, water2, water3, water4, water5, land1, land2, land3, land4, land5]
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        print("\(sortarrayKey)")
        sortimage = sortimgs[sortarrayKey]!
        
        sortimgs.remove(at: sortarrayKey)
        
        firstsortimageView = UIImageView(image: sortimage)

        firstsortimageView.frame = CGRect(x: 20, y: 78, width: 70, height: 70)
        firstsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(firstsortimageView)
        firstsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        firstsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {firstsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {firstsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {firstsortimageView.tag = 3}
        
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        print("\(sortarrayKey)")
        sortimage = sortimgs[sortarrayKey]!
        
               
        sortimgs.remove(at: sortarrayKey)
        
        secondsortimageView = UIImageView(image: sortimage)

        secondsortimageView.frame = CGRect(x: 150, y: 78, width: 70, height: 70)
        secondsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(secondsortimageView)
        secondsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        secondsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {secondsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {secondsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {secondsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
               
        sortimgs.remove(at: sortarrayKey)
        
        thirdsortimageView = UIImageView(image: sortimage)

        thirdsortimageView.frame = CGRect(x: 280, y: 78, width: 70, height: 70)
        thirdsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(thirdsortimageView)
        thirdsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        thirdsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {thirdsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {thirdsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {thirdsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        fourthsortimageView = UIImageView(image: sortimage)

        fourthsortimageView.frame = CGRect(x: 410, y: 78, width: 70, height: 70)
        fourthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(fourthsortimageView)
        fourthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        fourthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {fourthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {fourthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {fourthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        fifthsortimageView = UIImageView(image: sortimage)

        fifthsortimageView.frame = CGRect(x: 540, y: 78, width: 70, height: 70)
        fifthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(fifthsortimageView)
        fifthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        fifthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {fifthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {fifthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {fifthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        sixthsortimageView = UIImageView(image: sortimage)

        sixthsortimageView.frame = CGRect(x: 670, y: 78, width: 70, height: 70)
        sixthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(sixthsortimageView)
        sixthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        sixthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {sixthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {sixthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {sixthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        seventhsortimageView = UIImageView(image: sortimage)

        seventhsortimageView.frame = CGRect(x: 800, y: 78, width: 70, height: 70)
        seventhsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(seventhsortimageView)
        seventhsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        seventhsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {seventhsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {seventhsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {seventhsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        eigthsortimageView = UIImageView(image: sortimage)

        eigthsortimageView.frame = CGRect(x: 930, y: 78, width: 70, height: 70)
        eigthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(eigthsortimageView)
        eigthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        eigthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {eigthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {eigthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {eigthsortimageView.tag = 3}
        
    }
    
    func mediumdifficulty() {
        var sortimgs = [air1, air2, air3, air4, air5, water1, water2, water3, water4, water5, land1, land2, land3, land4, land5]
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
        sortimgs.remove(at: sortarrayKey)
        
        firstsortimageView = UIImageView(image: sortimage)

        firstsortimageView.frame = CGRect(x: 20, y: 78, width: 70, height: 70)
        firstsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(firstsortimageView)
        firstsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        firstsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {firstsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {firstsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {firstsortimageView.tag = 3}
        
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
               
        sortimgs.remove(at: sortarrayKey)
        
        secondsortimageView = UIImageView(image: sortimage)

        secondsortimageView.frame = CGRect(x: 120, y: 78, width: 70, height: 70)
        secondsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(secondsortimageView)
        secondsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        secondsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {secondsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {secondsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {secondsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
               
        sortimgs.remove(at: sortarrayKey)
        
        thirdsortimageView = UIImageView(image: sortimage)

        thirdsortimageView.frame = CGRect(x: 220, y: 78, width: 70, height: 70)
        thirdsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(thirdsortimageView)
        thirdsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        thirdsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {thirdsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {thirdsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {thirdsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        fourthsortimageView = UIImageView(image: sortimage)

        fourthsortimageView.frame = CGRect(x: 320, y: 78, width: 70, height: 70)
        fourthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(fourthsortimageView)
        fourthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        fourthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {fourthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {fourthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {fourthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        fifthsortimageView = UIImageView(image: sortimage)

        fifthsortimageView.frame = CGRect(x: 420, y: 78, width: 70, height: 70)
        fifthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(fifthsortimageView)
        fifthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        fifthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {fifthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {fifthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {fifthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        sixthsortimageView = UIImageView(image: sortimage)

        sixthsortimageView.frame = CGRect(x: 520, y: 78, width: 70, height: 70)
        sixthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(sixthsortimageView)
        sixthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        sixthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {sixthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {sixthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {sixthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        seventhsortimageView = UIImageView(image: sortimage)

        seventhsortimageView.frame = CGRect(x: 620, y: 78, width: 70, height: 70)
        seventhsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(seventhsortimageView)
        seventhsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        seventhsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {seventhsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {seventhsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {seventhsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        eigthsortimageView = UIImageView(image: sortimage)

        eigthsortimageView.frame = CGRect(x: 720, y: 78, width: 70, height: 70)
        eigthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(eigthsortimageView)
        eigthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        eigthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {eigthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {eigthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {eigthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
                      
        sortimgs.remove(at: sortarrayKey)
               
        ninthsortimageView = UIImageView(image: sortimage)

        ninthsortimageView.frame = CGRect(x: 820, y: 78, width: 70, height: 70)
        ninthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(ninthsortimageView)
        ninthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        ninthsortimageView.isUserInteractionEnabled = true
               
        if (sortarrayKey < sub1) {ninthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {ninthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {ninthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
                      
        sortimgs.remove(at: sortarrayKey)
               
        tenthsortimageView = UIImageView(image: sortimage)

        tenthsortimageView.frame = CGRect(x: 920, y: 78, width: 70, height: 70)
        tenthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(tenthsortimageView)
        tenthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        tenthsortimageView.isUserInteractionEnabled = true
               
        if (sortarrayKey < sub1) {tenthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {tenthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {tenthsortimageView.tag = 3}
        
    }
    
    func harddifficulty() {
        var sortimgs = [air1, air2, air3, air4, air5, water1, water2, water3, water4, water5, land1, land2, land3, land4, land5]
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
        sortimgs.remove(at: sortarrayKey)
        
        firstsortimageView = UIImageView(image: sortimage)

        firstsortimageView.frame = CGRect(x: 5, y: 78, width: 70, height: 70)
        firstsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(firstsortimageView)
        firstsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        firstsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {firstsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {firstsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {firstsortimageView.tag = 3}
        
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
               
        sortimgs.remove(at: sortarrayKey)
        
        secondsortimageView = UIImageView(image: sortimage)

        secondsortimageView.frame = CGRect(x: 90, y: 78, width: 70, height: 70)
        secondsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(secondsortimageView)
        secondsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        secondsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {secondsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {secondsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {secondsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
        
               
        sortimgs.remove(at: sortarrayKey)
        
        thirdsortimageView = UIImageView(image: sortimage)

        thirdsortimageView.frame = CGRect(x: 175, y: 78, width: 70, height: 70)
        thirdsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(thirdsortimageView)
        thirdsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        thirdsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {thirdsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {thirdsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {thirdsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        fourthsortimageView = UIImageView(image: sortimage)

        fourthsortimageView.frame = CGRect(x: 265, y: 78, width: 70, height: 70)
        fourthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(fourthsortimageView)
        fourthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        fourthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {fourthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {fourthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {fourthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        fifthsortimageView = UIImageView(image: sortimage)

        fifthsortimageView.frame = CGRect(x: 350, y: 78, width: 70, height: 70)
        fifthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(fifthsortimageView)
        fifthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        fifthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {fifthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {fifthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {fifthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        sixthsortimageView = UIImageView(image: sortimage)

        sixthsortimageView.frame = CGRect(x: 435, y: 78, width: 70, height: 70)
        sixthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(sixthsortimageView)
        sixthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        sixthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {sixthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {sixthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {sixthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        seventhsortimageView = UIImageView(image: sortimage)

        seventhsortimageView.frame = CGRect(x: 520, y: 78, width: 70, height: 70)
        seventhsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(seventhsortimageView)
        seventhsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        seventhsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {seventhsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {seventhsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {seventhsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
               
        sortimgs.remove(at: sortarrayKey)
        
        eigthsortimageView = UIImageView(image: sortimage)

        eigthsortimageView.frame = CGRect(x: 605, y: 78, width: 70, height: 70)
        eigthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(eigthsortimageView)
        eigthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        eigthsortimageView.isUserInteractionEnabled = true
        
        if (sortarrayKey < sub1) {eigthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {eigthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {eigthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
                      
        sortimgs.remove(at: sortarrayKey)
               
        ninthsortimageView = UIImageView(image: sortimage)

        ninthsortimageView.frame = CGRect(x: 690, y: 78, width: 70, height: 70)
        ninthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(ninthsortimageView)
        ninthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        ninthsortimageView.isUserInteractionEnabled = true
               
        if (sortarrayKey < sub1) {ninthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {ninthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {ninthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
                      
        sortimgs.remove(at: sortarrayKey)
               
        tenthsortimageView = UIImageView(image: sortimage)

        tenthsortimageView.frame = CGRect(x: 775, y: 78, width: 70, height: 70)
        tenthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(tenthsortimageView)
        tenthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        tenthsortimageView.isUserInteractionEnabled = true
               
        if (sortarrayKey < sub1) {tenthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {tenthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {tenthsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
                      
        sortimgs.remove(at: sortarrayKey)
               
        eleventhsortimageView = UIImageView(image: sortimage)

        eleventhsortimageView.frame = CGRect(x: 860, y: 78, width: 70, height: 70)
        eleventhsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(eleventhsortimageView)
        eleventhsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        eleventhsortimageView.isUserInteractionEnabled = true
               
        if (sortarrayKey < sub1) {eleventhsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {eleventhsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {eleventhsortimageView.tag = 3}
        
        sortarrayKey = Int(arc4random_uniform(UInt32(sortimgs.count)))
        sortimage = sortimgs[sortarrayKey]!
                      
        sortimgs.remove(at: sortarrayKey)
               
        twelfthsortimageView = UIImageView(image: sortimage)

        twelfthsortimageView.frame = CGRect(x: 945, y: 78, width: 70, height: 70)
        twelfthsortimageView.contentMode = .scaleAspectFit
        self.view.addSubview(twelfthsortimageView)
        twelfthsortimageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGesture)))
        twelfthsortimageView.isUserInteractionEnabled = true
               
        if (sortarrayKey < sub1) {twelfthsortimageView.tag = 1
            sub1 -= 1
            sub2 -= 1
        }
        else if (sortarrayKey >= sub1 && sortarrayKey < sub2) {twelfthsortimageView.tag = 2
            sub2 -= 1
        }
        else if (sortarrayKey >= sub2) {twelfthsortimageView.tag = 3}
        
    }

    //this is for the pan gesture
    
    @objc func panGesture(sender: UIPanGestureRecognizer) {
        
       // var translation = sender.translation(in: view)
        
        //print("translation \(translation)")
        
        if let getImage = sender.view as? UIImageView {
        
        if sender.state == UIGestureRecognizer.State.began {
            originalcenter = getImage.center
            g = getImage.frame
            tagofimage = getImage.tag
           // print("tag = \(tagofimage)")
           // print("x = \(originalcenter.x)")
            //print("y = \(originalcenter.y)")
        }
        else if sender.state == UIGestureRecognizer.State.changed {
            loc = sender.location(in: self.view)
            print("loc = \(loc)")
            f = getImage.frame
            getImage.frame.origin = CGPoint(x: loc.x-f.height/2, y: loc.y-f.width/2)
        }
        else if sender.state == UIGestureRecognizer.State.ended {
            if (tagofimage == 1 && loc.y < 485 && loc.y > 180) {
                if (sortpointtimeduration <= 2) {sorttotalpoints += 5}
                else if (sortpointtimeduration > 2 && sortpointtimeduration <= 4) {sorttotalpoints += 4}
                else if (sortpointtimeduration > 4) {sorttotalpoints += 3}
                sortpointtimeduration = 0
                
                sortcount -= 1
                
                let audioPath = Bundle.main.path(forResource: "cheer", ofType: "wav")
                
                do{
                    
                    cheerSoundPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                }
                catch{
                }
                
                cheerSoundPlayer.play()
                
                getImage.isUserInteractionEnabled = false
                
                if (sortcount == 0) {sortcountdown.invalidate()
                    sorttimer2.invalidate()
                    youwin()}
                
                
            }
            else if (tagofimage == 2 && loc.y > 485 && loc.x < 705 ) {
                if (loc.x > 470 && loc.y > 635) {
                    UIView.animate(withDuration: 2, delay: 0, animations: {getImage.frame.origin = CGPoint(x: self.originalcenter.x-self.g.height/2, y: self.originalcenter.y-self.g.width/2)}, completion: nil)
                }
                else {
                    if (sortpointtimeduration <= 2) {sorttotalpoints += 5}
                    else if (sortpointtimeduration > 2 && sortpointtimeduration <= 4) {sorttotalpoints += 4}
                    else if (sortpointtimeduration > 4) {sorttotalpoints += 3}
                    sortpointtimeduration = 0
                    
                    sortcount -= 1
                    
                    let audioPath = Bundle.main.path(forResource: "cheer", ofType: "wav")
                    
                    do{
                        
                        cheerSoundPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                    }
                    catch{
                    }
                    
                    cheerSoundPlayer.play()
                    
                    getImage.isUserInteractionEnabled = false
                    
                    if (sortcount == 0) {sortcountdown.invalidate()
                    sorttimer2.invalidate()
                    youwin()}
                }
                
            }
            else if (tagofimage == 3 && loc.y > 495 && loc.x > 535) {
                if (loc.x < 800 && loc.y < 645) {
                    UIView.animate(withDuration: 2, delay: 0, animations: {getImage.frame.origin = CGPoint(x: self.originalcenter.x-self.g.height/2, y: self.originalcenter.y-self.g.width/2)}, completion: nil)
                }
                else {
                    if (sortpointtimeduration <= 2) {sorttotalpoints += 5}
                    else if (sortpointtimeduration > 2 && sortpointtimeduration <= 4) {sorttotalpoints += 4}
                    else if (sortpointtimeduration > 4) {sorttotalpoints += 3}
                    sortpointtimeduration = 0
                    
                    sortcount -= 1
                    
                    let audioPath = Bundle.main.path(forResource: "cheer", ofType: "wav")
                    
                    do{
                        
                        cheerSoundPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                    }
                    catch{
                    }
                    
                    cheerSoundPlayer.play()
                    
                    getImage.isUserInteractionEnabled = false
                    
                    if (sortcount == 0) {sortcountdown.invalidate()
                    sorttimer2.invalidate()
                    youwin()}
                }
            }
            else {
                UIView.animate(withDuration: 2, delay: 0, animations: {getImage.frame.origin = CGPoint(x: self.originalcenter.x-self.g.height/2, y: self.originalcenter.y-self.g.width/2)}, completion: nil)
            }
                    
        }
            
        }
        
   
    }
    
    
    
    
    //this is for the time action

    @objc func sorttimeaction() {
        sorttimeduration -= 1
        sortpointtimeduration += 1
        //print("\(sorttimeduration)")
        
        
        let stc = timercd()
        self.view.addSubview(stc)
        
        let spc = countingpoints()
        self.view.addSubview(spc)
        
        if (sorttimeduration <= 0) {sortcountdown.invalidate()
            sorttimer2.invalidate()
            youlose()
        }
        
    }
    
    func youwin() {
        // Declare Alert
        let Message = UIAlertController(title: "Congratulations", message: "Do you want to play again?", preferredStyle: .alert)

        // Create Yes button with action handler
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
             print("Yes button click...")
            self.sortcountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SortingGame.sorttimeaction), userInfo: nil, repeats: true)
            self.loaded += 1
            self.viewDidAppear(true)
        })

        // Create no button with action handlder
        let no = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
            print("No button click...")
            self.navigationController?.popToRootViewController(animated: true)
        }

        //Add OK and Cancel button to dialog message
        Message.addAction(yes)
        Message.addAction(no)

        // Present dialog message to user
        self.present(Message, animated: true, completion: nil)
    }
    
    func youlose() {
        // Declare Alert
        let Message = UIAlertController(title: "Sorry, You Lost", message: "Do you want to play again?", preferredStyle: .alert)

        // Create Yes button with action handler
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
             print("Yes button click...")
            self.sortcountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SortingGame.sorttimeaction), userInfo: nil, repeats: true)
            self.loaded += 1
            self.viewDidAppear(true)
        })

        // Create no button with action handlder
        let no = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
            print("No button click...")
            self.navigationController?.popToRootViewController(animated: true)
        }

        //Add OK and Cancel button to dialog message
        Message.addAction(yes)
        Message.addAction(no)

        // Present dialog message to user
        self.present(Message, animated: true, completion: nil)
    }
    
    //this is for when the back button is pressed, the timer is stopped
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            sortcountdown.invalidate()
            sorttimer2.invalidate()
        }
    }
    
    

}
