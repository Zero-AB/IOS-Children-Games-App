//
//  PopGame.swift
//  Assignment3
//
//  Created by Andrew Bell on 3/11/20.
//  Copyright © 2020 Andrew Bell. All rights reserved.
//

import UIKit
import AVFoundation

class PopGame: UIViewController {
    
    let poplabel = UILabel()
    let poptitle = UIView()
    
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
    
    let brown = UIImage(named: "color1")
    let orange = UIImage(named: "color2")
    let red = UIImage(named: "color3")
    let blue = UIImage(named: "color4")
    let green = UIImage(named: "color5")
    let yellow = UIImage(named: "color6")
    let white = UIImage(named: "color7")
    let purple = UIImage(named: "color8")
    let black = UIImage(named: "color9")
    let pink = UIImage(named: "color10")
    let star = UIImage(named: "star")
    let bomb = UIImage(named: "bomb")
    let skull = UIImage(named: "skull")
    
    var numimgs = [UIImage?]()
    
    var balloonbutton = UIButton()
    
    var popSoundPlayer = AVAudioPlayer()
    
    var poppingdifficulty = 0
    
    var poptimeduration = 0
    var poppointtimeduration = 0
    var popcountdown = Timer()
    var poptimer = Timer()
    var poptimer2 = Timer()
    var poptotalpoints = 0
    
    var poparrayKey = 0
    var numarrayKey = 0
    var randomlocationarrayKey = 0
    var balloonimage = UIImage()
    
    var ballooncount = 0
    
    var balloonarrayBtn: [UIButton] = []

    var t = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //for popping navigation title
        
        poplabel.text = "Balloons Game"
        poplabel.sizeToFit()
        poplabel.center = poptitle.center
        poplabel.textAlignment = NSTextAlignment.center
        poptitle.addSubview(poplabel)
        self.navigationItem.titleView = poptitle
        poptitle.sizeToFit()
        
        //check difficulty
        
        print("Popping Difficulty: \(poppingdifficulty)")
        
        //set background of popping game
        
        let poppingbackgroundImage = UIImage.init(named: "sky-background")
        let poppingbackgroundImageView = UIImageView.init(frame: self.view.frame)

        poppingbackgroundImageView.image = poppingbackgroundImage
        poppingbackgroundImageView.contentMode = .scaleAspectFill
        

        self.view.insertSubview(poppingbackgroundImageView, at: 0)
        
        //set timer image to top left corner
        
        let memoryt = "time"
        let memorytimer = UIImage(named: memoryt)
        let memorytimerimageView = UIImageView(image: memorytimer!)
        
        memorytimerimageView.frame = CGRect(x: 10, y: 65, width: 110, height: 50)
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
        
        poptimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PopGame.timeraction), userInfo: nil, repeats: true)
        
        
        if (poppingdifficulty == 1) {popcountdown = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
        else if (poppingdifficulty == 2) {popcountdown = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
        else if (poppingdifficulty == 3) {popcountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
        
        
        
        
        //create timer for balloon movement
        
        if (poppingdifficulty == 1) {poptimer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
        else if (poppingdifficulty == 2) {poptimer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
        else if (poppingdifficulty == 3) {poptimer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
        
        
        //set timer based on difficulty
        
        if (poppingdifficulty == 1) {poptimeduration = 60}
        else if (poppingdifficulty == 2) {poptimeduration = 45}
        else if (poppingdifficulty == 3) {poptimeduration = 30}
        
        //call timer function class and display next to timer image
        
        let ptc = timercd()
        self.view.addSubview(ptc)
        
        //call point count function and display next to score image
        
        let ppc = countingpoints()
        self.view.addSubview(ppc)
        
        // add balloon to start game
        
        addballoon()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("did appear")
        
        poppointtimeduration = 0
        
        poptotalpoints = 0
        
        //set timer based on difficulty
        
        if (poppingdifficulty == 1) {poptimeduration = 60}
        else if (poppingdifficulty == 2) {poptimeduration = 45}
        else if (poppingdifficulty == 3) {poptimeduration = 30}
        
        //call timer function class and display next to timer image
        
        let ptc = timercd()
        self.view.addSubview(ptc)
        
        //call point count function and display next to score image
        
        let ppc = countingpoints()
        self.view.addSubview(ppc)
        
        // add balloon to start game
        
        t = 0
        
        while t < ballooncount {
            balloonarrayBtn[self.t].removeFromSuperview()
                
           t += 1
                
            }
        
        
        addballoon()
        
        
        
       
       
    }
    
    
    
    
    
    
    
    func timercd() -> UIImageView{
        
        semicolon.text = ":"
        semicolon.font = semicolon.font.withSize(35)
        var minutessection = UIImageView()
        var tensecondssection = UIImageView()
        var secondssection = UIImageView()
    
        //change the minute section based on timer
        if (poptimeduration >= 120) {minutessection = UIImageView(image: two!)}
        else if (poptimeduration < 120 && poptimeduration >= 60) {minutessection = UIImageView(image: one!)}
        else {minutessection = UIImageView(image: zero!)}
        
        //change the ten seconds based on timer
        if (((poptimeduration % 60)/10) == 0) {tensecondssection = UIImageView(image: zero!)}
        else if (((poptimeduration % 60)/10) == 1) {tensecondssection = UIImageView(image: one!)}
        else if (((poptimeduration % 60)/10) == 2) {tensecondssection = UIImageView(image: two!)}
        else if (((poptimeduration % 60)/10) == 3) {tensecondssection = UIImageView(image: three!)}
        else if (((poptimeduration % 60)/10) == 4) {tensecondssection = UIImageView(image: four!)}
        else if (((poptimeduration % 60)/10) == 5) {tensecondssection = UIImageView(image: five!)}
        else {tensecondssection = UIImageView(image: six!)}
        
        //change the seconds based on timer
        if (poptimeduration % 10 == 0) {secondssection = UIImageView(image: zero!)}
        else if (poptimeduration % 10 == 1) {secondssection = UIImageView(image: one!)}
        else if (poptimeduration % 10 == 2) {secondssection = UIImageView(image: two!)}
        else if (poptimeduration % 10 == 3) {secondssection = UIImageView(image: three!)}
        else if (poptimeduration % 10 == 4) {secondssection = UIImageView(image: four!)}
        else if (poptimeduration % 10 == 5) {secondssection = UIImageView(image: five!)}
        else if (poptimeduration % 10 == 6) {secondssection = UIImageView(image: six!)}
        else if (poptimeduration % 10 == 7) {secondssection = UIImageView(image: seven!)}
        else if (poptimeduration % 10 == 8) {secondssection = UIImageView(image: eight!)}
        else {secondssection = UIImageView(image: nine!)}
            
        semicolon.frame = CGRect(x: 40, y: -2, width: 15, height: 35)
        minutessection.frame = CGRect(x: 10, y: 0, width: 25, height: 35)
        tensecondssection.frame = CGRect(x: 60, y: 0, width: 25, height: 35)
        secondssection.frame = CGRect(x: 90, y: 0, width: 25, height: 35)
        minutessection.contentMode = .scaleAspectFit
        tensecondssection.contentMode = .scaleAspectFit
        secondssection.contentMode = .scaleAspectFit
        
        let poptimercountdown = UIImageView(frame: CGRect(x: 125, y: 72, width: 125, height: 38))
        poptimercountdown.backgroundColor = UIColor(red: 0.4863, green: 0.8627, blue: 0.9765, alpha: 1.0)
        poptimercountdown.addSubview(minutessection)
        poptimercountdown.addSubview(semicolon)
        poptimercountdown.addSubview(tensecondssection)
        poptimercountdown.addSubview(secondssection)
        return poptimercountdown
    }
    
    func countingpoints() -> UIImageView{
        
        var hundredpointssection = UIImageView()
        var tenpointssection = UIImageView()
        var singlepointssection = UIImageView()
        
        //change the hundred points section based on total points
        if (((poptotalpoints % 1000)/100) == 0) {hundredpointssection = UIImageView(image: zero!)}
        else if (((poptotalpoints % 1000)/100) == 1) {hundredpointssection = UIImageView(image: one!)}
        else if (((poptotalpoints % 1000)/100) == 2) {hundredpointssection = UIImageView(image: two!)}
        else if (((poptotalpoints % 1000)/100) == 3) {hundredpointssection = UIImageView(image: three!)}
        else if (((poptotalpoints % 1000)/100) == 4) {hundredpointssection = UIImageView(image: four!)}
        else if (((poptotalpoints % 1000)/100) == 5) {hundredpointssection = UIImageView(image: five!)}
        else if (((poptotalpoints % 1000)/100) == 6) {hundredpointssection = UIImageView(image: six!)}
        else if (((poptotalpoints % 1000)/100) == 7) {hundredpointssection = UIImageView(image: seven!)}
        else if (((poptotalpoints % 1000)/100) == 8) {hundredpointssection = UIImageView(image: eight!)}
        else {hundredpointssection = UIImageView(image: nine!)}
        
       
        //change the tens points section based on total points
        if (((poptotalpoints % 100)/10) == 0) {tenpointssection = UIImageView(image: zero!)}
        else if (((poptotalpoints % 100)/10) == 1) {tenpointssection = UIImageView(image: one!)}
        else if (((poptotalpoints % 100)/10) == 2) {tenpointssection = UIImageView(image: two!)}
        else if (((poptotalpoints % 100)/10) == 3) {tenpointssection = UIImageView(image: three!)}
        else if (((poptotalpoints % 100)/10) == 4) {tenpointssection = UIImageView(image: four!)}
        else if (((poptotalpoints % 100)/10) == 5) {tenpointssection = UIImageView(image: five!)}
        else if (((poptotalpoints % 100)/10) == 6) {tenpointssection = UIImageView(image: six!)}
        else if (((poptotalpoints % 100)/10) == 7) {tenpointssection = UIImageView(image: seven!)}
        else if (((poptotalpoints % 100)/10) == 8) {tenpointssection = UIImageView(image: eight!)}
        else {tenpointssection = UIImageView(image: nine!)}
        
        
        //change the single points section based on total points
        if (poptotalpoints % 10 == 0) {singlepointssection = UIImageView(image: zero!)}
        else if (poptotalpoints % 10 == 1) {singlepointssection = UIImageView(image: one!)}
        else if (poptotalpoints % 10 == 2) {singlepointssection = UIImageView(image: two!)}
        else if (poptotalpoints % 10 == 3) {singlepointssection = UIImageView(image: three!)}
        else if (poptotalpoints % 10 == 4) {singlepointssection = UIImageView(image: four!)}
        else if (poptotalpoints % 10 == 5) {singlepointssection = UIImageView(image: five!)}
        else if (poptotalpoints % 10 == 6) {singlepointssection = UIImageView(image: six!)}
        else if (poptotalpoints % 10 == 7) {singlepointssection = UIImageView(image: seven!)}
        else if (poptotalpoints % 10 == 8) {singlepointssection = UIImageView(image: eight!)}
        else {singlepointssection = UIImageView(image: nine!)}
        
        hundredpointssection.frame = CGRect(x: 30, y: 0, width: 25, height: 35)
        tenpointssection.frame = CGRect(x: 60, y: 0, width: 25, height: 35)
        singlepointssection.frame = CGRect(x: 90, y: 0, width: 25, height: 35)
        singlepointssection.contentMode = .scaleAspectFit
        tenpointssection.contentMode = .scaleAspectFit
        hundredpointssection.contentMode = .scaleAspectFit
        
        if (poptotalpoints < 100) {hundredpointssection.isHidden = true}
        else if (poptotalpoints >= 100) {hundredpointssection.isHidden = false}
        
        if (poptotalpoints < 10) {tenpointssection.isHidden = true}
        else if (poptotalpoints >= 10) {tenpointssection.isHidden = false}
        
        let poppointcount = UIImageView(frame: CGRect(x: 895, y: 72, width: 125, height: 38))
        poppointcount.backgroundColor = UIColor(red: 0.4863, green: 0.8627, blue: 0.9765, alpha: 1.0)
        poppointcount.addSubview(singlepointssection)
        poppointcount.addSubview(tenpointssection)
        poppointcount.addSubview(hundredpointssection)
        return poppointcount
        
    }
    
    //this is for adding ballons
    
    func addballoon() {
        let balloonimgs = [brown, orange, red, blue, green, yellow, white, purple, black, pink]
        if (poppingdifficulty == 1) {numimgs = [one, two, three, four, five, six, seven, eight, nine]}
        else if (poppingdifficulty == 2) {numimgs = [one, two, three, four, five, six, seven]}
        else if (poppingdifficulty == 3) {numimgs = [one, two, three, four, five]}
    
        var balloonnumber = UIImage()
        
        randomlocationarrayKey = Int(arc4random_uniform(UInt32(10)))
        poparrayKey = Int(arc4random_uniform(UInt32(balloonimgs.count)))
        numarrayKey = Int(arc4random_uniform(UInt32(numimgs.count)))
        
        let balloonbuttonname = "buttonName" + String(ballooncount)
        let balloonbuttoncreate = createNewBalloonButton(buttonName: balloonbuttonname)
        balloonbuttoncreate.tag = numarrayKey + 1
        balloonbuttoncreate.addTarget(self, action: #selector(buttonclick(_:)), for: .touchUpInside)
        
        balloonarrayBtn.append(balloonbuttoncreate)
        
        balloonbutton = balloonarrayBtn[ballooncount]
        
        ballooncount += 1
        
        balloonnumber = numimgs[numarrayKey]!
        
        
        
        let balloonnumberimageView = UIImageView(image: balloonnumber)
        
        balloonnumberimageView.frame = CGRect(x: 20, y: 10, width: 45, height: 45)
        balloonnumberimageView.contentMode = .scaleAspectFit

        
        if (randomlocationarrayKey == 0) {
        balloonbutton.frame = CGRect(x: 20, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
            
        
            
        }
        
        else if (randomlocationarrayKey == 1) {
        balloonbutton.frame = CGRect(x: 120, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)

            

    
    
            
        }
        
        else if (randomlocationarrayKey == 2) {
        balloonbutton.frame = CGRect(x: 220, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
          
            
        }
        
        else if (randomlocationarrayKey == 3) {
        balloonbutton.frame = CGRect(x: 320, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
           
            
        }
        
        else if (randomlocationarrayKey == 4) {
        balloonbutton.frame = CGRect(x: 420, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
           
           
            
        }
        
        else if (randomlocationarrayKey == 5) {
        balloonbutton.frame = CGRect(x: 520, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
            
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
          
            
        }
        
        else if (randomlocationarrayKey == 6) {
        balloonbutton.frame = CGRect(x: 620, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
            
            
        }
        
        else if (randomlocationarrayKey == 7) {
        balloonbutton.frame = CGRect(x: 720, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
           
            
        }
        
        else if (randomlocationarrayKey == 8) {
        balloonbutton.frame = CGRect(x: 820, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
            
            
        }
        
        else if (randomlocationarrayKey == 9) {
        balloonbutton.frame = CGRect(x: 920, y: 800, width: 90, height: 90)
        balloonimage = balloonimgs[poparrayKey]!
        balloonbutton.setImage(balloonimage, for: .normal)
        balloonbutton.contentMode = .scaleAspectFit
        
            
        balloonbutton.addSubview(balloonnumberimageView)
        self.view.addSubview(balloonbutton)
            
            
        }
        
        
        
        
    }
    
    //this is for creating a new balloon button
    
    func createNewBalloonButton(buttonName: String) -> UIButton {
        let myButton = UIButton()
        return myButton
    }
    
    //this is for clicking the balloons
    
    @objc func buttonclick(_ sender: UIButton) {
        
        poppointtimeduration = 0
        
        print("tag = \(sender.tag)")
        
        sender.isHidden = true
        poptotalpoints += sender.tag
        
        let audioPath = Bundle.main.path(forResource: "pop", ofType: "wav")
        
        do{
            
            popSoundPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch{
        }
        
        popSoundPlayer.play()
        
        
        
        
        
    }
    
    //this is for balloon movement
    
    func balloonmovement() {
        
        t = 0
        
        if (poppingdifficulty == 1) {
        while t < ballooncount {
            UIButton.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.balloonarrayBtn[self.t].frame = CGRect(x: self.balloonarrayBtn[self.t].frame.origin.x + 0, y: self.balloonarrayBtn[self.t].frame.origin.y - 10, width: self.balloonarrayBtn[self.t].frame.size.width, height: self.balloonarrayBtn[self.t].frame.size.height)
            }, completion: nil)
                
        
           t += 1
                
            }
        }
        
        else if (poppingdifficulty == 2) {
        while t < ballooncount {
            UIButton.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.balloonarrayBtn[self.t].frame = CGRect(x: self.balloonarrayBtn[self.t].frame.origin.x + 0, y: self.balloonarrayBtn[self.t].frame.origin.y - 10, width: self.balloonarrayBtn[self.t].frame.size.width, height: self.balloonarrayBtn[self.t].frame.size.height)
            }, completion: nil)
                
        
           t += 1
                
            }
        }
        
        
        else if (poppingdifficulty == 3) {
        while t < ballooncount {
            UIButton.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveLinear], animations: {
                self.balloonarrayBtn[self.t].frame = CGRect(x: self.balloonarrayBtn[self.t].frame.origin.x + 0, y: self.balloonarrayBtn[self.t].frame.origin.y - 10, width: self.balloonarrayBtn[self.t].frame.size.width, height: self.balloonarrayBtn[self.t].frame.size.height)
            }, completion: nil)
                
        
           t += 1
                
            }
        }
        
        
        
        
        
    }
    

    //this is for the time action

    @objc func poptimeaction() {
        
    
        addballoon()
        
        
       
        
    }
    
    
    @objc func timeraction() {
        poptimeduration -= 1
        poppointtimeduration += 1
        //print("\(sorttimeduration)")
        
        
        let ptc = timercd()
        self.view.addSubview(ptc)
        
        let ppc = countingpoints()
        self.view.addSubview(ppc)
        
        
        if (poptimeduration <= 0) {popcountdown.invalidate()
            poptimer2.invalidate()
            poptimer.invalidate()
            youwin()
        }
        
        if (poppointtimeduration >= 10) {popcountdown.invalidate()
            poptimer2.invalidate()
            poptimer.invalidate()
            youlose()}
        
       
        
    }
    
    
    
    @objc func balloonmovementaction() {
        
        balloonmovement()
        
       
        
    }
    
    
    func youwin() {
        // Declare Alert
        let Message = UIAlertController(title: "Congratulations", message: "Do you want to play again?", preferredStyle: .alert)

        // Create Yes button with action handler
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
             print("Yes button click...")
            
            self.poptimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PopGame.timeraction), userInfo: nil, repeats: true)
                   
                   
            if (self.poppingdifficulty == 1) {self.popcountdown = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 2) {self.popcountdown = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 3) {self.popcountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
                   
                   
                   
                   
                   //create timer for balloon movement
                   
            if (self.poppingdifficulty == 1) {self.poptimer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 2) {self.poptimer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 3) {self.poptimer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
            
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
            
            self.poptimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PopGame.timeraction), userInfo: nil, repeats: true)
                   
                   
            if (self.poppingdifficulty == 1) {self.popcountdown = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 2) {self.popcountdown = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 3) {self.popcountdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PopGame.poptimeaction), userInfo: nil, repeats: true)}
                   
                   
                   
                   
                   //create timer for balloon movement
                   
            if (self.poppingdifficulty == 1) {self.poptimer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 2) {self.poptimer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
            else if (self.poppingdifficulty == 3) {self.poptimer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PopGame.balloonmovementaction), userInfo: nil, repeats: true)}
                   
           
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
            popcountdown.invalidate()
            poptimer2.invalidate()
            poptimer.invalidate()
        }
    }

}
