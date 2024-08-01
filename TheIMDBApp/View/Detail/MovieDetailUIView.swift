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
        
    }
    var viewModel: MovieViewModel?
    
    internal lazy var lbMovieName: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoBlack, size: 30)
        label.textColor = UIColor(named: GlobalConstants.Color.greenGray)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    internal lazy var imgMovie: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25.0
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    internal lazy var lbMovieDescription: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoLight, size: 15)
        label.textColor = UIColor(named: GlobalConstants.Color.lightGray)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var lbDate: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: 14)
        label.textColor = UIColor(named: GlobalConstants.Color.lightGray)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var lbRaiting: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: 14)
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
        button.titleLabel?.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: 18)
        button.backgroundColor = UIColor(named: GlobalConstants.Color.aquaGreen)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    internal lazy var btnFavorite: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ Favorita", for: .normal)
        button.titleLabel?.font = UIFont(name: GlobalConstants.Font.robotoMedium, size: 18)
        button.backgroundColor = UIColor(named: GlobalConstants.Color.aquaGreen)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
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
        container.spacing = 20
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
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
        stackView.spacing = 20
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
            containerView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            headStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            bodyStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bodyStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            btnRate.heightAnchor.constraint(equalToConstant: 44),
            btnFavorite.heightAnchor.constraint(equalToConstant: 44)
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
