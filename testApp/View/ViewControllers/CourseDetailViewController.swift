//
//  CourseDetailViewController.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import UIKit
import AVKit
import AVFoundation
class CourseDetailViewController: UIViewController , UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var courseDescriptionLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var instructorNameLabel: UILabel!
    @IBOutlet weak var courseDurationLabel: UILabel!
    @IBOutlet weak var topicsCollectionView: UICollectionView!
    @IBOutlet weak var videoView: UIView!
    var courseData: CourseDetails?
    var profileViewModel = ProfileViewModel()
    var player: AVPlayer!
    var avpController =  AVPlayerViewController()
    @IBOutlet weak var buttonView: RoundedCornerView!
    @IBAction func actionEnrol(_ sender: UIButton) {
        DispatchQueue.main.async{
            self.profileViewModel.writeUserJsonFile(updatedEnrolledCourses: [])
        }
    }
    @IBOutlet weak var enrollButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let path = Bundle.main.path(forResource: "samplevideo", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        avpController.player = player
        avpController.view.frame.size.width = videoView.frame.size.width
        avpController.view.frame.size.height = videoView.frame.size.height
        self.videoView.addSubview(avpController.view)
        player.play()
    }
    func initView(){
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        courseNameLabel.text = courseData?.courseName
        instructorNameLabel.text = "Instructor: \(courseData?.courseInstructor ?? "")"
        courseDurationLabel.text = "Duration: \(courseData?.courseDuration ?? 0) Hrs"
        courseDescriptionLabel.text = courseData?.courseSummary
        let courses = profileViewModel.fetchUserEnrolledCourses()
        if courses.contains(courseData?.courseId ?? 0) {
            self.buttonView.isHidden = true
        } else {
            self.buttonView.isHidden = false
        }
    }
}
extension CourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseData?.courseTopics.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseTopicsCollectionViewCell", for: indexPath) as! CourseTopicsCollectionViewCell
        cell.topicsLabel.text = courseData?.courseTopics[indexPath.item]
        cell.imageThumbnailView.imageFrom(url: URL(string: "https://www.firstintuition.co.uk/wp-content/uploads/2023/03/The-Advantages-of-Classroom-Courses-2.png")!)
        cell.topicDuration.text = "Duration 30 Mins"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
    }

}
