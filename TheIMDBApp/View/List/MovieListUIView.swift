//
//  MovieListUIView.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

protocol MovieListUIViewDelegate: AnyObject {
    func getMovieDetails(movie: Movie)
    func didScroll()
}

class MovieListUIView: UIView {
    
    enum MovieListUIViewConstraints {
        enum ImgMovie {
            static let top: CGFloat = 10
            static let height: CGFloat = 80
        }
        enum TableViewMovies {
            static let top: CGFloat = 15
            static let rowHeight: CGFloat = 300
        }
    }
    
    var movies: [Movie] = []
    var selectedIndexPath: IndexPath?
    weak var delegate: MovieListUIViewDelegate?
    var viewModel: MovieViewModel?
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: GlobalConstants.Color.green)
        return view
    }()
    
    lazy var imgMovie: UIImageView = {
        let image = UIImageView(image: UIImage(named: GlobalConstants.Image.logo))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor(named: GlobalConstants.Color.green)
        image.clipsToBounds = true
        return image
    }()
    
    lazy var tableViewMovies: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initComponents() {
        addComponents()
        setAutolayout()
        setUp()
    }
    
    func addComponents() {
        addSubview(mainContainer)
        mainContainer.addSubview(imgMovie)
        mainContainer.addSubview(tableViewMovies)
    }
    
    private func setUp() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imgMovie.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: MovieListUIViewConstraints.ImgMovie.top),
            imgMovie.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor),
            imgMovie.heightAnchor.constraint(equalToConstant: MovieListUIViewConstraints.ImgMovie.height),
            
            tableViewMovies.topAnchor.constraint(equalTo: imgMovie.bottomAnchor, constant: MovieListUIViewConstraints.TableViewMovies.top),
            tableViewMovies.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            tableViewMovies.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            tableViewMovies.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
        ])
    }
    
    func loadMovies(movies: [Movie]) {
        self.movies += movies
        DispatchQueue.main.async {
            self.tableViewMovies.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
            delegate?.didScroll()
        }
    }
}

extension MovieListUIView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel
        cell.fillMovieInfo(movie: movies[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getMovieDetails(movie: movies[indexPath.item])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieListUIViewConstraints.TableViewMovies.rowHeight
    }
}
