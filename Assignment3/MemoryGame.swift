//
//  MemoryGame.swift
//  Assignment3
//
//  Created by Andrew Bell on 3/11/20.
//  Copyright © 2020 Andrew Bell. All rights reserved.
//

import UIKit
import AVFoundation

class MemoryGame: UIViewController, UINavigationControllerDelegate {
    
    let memorylabel = UILabel()
    let memorytitle = UIView()
    
    let buttonquestion = UIImage(named: "question")
    
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
    
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let button5 = UIButton()
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    let button9 = UIButton()
    let button10 = UIButton()
    let button11 = UIButton()
    let button12 = UIButton()
    let button13 = UIButton()
    let button14 = UIButton()
    let button15 = UIButton()
    let button16 = UIButton()
    let button17 = UIButton()
    let button18 = UIButton()
    let button19 = UIButton()
    let button20 = UIButton()
    
    
    var memback1 = UIImage()
    var memback2 = UIImage()
    var memback3 = UIImage()
    var memback4 = UIImage()
    var memback5 = UIImage()
    var memback6 = UIImage()
    var memback7 = UIImage()
    var memback8 = UIImage()
    var memback9 = UIImage()
    var memback10 = UIImage()
    

    var memorydifficulty = 0
    var timeduration = 0
    var pointtimeduration = 0
    var memorycountdown = Timer()
    var totalpoints = 0
    
    var countdown = 0
    
    var imagecomparison = Data()
    
    var guesstag = 0
    
    var waittag = 0
    
    var cheerSoundPlayer = AVAudioPlayer()
    
    var firstguess = false
    
    var timer2 = Timer()
    
    var arrayKey = 0
    var key = 0
    
    var backimage = UIImage()

    var imgs = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add images to array
        imgs.append(UIImage(named: "1")!)
        imgs.append(UIImage(named: "2")!)
        imgs.append(UIImage(named: "3")!)
        imgs.append(UIImage(named: "4")!)
        imgs.append(UIImage(named: "5")!)
        imgs.append(UIImage(named: "6")!)
        imgs.append(UIImage(named: "7")!)
        imgs.append(UIImage(named: "8")!)
        imgs.append(UIImage(named: "9")!)
        imgs.append(UIImage(named: "10")!)
        
        //populate the background images
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback1 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback2 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback3 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback4 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback5 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback6 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback7 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback8 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback9 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback10 = imgs[key]
        imgs.remove(at: key)
        
        // Do any additional setup after loading the view.
        
        //for memory navigation title
        
        memorylabel.text = "Memory Game"
        memorylabel.sizeToFit()
        memorylabel.center = memorytitle.center
        memorylabel.textAlignment = NSTextAlignment.center
        memorytitle.addSubview(memorylabel)
        self.navigationItem.titleView = memorytitle
        memorytitle.sizeToFit()
        
        //check difficulty
        
        print("Memory Difficulty: \(memorydifficulty)")
        
        //set background of memory game
        
        let memorybackgroundImage = UIImage.init(named: "background")
        let memorybackgroundImageView = UIImageView.init(frame: self.view.frame)

        memorybackgroundImageView.image = memorybackgroundImage
        memorybackgroundImageView.contentMode = .scaleAspectFill

        self.view.insertSubview(memorybackgroundImageView, at: 0)
        
        //set timer image to top left corner
        
        let memoryt = "time"
        let memorytimer = UIImage(named: memoryt)
        let memorytimerimageView = UIImageView(image: memorytimer!)
        
        memorytimerimageView.frame = CGRect(x: 0, y: 65, width: 110, height: 50)
        memorytimerimageView.contentMode = .scaleAspectFit
        self.view.addSubview(memorytimerimageView)
        
        //set points image to top right corner
        
        let memoryp = "score"
        let memorypoints = UIImage(named: memoryp)
        let memorypointsimageView = UIImageView(image: memorypoints!)
        
        memorypointsimageView.frame = CGRect(x: 750, y: 55, width: 140, height: 70)
        memorypointsimageView.contentMode = .scaleAspectFit
        self.view.addSubview(memorypointsimageView)
        
        //create timer and countdown
        
        memorycountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGame.memtimeaction), userInfo: nil, repeats: true)
        
        //set timer based on difficulty
        
        if (memorydifficulty == 1) {timeduration = 120
            countdown = 6
        }
        else if (memorydifficulty == 2) {timeduration = 105
            countdown = 8
        }
        else if (memorydifficulty == 3) {timeduration = 90
            countdown = 10
        }
        
        //call timer function class and display next to timer image
        
        let mtc = timercd()
        self.view.addSubview(mtc)
        
        //call point count function and display next to score image
        
        let mpc = countingpoints()
        self.view.addSubview(mpc)
        
        //set image grid based on difficulty
        
        if (memorydifficulty == 1) {easydifficulty()}
        else if (memorydifficulty == 2) {mediumdifficulty()}
        else if (memorydifficulty == 3) {hardifficulty()}
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("did appear")
        
        //add images to array
        imgs.append(UIImage(named: "1")!)
        imgs.append(UIImage(named: "2")!)
        imgs.append(UIImage(named: "3")!)
        imgs.append(UIImage(named: "4")!)
        imgs.append(UIImage(named: "5")!)
        imgs.append(UIImage(named: "6")!)
        imgs.append(UIImage(named: "7")!)
        imgs.append(UIImage(named: "8")!)
        imgs.append(UIImage(named: "9")!)
        imgs.append(UIImage(named: "10")!)
        
        //populate the background images
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback1 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback2 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback3 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback4 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback5 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback6 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback7 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback8 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback9 = imgs[key]
        imgs.remove(at: key)
        
        key = Int(arc4random_uniform(UInt32(imgs.count)))
        memback10 = imgs[key]
        imgs.remove(at: key)
        
        // Do any additional setup after loading the view.
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        button5.isEnabled = true
        button6.isEnabled = true
        button7.isEnabled = true
        button8.isEnabled = true
        button9.isEnabled = true
        button10.isEnabled = true
        button11.isEnabled = true
        button12.isEnabled = true
        button13.isEnabled = true
        button14.isEnabled = true
        button15.isEnabled = true
        button16.isEnabled = true
        button17.isEnabled = true
        button18.isEnabled = true
        button19.isEnabled = true
        button20.isEnabled = true
        
        
        
        totalpoints = 0
        
       
        
        //set timer based on difficulty
        
        if (memorydifficulty == 1) {timeduration = 120
            countdown = 6
        }
        else if (memorydifficulty == 2) {timeduration = 105
            countdown = 8
        }
        else if (memorydifficulty == 3) {timeduration = 90
            countdown = 10
        }
        
        //call timer function class and display next to timer image
        
        let mtc = timercd()
        self.view.addSubview(mtc)
        
        //call point count function and display next to score image
        
        let mpc = countingpoints()
        self.view.addSubview(mpc)
        
        //set image grid based on difficulty
        
        if (memorydifficulty == 1) {easydifficulty()}
        else if (memorydifficulty == 2) {mediumdifficulty()}
        else if (memorydifficulty == 3) {hardifficulty()}
        
        
       
    }
    
    

    
    func timercd() -> UIImageView{
        
        semicolon.text = ":"
        semicolon.font = semicolon.font.withSize(35)
        var minutessection = UIImageView()
        var tensecondssection = UIImageView()
        var secondssection = UIImageView()
        
        //change the minute section based on timer
        if (timeduration >= 120) {minutessection = UIImageView(image: two!)}
        else if (timeduration < 120 && timeduration >= 60) {minutessection = UIImageView(image: one!)}
        else {minutessection = UIImageView(image: zero!)}
        
        //change the ten seconds based on timer
        if (((timeduration % 60)/10) == 0) {tensecondssection = UIImageView(image: zero!)}
        else if (((timeduration % 60)/10) == 1) {tensecondssection = UIImageView(image: one!)}
        else if (((timeduration % 60)/10) == 2) {tensecondssection = UIImageView(image: two!)}
        else if (((timeduration % 60)/10) == 3) {tensecondssection = UIImageView(image: three!)}
        else if (((timeduration % 60)/10) == 4) {tensecondssection = UIImageView(image: four!)}
        else if (((timeduration % 60)/10) == 5) {tensecondssection = UIImageView(image: five!)}
        else {tensecondssection = UIImageView(image: six!)}
        
        //change the seconds based on timer
        if (timeduration % 10 == 0) {secondssection = UIImageView(image: zero!)}
        else if (timeduration % 10 == 1) {secondssection = UIImageView(image: one!)}
        else if (timeduration % 10 == 2) {secondssection = UIImageView(image: two!)}
        else if (timeduration % 10 == 3) {secondssection = UIImageView(image: three!)}
        else if (timeduration % 10 == 4) {secondssection = UIImageView(image: four!)}
        else if (timeduration % 10 == 5) {secondssection = UIImageView(image: five!)}
        else if (timeduration % 10 == 6) {secondssection = UIImageView(image: six!)}
        else if (timeduration % 10 == 7) {secondssection = UIImageView(image: seven!)}
        else if (timeduration % 10 == 8) {secondssection = UIImageView(image: eight!)}
        else {secondssection = UIImageView(image: nine!)}
            
        semicolon.frame = CGRect(x: 40, y: -2, width: 15, height: 35)
        minutessection.frame = CGRect(x: 10, y: 0, width: 25, height: 35)
        tensecondssection.frame = CGRect(x: 60, y: 0, width: 25, height: 35)
        secondssection.frame = CGRect(x: 90, y: 0, width: 25, height: 35)
        minutessection.contentMode = .scaleAspectFit
        tensecondssection.contentMode = .scaleAspectFit
        secondssection.contentMode = .scaleAspectFit
        
        let memorytimercountdown = UIImageView(frame: CGRect(x: 115, y: 72, width: 125, height: 38))
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
        if (((totalpoints % 1000)/100) == 0) {hundredpointssection = UIImageView(image: zero!)}
        else if (((totalpoints % 1000)/100) == 1) {hundredpointssection = UIImageView(image: one!)}
        else if (((totalpoints % 1000)/100) == 2) {hundredpointssection = UIImageView(image: two!)}
        else if (((totalpoints % 1000)/100) == 3) {hundredpointssection = UIImageView(image: three!)}
        else if (((totalpoints % 1000)/100) == 4) {hundredpointssection = UIImageView(image: four!)}
        else if (((totalpoints % 1000)/100) == 5) {hundredpointssection = UIImageView(image: five!)}
        else if (((totalpoints % 1000)/100) == 6) {hundredpointssection = UIImageView(image: six!)}
        else if (((totalpoints % 1000)/100) == 7) {hundredpointssection = UIImageView(image: seven!)}
        else if (((totalpoints % 1000)/100) == 8) {hundredpointssection = UIImageView(image: eight!)}
        else {hundredpointssection = UIImageView(image: nine!)}
        
       
        //change the tens points section based on total points
        if (((totalpoints % 100)/10) == 0) {tenpointssection = UIImageView(image: zero!)}
        else if (((totalpoints % 100)/10) == 1) {tenpointssection = UIImageView(image: one!)}
        else if (((totalpoints % 100)/10) == 2) {tenpointssection = UIImageView(image: two!)}
        else if (((totalpoints % 100)/10) == 3) {tenpointssection = UIImageView(image: three!)}
        else if (((totalpoints % 100)/10) == 4) {tenpointssection = UIImageView(image: four!)}
        else if (((totalpoints % 100)/10) == 5) {tenpointssection = UIImageView(image: five!)}
        else if (((totalpoints % 100)/10) == 6) {tenpointssection = UIImageView(image: six!)}
        else if (((totalpoints % 100)/10) == 7) {tenpointssection = UIImageView(image: seven!)}
        else if (((totalpoints % 100)/10) == 8) {tenpointssection = UIImageView(image: eight!)}
        else {tenpointssection = UIImageView(image: nine!)}
        
        
        //change the single points section based on total points
        if (totalpoints % 10 == 0) {singlepointssection = UIImageView(image: zero!)}
        else if (totalpoints % 10 == 1) {singlepointssection = UIImageView(image: one!)}
        else if (totalpoints % 10 == 2) {singlepointssection = UIImageView(image: two!)}
        else if (totalpoints % 10 == 3) {singlepointssection = UIImageView(image: three!)}
        else if (totalpoints % 10 == 4) {singlepointssection = UIImageView(image: four!)}
        else if (totalpoints % 10 == 5) {singlepointssection = UIImageView(image: five!)}
        else if (totalpoints % 10 == 6) {singlepointssection = UIImageView(image: six!)}
        else if (totalpoints % 10 == 7) {singlepointssection = UIImageView(image: seven!)}
        else if (totalpoints % 10 == 8) {singlepointssection = UIImageView(image: eight!)}
        else {singlepointssection = UIImageView(image: nine!)}
        
        hundredpointssection.frame = CGRect(x: 30, y: 0, width: 25, height: 35)
        tenpointssection.frame = CGRect(x: 60, y: 0, width: 25, height: 35)
        singlepointssection.frame = CGRect(x: 90, y: 0, width: 25, height: 35)
        singlepointssection.contentMode = .scaleAspectFit
        tenpointssection.contentMode = .scaleAspectFit
        hundredpointssection.contentMode = .scaleAspectFit
        
        if (totalpoints < 100) {hundredpointssection.isHidden = true}
        else if (totalpoints >= 100) {hundredpointssection.isHidden = false}
        
        if (totalpoints < 10) {tenpointssection.isHidden = true}
        else if (totalpoints >= 10) {tenpointssection.isHidden = false}
        
        let memorypointcount = UIImageView(frame: CGRect(x: 895, y: 72, width: 125, height: 38))
        memorypointcount.backgroundColor = UIColor(red: 0.4863, green: 0.8627, blue: 0.9765, alpha: 1.0)
        memorypointcount.addSubview(singlepointssection)
        memorypointcount.addSubview(tenpointssection)
        memorypointcount.addSubview(hundredpointssection)
        return memorypointcount
        
    }
    
    
    func easydifficulty() {
        
        var backimgs = [memback1, memback1, memback2, memback2, memback3, memback3, memback4, memback4, memback5, memback5, memback6, memback6]
        
        
        
        button1.frame = CGRect(x: 280, y: 130, width: 140, height: 140)
        button1.setImage(buttonquestion, for: .normal)
        button1.contentMode = .scaleAspectFit
        button1.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button1.tag = 0
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button1.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button2.frame = CGRect(x: 430, y: 130, width: 140, height: 140)
        button2.setImage(buttonquestion, for: .normal)
        button2.contentMode = .scaleAspectFit
        button2.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button2.tag = 1
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button2.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        
        button3.frame = CGRect(x: 580, y: 130, width: 140, height: 140)
        button3.setImage(buttonquestion, for: .normal)
        button3.contentMode = .scaleAspectFit
        button3.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button3.tag = 2
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button3.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button4.frame = CGRect(x: 280, y: 280, width: 140, height: 140)
        button4.setImage(buttonquestion, for: .normal)
        button4.contentMode = .scaleAspectFit
        button4.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button4.tag = 3
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button4.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button5.frame = CGRect(x: 430, y: 280, width: 140, height: 140)
        button5.setImage(buttonquestion, for: .normal)
        button5.contentMode = .scaleAspectFit
        button5.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button5.tag = 4
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button5.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button6.frame = CGRect(x: 580, y: 280, width: 140, height: 140)
        button6.setImage(buttonquestion, for: .normal)
        button6.contentMode = .scaleAspectFit
        button6.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button6.tag = 5
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button6.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button7.frame = CGRect(x: 280, y: 430, width: 140, height: 140)
        button7.setImage(buttonquestion, for: .normal)
        button7.contentMode = .scaleAspectFit
        button7.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button7.tag = 6
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button7.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button8.frame = CGRect(x: 430, y: 430, width: 140, height: 140)
        button8.setImage(buttonquestion, for: .normal)
        button8.contentMode = .scaleAspectFit
        button8.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button8.tag = 7
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button8.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button9.frame = CGRect(x: 580, y: 430, width: 140, height: 140)
        button9.setImage(buttonquestion, for: .normal)
        button9.contentMode = .scaleAspectFit
        button9.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button9.tag = 8
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button9.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button10.frame = CGRect(x: 280, y: 580, width: 140, height: 140)
        button10.setImage(buttonquestion, for: .normal)
        button10.contentMode = .scaleAspectFit
        button10.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button10.tag = 9
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button10.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button11.frame = CGRect(x: 430, y: 580, width: 140, height: 140)
        button11.setImage(buttonquestion, for: .normal)
        button11.contentMode = .scaleAspectFit
        button11.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button11.tag = 10
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button11.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button12.frame = CGRect(x: 580, y: 580, width: 140, height: 140)
        button12.setImage(buttonquestion, for: .normal)
        button12.contentMode = .scaleAspectFit
        button12.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button12.tag = 11
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button12.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        self.view.addSubview(button5)
        self.view.addSubview(button6)
        self.view.addSubview(button7)
        self.view.addSubview(button8)
        self.view.addSubview(button9)
        self.view.addSubview(button10)
        self.view.addSubview(button11)
        self.view.addSubview(button12)
        
    }
    
    
    func mediumdifficulty() {
        var backimgs = [memback1, memback1, memback2, memback2, memback3, memback3, memback4, memback4, memback5, memback5, memback6, memback6, memback7, memback7, memback8, memback8]
        
        
        button1.frame = CGRect(x: 220, y: 130, width: 140, height: 140)
        button1.setImage(buttonquestion, for: .normal)
        button1.contentMode = .scaleAspectFit
        button1.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button1.tag = 0
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button1.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button2.frame = CGRect(x: 370, y: 130, width: 140, height: 140)
        button2.setImage(buttonquestion, for: .normal)
        button2.contentMode = .scaleAspectFit
        button2.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button2.tag = 1
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button2.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button3.frame = CGRect(x: 520, y: 130, width: 140, height: 140)
        button3.setImage(buttonquestion, for: .normal)
        button3.contentMode = .scaleAspectFit
        button3.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button3.tag = 2
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button3.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button4.frame = CGRect(x: 670, y: 130, width: 140, height: 140)
        button4.setImage(buttonquestion, for: .normal)
        button4.contentMode = .scaleAspectFit
        button4.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button4.tag = 3
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button4.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button5.frame = CGRect(x: 220, y: 280, width: 140, height: 140)
        button5.setImage(buttonquestion, for: .normal)
        button5.contentMode = .scaleAspectFit
        button5.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button5.tag = 4
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button5.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button6.frame = CGRect(x: 370, y: 280, width: 140, height: 140)
        button6.setImage(buttonquestion, for: .normal)
        button6.contentMode = .scaleAspectFit
        button6.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button6.tag = 5
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button6.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button7.frame = CGRect(x: 520, y: 280, width: 140, height: 140)
        button7.setImage(buttonquestion, for: .normal)
        button7.contentMode = .scaleAspectFit
        button7.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button7.tag = 6
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button7.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button8.frame = CGRect(x: 670, y: 280, width: 140, height: 140)
        button8.setImage(buttonquestion, for: .normal)
        button8.contentMode = .scaleAspectFit
        button8.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button8.tag = 7
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button8.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button9.frame = CGRect(x: 220, y: 430, width: 140, height: 140)
        button9.setImage(buttonquestion, for: .normal)
        button9.contentMode = .scaleAspectFit
        button9.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button9.tag = 8
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button9.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button10.frame = CGRect(x: 370, y: 430, width: 140, height: 140)
        button10.setImage(buttonquestion, for: .normal)
        button10.contentMode = .scaleAspectFit
        button10.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button10.tag = 9
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button10.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button11.frame = CGRect(x: 520, y: 430, width: 140, height: 140)
        button11.setImage(buttonquestion, for: .normal)
        button11.contentMode = .scaleAspectFit
        button11.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button11.tag = 10
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button11.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button12.frame = CGRect(x: 670, y: 430, width: 140, height: 140)
        button12.setImage(buttonquestion, for: .normal)
        button12.contentMode = .scaleAspectFit
        button12.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button12.tag = 11
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button12.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button13.frame = CGRect(x: 220, y: 580, width: 140, height: 140)
        button13.setImage(buttonquestion, for: .normal)
        button13.contentMode = .scaleAspectFit
        button13.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button13.tag = 12
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button13.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button14.frame = CGRect(x: 370, y: 580, width: 140, height: 140)
        button14.setImage(buttonquestion, for: .normal)
        button14.contentMode = .scaleAspectFit
        button14.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button14.tag = 13
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button14.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        
        button15.frame = CGRect(x: 520, y: 580, width: 140, height: 140)
        button15.setImage(buttonquestion, for: .normal)
        button15.contentMode = .scaleAspectFit
        button15.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button15.tag = 14
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button15.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button16.frame = CGRect(x: 670, y: 580, width: 140, height: 140)
        button16.setImage(buttonquestion, for: .normal)
        button16.contentMode = .scaleAspectFit
        button16.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button16.tag = 15
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button16.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        self.view.addSubview(button5)
        self.view.addSubview(button6)
        self.view.addSubview(button7)
        self.view.addSubview(button8)
        self.view.addSubview(button9)
        self.view.addSubview(button10)
        self.view.addSubview(button11)
        self.view.addSubview(button12)
        self.view.addSubview(button13)
        self.view.addSubview(button14)
        self.view.addSubview(button15)
        self.view.addSubview(button16)
        
    }
    
    func hardifficulty() {
        var backimgs = [memback1, memback1, memback2, memback2, memback3, memback3, memback4, memback4, memback5, memback5, memback6, memback6, memback7, memback7, memback8, memback8, memback9, memback9, memback10, memback10]
        
        button1.frame = CGRect(x: 150, y: 130, width: 140, height: 140)
        button1.setImage(buttonquestion, for: .normal)
        button1.contentMode = .scaleAspectFit
        button1.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button1.tag = 0
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button1.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button2.frame = CGRect(x: 300, y: 130, width: 140, height: 140)
        button2.setImage(buttonquestion, for: .normal)
        button2.contentMode = .scaleAspectFit
        button2.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button2.tag = 1
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button2.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button3.frame = CGRect(x: 450, y: 130, width: 140, height: 140)
        button3.setImage(buttonquestion, for: .normal)
        button3.contentMode = .scaleAspectFit
        button3.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button3.tag = 2
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button3.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button4.frame = CGRect(x: 600, y: 130, width: 140, height: 140)
        button4.setImage(buttonquestion, for: .normal)
        button4.contentMode = .scaleAspectFit
        button4.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button4.tag = 3
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button4.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
    
        button5.frame = CGRect(x: 750, y: 130, width: 140, height: 140)
        button5.setImage(buttonquestion, for: .normal)
        button5.contentMode = .scaleAspectFit
        button5.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button5.tag = 4
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button5.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button6.frame = CGRect(x: 150, y: 280, width: 140, height: 140)
        button6.setImage(buttonquestion, for: .normal)
        button6.contentMode = .scaleAspectFit
        button6.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button6.tag = 5
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button6.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button7.frame = CGRect(x: 300, y: 280, width: 140, height: 140)
        button7.setImage(buttonquestion, for: .normal)
        button7.contentMode = .scaleAspectFit
        button7.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button7.tag = 6
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button7.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button8.frame = CGRect(x: 450, y: 280, width: 140, height: 140)
        button8.setImage(buttonquestion, for: .normal)
        button8.contentMode = .scaleAspectFit
        button8.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button8.tag = 7
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button8.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button9.frame = CGRect(x: 600, y: 280, width: 140, height: 140)
        button9.setImage(buttonquestion, for: .normal)
        button9.contentMode = .scaleAspectFit
        button9.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button9.tag = 8
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button9.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button10.frame = CGRect(x: 750, y: 280, width: 140, height: 140)
        button10.setImage(buttonquestion, for: .normal)
        button10.contentMode = .scaleAspectFit
        button10.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button10.tag = 9
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button10.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button11.frame = CGRect(x: 150, y: 430, width: 140, height: 140)
        button11.setImage(buttonquestion, for: .normal)
        button11.contentMode = .scaleAspectFit
        button11.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button11.tag = 10
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button11.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button12.frame = CGRect(x: 300, y: 430, width: 140, height: 140)
        button12.setImage(buttonquestion, for: .normal)
        button12.contentMode = .scaleAspectFit
        button12.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button12.tag = 11
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button12.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button13.frame = CGRect(x: 450, y: 430, width: 140, height: 140)
        button13.setImage(buttonquestion, for: .normal)
        button13.contentMode = .scaleAspectFit
        button13.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button13.tag = 12
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button13.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button14.frame = CGRect(x: 600, y: 430, width: 140, height: 140)
        button14.setImage(buttonquestion, for: .normal)
        button14.contentMode = .scaleAspectFit
        button14.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button14.tag = 13
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button14.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button15.frame = CGRect(x: 750, y: 430, width: 140, height: 140)
        button15.setImage(buttonquestion, for: .normal)
        button15.contentMode = .scaleAspectFit
        button15.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button15.tag = 14
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button15.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button16.frame = CGRect(x: 150, y: 580, width: 140, height: 140)
        button16.setImage(buttonquestion, for: .normal)
        button16.contentMode = .scaleAspectFit
        button16.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button16.tag = 15
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button16.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button17.frame = CGRect(x: 300, y: 580, width: 140, height: 140)
        button17.setImage(buttonquestion, for: .normal)
        button17.contentMode = .scaleAspectFit
        button17.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button17.tag = 16
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button17.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button18.frame = CGRect(x: 450, y: 580, width: 140, height: 140)
        button18.setImage(buttonquestion, for: .normal)
        button18.contentMode = .scaleAspectFit
        button18.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button18.tag = 17
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button18.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button19.frame = CGRect(x: 600, y: 580, width: 140, height: 140)
        button19.setImage(buttonquestion, for: .normal)
        button19.contentMode = .scaleAspectFit
        button19.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button19.tag = 18
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button19.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        button20.frame = CGRect(x: 750, y: 580, width: 140, height: 140)
        button20.setImage(buttonquestion, for: .normal)
        button20.contentMode = .scaleAspectFit
        button20.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        button20.tag = 19
        
        arrayKey = Int(arc4random_uniform(UInt32(backimgs.count)))
        backimage = backimgs[arrayKey]
        
        button20.setBackgroundImage(backimage, for: .normal)
        
        backimgs.remove(at: arrayKey)
        
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        self.view.addSubview(button5)
        self.view.addSubview(button6)
        self.view.addSubview(button7)
        self.view.addSubview(button8)
        self.view.addSubview(button9)
        self.view.addSubview(button10)
        self.view.addSubview(button11)
        self.view.addSubview(button12)
        self.view.addSubview(button13)
        self.view.addSubview(button14)
        self.view.addSubview(button15)
        self.view.addSubview(button16)
        self.view.addSubview(button17)
        self.view.addSubview(button18)
        self.view.addSubview(button19)
        self.view.addSubview(button20)
        
    }
    
    
    
    @objc func memtimeaction() {
        timeduration -= 1
        //print("\(timeduration)")
        
        pointtimeduration += 1
        print("\(pointtimeduration)")
        
        let mtc = timercd()
        self.view.addSubview(mtc)
        
        let mpc = countingpoints()
        self.view.addSubview(mpc)
        
        if (timeduration <= 0) {memorycountdown.invalidate()
            timer2.invalidate()
            youlose()
        }
        
    }
    
    
    // this is the function for the buttons
    
    @objc func buttonclick(_ sender: UIButton) {
        
        button1.isUserInteractionEnabled = true
        button2.isUserInteractionEnabled = true
        button3.isUserInteractionEnabled = true
        button4.isUserInteractionEnabled = true
        button5.isUserInteractionEnabled = true
        button6.isUserInteractionEnabled = true
        button7.isUserInteractionEnabled = true
        button8.isUserInteractionEnabled = true
        button9.isUserInteractionEnabled = true
        button10.isUserInteractionEnabled = true
        button11.isUserInteractionEnabled = true
        button12.isUserInteractionEnabled = true
        button13.isUserInteractionEnabled = true
        button14.isUserInteractionEnabled = true
        button15.isUserInteractionEnabled = true
        button16.isUserInteractionEnabled = true
        button17.isUserInteractionEnabled = true
        button18.isUserInteractionEnabled = true
        button19.isUserInteractionEnabled = true
        button20.isUserInteractionEnabled = true
          
          print(sender.tag)
          
          let imagecompare = sender.backgroundImage(for: .normal)?.pngData()
          
          if (firstguess == false) {
              
              firstguess = true
              
              guesstag = sender.tag
              
              sender.setImage(nil, for: .normal)
              
              imagecomparison = imagecompare!
            
            sender.isUserInteractionEnabled = false
              
            
              
          }
          
          else {
              
              firstguess = false
              
              sender.setImage(nil, for: .normal)
              
              waittag = sender.tag
              
          
              if (sender.backgroundImage(for: .normal)!.pngData() == imagecomparison) {
                  
                  sender.isEnabled = false
                  
                if (pointtimeduration <= 3) {totalpoints += 5}
                else if (pointtimeduration > 3 && pointtimeduration <= 7) {totalpoints += 4}
                else if (pointtimeduration > 7) {totalpoints += 3}
                
                  
                  pointtimeduration = 0
                  countdown -= 1
                
                let audioPath = Bundle.main.path(forResource: "cheer", ofType: "wav")
                
                do{
                    
                    cheerSoundPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                }
                catch{
                }
                
                cheerSoundPlayer.play()
                
                
              
                  if (guesstag == 0) {
                      button1.isEnabled = false
                         }
                         
                         else if (guesstag == 1) {
                             button2.isEnabled = false
                         }
                         
                         else if (guesstag == 2) {
                             button3.isEnabled = false
                         }
                         
                        else if (guesstag == 3) {
                            button4.isEnabled = false
                        }
                        
                        else if (guesstag == 4) {
                            button5.isEnabled = false
                        }
                       else if (guesstag == 5) {
                           button6.isEnabled = false
                       }
                       
                       else if (guesstag == 6) {
                           button7.isEnabled = false
                       }
                    else if (guesstag == 7) {
                        button8.isEnabled = false
                    }
                    
                    else if (guesstag == 8) {
                        button9.isEnabled = false
                    }
                    else if (guesstag == 9) {
                        button10.isEnabled = false
                    }
                    
                    else if (guesstag == 10) {
                        button11.isEnabled = false
                    }
                    else if (guesstag == 11) {
                        button12.isEnabled = false
                    }
                    
                    else if (guesstag == 12) {
                        button13.isEnabled = false
                    }
                    else if (guesstag == 13) {
                        button14.isEnabled = false
                    }
                    
                    else if (guesstag == 14) {
                        button15.isEnabled = false
                    }
                    else if (guesstag == 15) {
                        button16.isEnabled = false
                    }
                    
                    else if (guesstag == 16) {
                        button17.isEnabled = false
                    }
                    else if (guesstag == 17) {
                        button18.isEnabled = false
                    }
                    
                    else if (guesstag == 18) {
                        button19.isEnabled = false
                    }
                         else {
                             button20.isEnabled = false
                         }
                
                if (countdown == 0) {memorycountdown.invalidate()
                    timer2.invalidate()
                    youwin()}
                  
              }
              
              else {
                
                button1.isUserInteractionEnabled = false
                button2.isUserInteractionEnabled = false
                button3.isUserInteractionEnabled = false
                button4.isUserInteractionEnabled = false
                button5.isUserInteractionEnabled = false
                button6.isUserInteractionEnabled = false
                button7.isUserInteractionEnabled = false
                button8.isUserInteractionEnabled = false
                button9.isUserInteractionEnabled = false
                button10.isUserInteractionEnabled = false
                button11.isUserInteractionEnabled = false
                button12.isUserInteractionEnabled = false
                button13.isUserInteractionEnabled = false
                button14.isUserInteractionEnabled = false
                button15.isUserInteractionEnabled = false
                button16.isUserInteractionEnabled = false
                button17.isUserInteractionEnabled = false
                button18.isUserInteractionEnabled = false
                button19.isUserInteractionEnabled = false
                button20.isUserInteractionEnabled = false
                 
                timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGame.reset), userInfo: nil, repeats: false)
          
                  
          
                  
              }
              
          
          }
          
    
      }
      
      // this is the function to reset the buttons
    
      @objc func reset() {
        
        button1.isUserInteractionEnabled = true
        button2.isUserInteractionEnabled = true
        button3.isUserInteractionEnabled = true
        button4.isUserInteractionEnabled = true
        button5.isUserInteractionEnabled = true
        button6.isUserInteractionEnabled = true
        button7.isUserInteractionEnabled = true
        button8.isUserInteractionEnabled = true
        button9.isUserInteractionEnabled = true
        button10.isUserInteractionEnabled = true
        button11.isUserInteractionEnabled = true
        button12.isUserInteractionEnabled = true
        button13.isUserInteractionEnabled = true
        button14.isUserInteractionEnabled = true
        button15.isUserInteractionEnabled = true
        button16.isUserInteractionEnabled = true
        button17.isUserInteractionEnabled = true
        button18.isUserInteractionEnabled = true
        button19.isUserInteractionEnabled = true
        button20.isUserInteractionEnabled = true
        
         
          if (waittag == 0) {
            button1.setImage(buttonquestion, for: .normal)
               }
               
               else if (waittag == 1) {
                   button2.setImage(buttonquestion, for: .normal)
               }
               
               else if (waittag == 2) {
                   button3.setImage(buttonquestion, for: .normal)
               }
               
              else if (waittag == 3) {
                  button4.setImage(buttonquestion, for: .normal)
              }
              
              else if (waittag == 4) {
                  button5.setImage(buttonquestion, for: .normal)
              }
             else if (waittag == 5) {
                 button6.setImage(buttonquestion, for: .normal)
             }
             
             else if (waittag == 6) {
                 button7.setImage(buttonquestion, for: .normal)
             }
          else if (waittag == 7) {
              button8.setImage(buttonquestion, for: .normal)
          }
          
          else if (waittag == 8) {
              button9.setImage(buttonquestion, for: .normal)
          }
          else if (waittag == 9) {
              button10.setImage(buttonquestion, for: .normal)
          }
          
          else if (waittag == 10) {
              button11.setImage(buttonquestion, for: .normal)
          }
          else if (waittag == 11) {
              button12.setImage(buttonquestion, for: .normal)
          }
          
          else if (waittag == 12) {
              button13.setImage(buttonquestion, for: .normal)
          }
          else if (waittag == 13) {
              button14.setImage(buttonquestion, for: .normal)
          }
          
          else if (waittag == 14) {
              button15.setImage(buttonquestion, for: .normal)
          }
          else if (waittag == 15) {
              button16.setImage(buttonquestion, for: .normal)
          }
          
          else if (waittag == 16) {
              button17.setImage(buttonquestion, for: .normal)
          }
          else if (waittag == 17) {
              button18.setImage(buttonquestion, for: .normal)
          }
          
          else if (waittag == 18) {
              button19.setImage(buttonquestion, for: .normal)
          }
               else {
                   button20.setImage(buttonquestion, for: .normal)
               }
          
          if (guesstag == 0) {
            button1.setImage(buttonquestion, for: .normal)
               }
               
               else if (guesstag == 1) {
                   button2.setImage(buttonquestion, for: .normal)
               }
               
               else if (guesstag == 2) {
                   button3.setImage(buttonquestion, for: .normal)
               }
               
              else if (guesstag == 3) {
                  button4.setImage(buttonquestion, for: .normal)
              }
              
              else if (guesstag == 4) {
                  button5.setImage(buttonquestion, for: .normal)
              }
             else if (guesstag == 5) {
                 button6.setImage(buttonquestion, for: .normal)
             }
             
             else if (guesstag == 6) {
                 button7.setImage(buttonquestion, for: .normal)
             }
          else if (guesstag == 7) {
              button8.setImage(buttonquestion, for: .normal)
          }
          
          else if (guesstag == 8) {
              button9.setImage(buttonquestion, for: .normal)
          }
          else if (guesstag == 9) {
              button10.setImage(buttonquestion, for: .normal)
          }
          
          else if (guesstag == 10) {
              button11.setImage(buttonquestion, for: .normal)
          }
          else if (guesstag == 11) {
              button12.setImage(buttonquestion, for: .normal)
          }
          
          else if (guesstag == 12) {
              button13.setImage(buttonquestion, for: .normal)
          }
          else if (guesstag == 13) {
              button14.setImage(buttonquestion, for: .normal)
          }
          
          else if (guesstag == 14) {
              button15.setImage(buttonquestion, for: .normal)
          }
          else if (guesstag == 15) {
              button16.setImage(buttonquestion, for: .normal)
          }
          
          else if (guesstag == 16) {
              button17.setImage(buttonquestion, for: .normal)
          }
          else if (guesstag == 17) {
              button18.setImage(buttonquestion, for: .normal)
          }
          
          else if (guesstag == 18) {
              button19.setImage(buttonquestion, for: .normal)
          }
               else {
                   button20.setImage(buttonquestion, for: .normal)
               }
          
      }
    
    //this is for when you win the game
    
    func youwin() {
        // Declare Alert
        let Message = UIAlertController(title: "Congratulations", message: "Do you want to play again?", preferredStyle: .alert)

        // Create Yes button with action handler
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
             print("Yes button click...")
            self.memorycountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGame.memtimeaction), userInfo: nil, repeats: true)
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
            self.memorycountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGame.memtimeaction), userInfo: nil, repeats: true)
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
            memorycountdown.invalidate()
            timer2.invalidate()
            
        }
    }
    

}
