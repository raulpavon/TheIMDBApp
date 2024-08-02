//
//  MovieDetailUIView.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 30/07/24.
//

import Foundation
import UIKit

class MovieDetailUIView: UIView {
    
    enum MovieDetailUIViewConstraints {
        enum LblMovieName {
            static let fontSize: CGFloat = 30
        }
        enum ImgMovie {
            static let cornerRadius: CGFloat = 25
        }
        enum LbMovieDescription {
            static let fontSize: CGFloat = 15
        }
        enum LbDate {
            static let fontSize: CGFloat = 14
        }
        enum LbRaiting {
            static let fontSize: CGFloat = 14
        }
        enum Button {
            static let fontSize: CGFloat = 18
            static let cornerRadius: CGFloat = 10
            static let height: CGFloat = 44
        }
        enum ContainerView {
            static let spacing: CGFloat = 20
            static let bottom: CGFloat = -40
            static let leading: CGFloat = 20
            static let trailing: CGFloat = -20
            static let width: CGFloat = -40
        }
    }
    var viewModel: MovieViewModel?
    
    internal lazy var lbMovieName: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoBlack, size: MovieDetailUIViewConstraints.LblMovieName.fontSize)
        label.textColor = UIColor(named: GlobalConstants.Color.greenGray)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    internal lazy var imgMovie: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = MovieDetailUIViewConstraints.ImgMovie.cornerRadius
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    internal lazy var lbMovieDescription: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoLight, size: MovieDetailUIViewConstraints.LbMovieDescription.fontSize)
        label.textColor = UIColor(named: GlobalConstants.Color.lightGray)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var lbDate: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: MovieDetailUIViewConstraints.LbDate.fontSize)
        label.textColor = UIColor(named: GlobalConstants.Color.lightGray)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var lbRaiting: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: MovieDetailUIViewConstraints.LbRaiting.fontSize)
        label.textColor = UIColor(named: GlobalConstants.Color.lightGray)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var btnRate: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calificar", for: .normal)
        button.titleLabel?.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: MovieDetailUIViewConstraints.Button.fontSize)
        button.backgroundColor = UIColor(named: GlobalConstants.Color.aquaGreen)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = MovieDetailUIViewConstraints.Button.cornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    internal lazy var btnFavorite: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ Favorita", for: .normal)
        button.titleLabel?.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: MovieDetailUIViewConstraints.Button.fontSize)
        button.backgroundColor = UIColor(named: GlobalConstants.Color.aquaGreen)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = MovieDetailUIViewConstraints.Button.cornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.bounces = true
        scroll.delaysContentTouches = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let containerView: UIStackView = {
        let container = UIStackView()
        container.backgroundColor = UIColor(named: GlobalConstants.Color.green)
        container.axis = .vertical
        container.spacing = MovieDetailUIViewConstraints.ContainerView.spacing
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = MovieDetailUIViewConstraints.ContainerView.spacing
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = MovieDetailUIViewConstraints.ContainerView.spacing
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = MovieDetailUIViewConstraints.ContainerView.spacing
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    }
    
    func addComponents() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addArrangedSubview(lbMovieName)
        
        containerView.addArrangedSubview(headStackView)
        headStackView.addArrangedSubview(imgMovie)
        headStackView.addArrangedSubview(detailsStackView)
        
        containerView.addArrangedSubview(bodyStackView)
        
        detailsStackView.addArrangedSubview(lbMovieDescription)
        
        bodyStackView.addArrangedSubview(lbRaiting)
        bodyStackView.addArrangedSubview(lbDate)
        
        containerView.addArrangedSubview(buttonStackView)
        buttonStackView.addArrangedSubview(btnRate)
        buttonStackView.addArrangedSubview(btnFavorite)
        
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: MovieDetailUIViewConstraints.ContainerView.bottom),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: MovieDetailUIViewConstraints.ContainerView.leading),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: MovieDetailUIViewConstraints.ContainerView.trailing),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: MovieDetailUIViewConstraints.ContainerView.width),
            
            headStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            bodyStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bodyStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            btnRate.heightAnchor.constraint(equalToConstant: MovieDetailUIViewConstraints.Button.height),
            btnFavorite.heightAnchor.constraint(equalToConstant: MovieDetailUIViewConstraints.Button.height)
        ])
    }
    
    func setMovieDetail(movie: Movie) {
        if let viewModel = viewModel {
            viewModel.getMovieImage(imagePath: movie.posterPath) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imgMovie.image = image
                }
            }
        }
        lbMovieName.text = "\(movie.title)"
        lbRaiting.text = String(format: "Raiting: ⭐️ %.1f/10 ", movie.raiting)
        if let date = movie.releaseDate.formatDateString() {
            lbDate.text = "Estreno: \(date)"
        }
        lbMovieDescription.text = "\(movie.overview)"
    }
}
