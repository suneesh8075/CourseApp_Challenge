//
//  HomeViewModel.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import Foundation
import UIKit

protocol CourseListViewModelDelegate {
    func  fetchCourseDelegate()
    func fetchRecomendedCourseDelegate()
}

class CourseListViewModel {
    var delegate: CourseListViewModelDelegate?
    private var courseList: [CourseDetails] = []
    private var profileVM = ProfileViewModel()
    private var recomendedCourseList: [CourseDetails] = []
    func fetchCourses() {
        courseList = self.readJSONFile(forName: "CourseList")
    }
    
    func readJSONFile(forName name: String) -> [CourseDetails]{
       do {
          if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             let course = try JSONDecoder().decode([CourseDetails].self, from: jsonData)
              //print("Product name: \(course.first?.courseName ?? "") and its price: \(course.last?.courseName ?? "")")
              self.delegate?.fetchCourseDelegate()
              return course
          }
       } catch {
          print(error)
       }
        return []
    }
    func numberOfCourses() -> Int {
        return courseList.count
    }
    
    func courseAt(at index: Int) -> CourseDetails {
        return courseList[index]
    }
    func courseWithId(at id: Int) -> CourseDetails? {
        return courseList.filter{ $0.courseId == id }.first
    }
    func recomendedCourseWithId(at index: Int) -> CourseDetails? {
        return recomendedCourseList[index]
    }
    func recommendedCourseGet(){
        let enrolledCourses = profileVM.fetchUserEnrolledCourses()
        let recoCourses = courseList.filter{ !enrolledCourses.contains($0.courseId)}
        recomendedCourseList = recoCourses.filter{ $0.courseCategory == "Mathematics" || $0.courseCategory == "IT" || $0.courseCategory == "Physics"}
        print(recomendedCourseList.count)
        self.delegate?.fetchRecomendedCourseDelegate()
        
    }
    func getCell(listTable: UITableView, index: IndexPath) -> UITableViewCell {
        let cell = listTable.dequeueReusableCell(withIdentifier: "MainTableCellTableViewCell", for: index) as! MainTableCellTableViewCell
        let course = self.courseAt(at: index.item)
        cell.courseNameLabel.text = course.courseName
        cell.instructorNameLabel.text = "Instructor: \(course.courseInstructor)"
        cell.durationLabel.text = "Duration: \(course.courseDuration) Hrs"
        cell.courseDescriptionLabel.text = course.courseSummary
        cell.likeCountLabel.text = "\(course.courseLikedUsers)"
        cell.progressView.isHidden = true
        return cell
    }
    
    func getCellProfileList(listTable: UITableView, index: IndexPath, courseId: Int) -> UITableViewCell {
        let cell = listTable.dequeueReusableCell(withIdentifier: "MainTableCellTableViewCell", for: index) as! MainTableCellTableViewCell
        let course = self.courseWithId(at: courseId)
        //self.courseAt(at: index.item)
        cell.courseNameLabel.text = course?.courseName
        cell.instructorNameLabel.text = "Instructor: \(course?.courseInstructor ?? "")"
        cell.durationLabel.text = "Duration: \(course?.courseDuration ?? 0) Hrs"
        cell.courseDescriptionLabel.text = course?.courseSummary ?? ""
        cell.likesView.isHidden = true
        return cell
    }
    func getRecomendedCourseCount() -> Int{
        return recomendedCourseList.count 
    }
    func getRecomendedCoursesCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HCategoryCollectionViewCell", for: indexPath) as! HCategoryCollectionViewCell
        cell.courseTitleLabel.text = recomendedCourseList[indexPath.item].courseName
        cell.courseInstructor.text = "by \(recomendedCourseList[indexPath.item].courseInstructor)"
        cell.courseDurationLabel.text = "\(recomendedCourseList[indexPath.item].courseDuration) Hrs"
        cell.courseDetails.text = recomendedCourseList[indexPath.item].courseSummary
        return cell
    }
}
    
