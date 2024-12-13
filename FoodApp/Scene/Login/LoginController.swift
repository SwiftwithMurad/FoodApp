//
//  LoginController.swift
//  FoodApp
//
//  Created by Mac on 07.12.24.
//

import UIKit
import Lottie

class LoginController: UIViewController {
    @IBOutlet private weak var foodAnimation: LottieAnimationView!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    
    let manager = UserDefaultsManager()
    var users: [User] = []
    let register = RegisterController()
    override func viewDidLoad() {
        super.viewDidLoad()

        foodAnimation.play()
        foodAnimation.loopMode = .loop
    }
 
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailField.text, !email.isEmpty,
           let password = passwordField.text, !password.isEmpty {
            if users.contains(where: { $0.email == email && $0.password == password }) {
                manager.setValue(value: true, key: .isLoggedIn)
                manager.setValue(value: email, key: .email)
                let controller = storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                navigationController?.show(controller, sender: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Enter correct information", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(action)
                present(alertController, animated: true)
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        controller.sendDataToLogin = { User in
            self.emailField.text = User.email
            self.passwordField.text = User.password
            self.users.append(User)
        }
        navigationController?.show(controller, sender: nil)
    }
    
    func readData() {
        do {
            let data = try Data(contentsOf: getFilePath())
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("UserData.json")
        print(path)
        return path
    }
}


        
        
