//
//  ProfileController.swift
//  FoodApp
//
//  Created by Mac on 11.12.24.
//

import UIKit
import Lottie

class ProfileController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileAnimation: LottieAnimationView!
    
    let manager = UserDefaultsManager()
    var users: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        title = "Profile"
        
        profileAnimation.play()
        profileAnimation.loopMode = .loop
        readData()
        
        if let name = usernameLabel,
           let email = emailLabel,
           let password = passwordLabel,
           let number = numberLabel {
            name.text = "Username: \(users[0].username)"
            email.text = "Email: \(users[0].email)"
            password.text = "Password: \(users[0].password)"
            number.text = "Phone Number: \(users[0].phoneNumber)"
        }
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
