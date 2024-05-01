//
//  CourseListViewController.swift
//  testApp
//
//  Created by Suneeshkumar K S on 30/04/2024.
//

import UIKit

class CourseListViewController: UIViewController {
    
    @IBOutlet private weak var listTableView: UITableView!
    @IBOutlet private weak var favCategoryCollectioView: UICollectionView!
    var viewModel = CourseListViewModel()
    var userViewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchCourses()
        //let user = userViewModel.fetchUser()
        viewModel.recommendedCourseGet()
    }
    func initView(){
        listTableView.delegate = self
        listTableView.dataSource = self
        favCategoryCollectioView.delegate = self
        favCategoryCollectioView.dataSource = self
        viewModel.delegate = self
        listTableView.register(UINib(nibName: "MainTableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableCellTableViewCell")
        favCategoryCollectioView.register(UINib(nibName: "HCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HCategoryCollectionViewCell")
    }
    
}
extension CourseListViewController: CourseListViewModelDelegate {
    func fetchRecomendedCourseDelegate() {
        favCategoryCollectioView.reloadData()
    }
    
    func fetchCourseDelegate() {
        listTableView.reloadData()
    }
}

extension CourseListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCourses()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(listTable: self.listTableView, index: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseDetailViewController") as! CourseDetailViewController
        courseDetailViewController.courseData = viewModel.courseAt(at: indexPath.item)
        navigationController?.pushViewController(courseDetailViewController, animated: true)
    }
}
extension CourseListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRecomendedCourseCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getRecomendedCoursesCell(collectionView: collectionView, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let courseDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseDetailViewController") as! CourseDetailViewController
        courseDetailViewController.courseData = viewModel.recomendedCourseWithId(at: indexPath.item)
        //courseAt(at: indexPath.item)
        navigationController?.pushViewController(courseDetailViewController, animated: true)
    }
}
