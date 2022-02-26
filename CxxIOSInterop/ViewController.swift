//
//  ViewController.swift
//  CxxIOSInterop
//
//  Created by Caleb Meurer on 2/25/22.
//

import UIKit
import Cxx

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let result = cxx_function(7)
        print(result)
    }
}

