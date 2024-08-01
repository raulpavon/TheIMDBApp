//
//  MovieListViewController.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    weak var movieCoordinator: MovieCoordinator?
    private let factory: MovieFactory
    var currentPage = 1
    let totalPages = 500
    
    lazy var movieListUIView: MovieListUIView = {
        let view = MovieListUIView(frame: .zero)
        view.delegate = self
        view.viewModel = viewModel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewModel: MovieViewModel = {
        factory.makeMovieViewModel(view: self, repository: factory.makeMovieRepository())
    }()

    required init(factory: MovieFactory, movieCoordinator: MovieCoordinator) {
        self.factory = factory
        self.movieCoordinator = movieCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: GlobalConstants.Color.green)
        initComponents()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieList(page: currentPage)
    }
    
    func initComponents() {
        addComponents()
        setAutolayout()
    }
    
    func addComponents() {
        view.addSubview(movieListUIView)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            movieListUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MovieListViewController: MovieView {
    func setMovie(movie: [Movie]) {
        movieListUIView.loadMovies(movies: movie)
    }
    
    func goToMovieDetail(movie: Movie) {
        movieCoordinator?.openMovieDetail(movie: movie, viewModel: viewModel)
    }
}

extension MovieListViewController: MovieListUIViewDelegate {
    func getMovieDetails(movie: Movie) {
        goToMovieDetail(movie: movie)
    }
    
    func didScroll() {
        guard currentPage < totalPages else { return }
        currentPage += 1
        viewModel.getMovieList(page: currentPage)
    }
}
