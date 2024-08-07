//
//  MovieDetailViewController.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 30/07/24.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    enum MovieDetailViewControllerConstraints {
        enum BackButton {
            static let top: CGFloat = 10
            static let leading: CGFloat = 10
            static let width: CGFloat = 60
            static let height: CGFloat = 30
        }
        enum MovieDetailUIView {
            static let top: CGFloat = 10
        }
    }
    
    weak var movieCoordinator: MovieCoordinator?
    private let factory: MovieFactory
    private var movie: Movie
    private var viewModel: MovieViewModel
    
    private var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = UIColor(named: GlobalConstants.Color.gray)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var movieDetailUIView: MovieDetailUIView = {
        let view = MovieDetailUIView(frame: .zero)
        view.viewModel = viewModel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init(factory: MovieFactory, movieCoordinator: MovieCoordinator,movie: Movie, viewModel: MovieViewModel) {
        self.factory = factory
        self.movieCoordinator = movieCoordinator
        self.movie = movie
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        initComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: GlobalConstants.Color.green)
    }
    
    func initComponents() {
        addComponents()
        setAutolayout()
        initView()
        setTarget()
    }
    
    func addComponents() {
        view.addSubview(backButton)
        view.addSubview(movieDetailUIView)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MovieDetailViewControllerConstraints.BackButton.top),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MovieDetailViewControllerConstraints.BackButton.leading),
            backButton.widthAnchor.constraint(equalToConstant: MovieDetailViewControllerConstraints.BackButton.width),
            backButton.heightAnchor.constraint(equalToConstant: MovieDetailViewControllerConstraints.BackButton.height),
            
            movieDetailUIView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: MovieDetailViewControllerConstraints.MovieDetailUIView.top),
            movieDetailUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func initView(){
        movieDetailUIView.setMovieDetail(movie: movie)
    }
    
    func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        movieCoordinator?.back()
    }
}
