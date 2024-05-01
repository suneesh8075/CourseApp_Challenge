//
//  CourseModel.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import Foundation

struct CourseDetails: Codable {
    let courseId: Int
    let courseName: String
    let courseDuration: Int
    let courseCategory: String
    let courseTopics: [String]
    let courseSummary: String
    let courseEnrolledUsers: Int
    let courseLikedUsers: Int
    let courseInstructor: String
    let courseVideoURL: String
    let courseVideoURLThumbnail: String
}
