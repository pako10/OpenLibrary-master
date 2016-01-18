//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Francisco Humberto Andrade Gonzalez on 17/01/16.
//  Copyright © 2016 Francisco Humberto Andrade Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tvDescripcion: UITextView!
    @IBOutlet weak var txtISBN: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtISBN.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buscarISBN(sender: UITextField){
        sender.resignFirstResponder()

        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + sender.text!
        let url = NSURL(string: urls)

        let datos: NSData? = NSData(contentsOfURL: url!)
        if(datos != nil){
            let json = NSString(data:datos!, encoding: NSUTF8StringEncoding)
            self.tvDescripcion.text = String(json)
        } else {
            alertaDeError()
        }
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        txtISBN.resignFirstResponder()
    }
    
    func alertaDeError(){
        let alerta = UIAlertController(title: "Error de conexión", message: "Ha habido un error al tratar de obtener la información relacionada al ISBN. Verifica tu conexión a internet.", preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            alerta.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alerta, animated: true, completion: nil)
    }
}

