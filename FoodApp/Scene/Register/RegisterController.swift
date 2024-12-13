//
//  RegisterController.swift
//  FoodApp
//
//  Created by Mac on 07.12.24.
//

import UIKit
import Lottie

class RegisterController: UIViewController {

    @IBOutlet private weak var foodAnimation: LottieAnimationView!
    @IBOutlet private weak var numberField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var nameField: UITextField!
    
    var sendDataToLogin: ((User) -> Void)?
    var users: [User] = []
    let manager = UserDefaultsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberField.keyboardType = .phonePad
        passwordField.isSecureTextEntry = true
        emailField.keyboardType = .emailAddress
        
        
        foodAnimation.play()
        foodAnimation.loopMode = .loop
        
        readData()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if let name = nameField.text, !name.isEmpty,
           let email = emailField.text, !email.isEmpty,
           let password = passwordField.text, !password.isEmpty,
           let number = numberField.text, !number.isEmpty {
            let user: User = .init(username: name, email: email, password: password, phoneNumber: number)
                sendDataToLogin?(.init(username: user.username, email: user.email, password: user.password, phoneNumber: user.phoneNumber))
                users.append(user)
                writeData(user: users)
                navigationController?.popViewController(animated: true)
        }
    }
}



extension RegisterController {
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
    
    func writeData(user: [User]) {
        do {
            let data = try JSONEncoder().encode(user)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
}
