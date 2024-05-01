//
//  ProfileViewController.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import UIKit

class ProfileViewController: UIViewController , ProfileViewModelDelegate, CourseListViewModelDelegate {
    func fetchRecomendedCourseDelegate() {
        
    }
    
    func fetchCourseDelegate() {
        
    }
    
    func fetchUserDelegate() {
        
    }
    @IBOutlet private weak var profileimageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var mobileLabel: UILabel!
    @IBOutlet private weak var enrolledCourseTableView: UITableView!
    @IBOutlet private weak var interestsCollectionView: UICollectionView!
    var viewModel = ProfileViewModel()
    var courseViewModel = CourseListViewModel()
    var userDeatails: UserDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        userDeatails = viewModel.fetchUser()
        courseViewModel.fetchCourses()
        self.nameLabel.text = "\(userDeatails?.firstName ?? "") \(userDeatails?.lastName ?? "")"
        self.classLabel.text = userDeatails?.classLevel
        self.emailLabel.text = userDeatails?.email
        self.mobileLabel.text = userDeatails?.mobile
        
    }
    func initView(){
        viewModel.delegate = self
        interestsCollectionView.dataSource = self
        interestsCollectionView.delegate = self
        enrolledCourseTableView.dataSource = self
        enrolledCourseTableView.delegate = self
        enrolledCourseTableView.register(UINib(nibName: "MainTableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableCellTableViewCell")
    }
}
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDeatails?.userIntrests.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestsCollectionViewCell", for: indexPath) as! InterestsCollectionViewCell
        cell.interests.text = userDeatails?.userIntrests[indexPath.item]
        return cell
    }
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDeatails?.enrolledCourses.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return courseViewModel.getCellProfileList(listTable: self.enrolledCourseTableView, index: indexPath, courseId: userDeatails?.enrolledCourses[indexPath.item] ?? 0)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseDetailViewController") as! CourseDetailViewController
        courseDetailViewController.courseData = courseViewModel.courseWithId(at: userDeatails?.enrolledCourses[indexPath.item] ?? 0)
        //courseViewModel.courseAt(at: indexPath.item)
        navigationController?.pushViewController(courseDetailViewController, animated: true)
    }
}
