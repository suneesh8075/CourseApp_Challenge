//
//  ProfileViewModel.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import Foundation
protocol ProfileViewModelDelegate {
    func  fetchUserDelegate()
}
class ProfileViewModel {
    var delegate: ProfileViewModelDelegate?
    var user: UserDetails?
    
    func fetchUser() -> UserDetails? {
        user = self.readJSONFile(forName: "User").first
        return user
    }
    func readJSONFile(forName name: String) -> [UserDetails]{
       do {
          if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             let userData = try JSONDecoder().decode(UserDetails.self, from: jsonData)
              print("Product name: \(userData.firstName ?? "") and its price: \(userData.lastName ?? "")")
              self.delegate?.fetchUserDelegate()
              return [userData]
          }
       } catch {
          print(error)
       }
        return []
    }
    func fetchUserEnrolledCourses() -> [Int] {
        let userCourses = self.readJSONFile(forName: "User").first?.enrolledCourses ?? []
        return userCourses
    }

    func writeUserJsonFile(updatedEnrolledCourses: [Int]){

    }
}
