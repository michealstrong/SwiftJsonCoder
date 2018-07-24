//
//  HomeViewController.swift
//  SwiftJsonCoder
//
//  Created by laigaoqiang on 2018/7/23.
//  Copyright © 2018年 Ligo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        label.backgroundColor = UIColor.red
        label.text = "123"
        self.view.addSubview(label)
        // Do any additional setup after loading the view.
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 100, y: 300, width: 80, height: 80)
        button.backgroundColor = UIColor.green
        button.setTitle("button", for: .normal)
        self.view.addSubview(button)
        print("注释")
        
    }
    
    func createView(addTo superView: UIView!, _ frame: CGRect?) -> UIView?
    {
        
        let tmp = UIView.init()
        if let rect = frame {
            tmp.frame = rect
        }
        tmp.backgroundColor = UIColor.gray
        superView.addSubview(tmp)
        print("Create")
        return tmp
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
