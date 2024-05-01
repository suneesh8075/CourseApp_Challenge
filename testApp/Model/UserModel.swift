//
//  UserModel.swift
//  testApp
//
//  Created by Suneeshkumar K S on 26/04/2024.
//

import Foundation

struct UserDetails: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let mobile: String
    let profilePic: String
    let age: Int
    let classLevel: String
    let enrolledCourses: [Int]
    let userIntrests: [String]
}

