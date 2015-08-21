//
//  CGAffineTransformTranslateViewController.swift
//  Demo_iOS
//
//  Created by iStig on 15/8/20.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

import UIKit

@objc class CGAffineTransformTranslateViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    
    @IBAction func button1Clicked(sender: UIButton) {
        self.moveButton.transform = CGAffineTransformMakeTranslation(10, 0)
    }
    @IBAction func button2Clicked(sender: UIButton) {
        self.moveButton.transform = CGAffineTransformTranslate(self.moveButton.transform, 10, 0);
    }
    @IBAction func button3Clicked(sender: UIButton) {
        self.moveButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 10, 0);
    }
    @IBAction func button4Clicked(sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//          self.button1.setTranslatesAutoresizingMaskIntoConstraints(false)
//          self.button2.setTranslatesAutoresizingMaskIntoConstraints(false)
//          self.button3.setTranslatesAutoresizingMaskIntoConstraints(false)
//          self.button4.setTranslatesAutoresizingMaskIntoConstraints(false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
          super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
