//
//  MovieTableViewCell.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    enum MovieCollectionViewCellConstraints {
        enum InfoContainer {
            static let height: CGFloat = 50
        }
        enum Label {
            static let fontSize: CGFloat = 12
        }
        enum LbMovieName {
            static let bottom: CGFloat = -5
        }
        enum LbMovieDate {
            static let bottom: CGFloat = -10
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var viewModel: MovieViewModel?
    
    private lazy var mainContainer: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoContainer: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor(named: GlobalConstants.Color.lightGray)?.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lbMovieName: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoRegular, size: MovieCollectionViewCellConstraints.Label.fontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var lbMovieDate: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: GlobalConstants.Font.robotoLight, size: MovieCollectionViewCellConstraints.Label.fontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private let imgMovie: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initComponents()
    }
    
    func initComponents() {
        addComponents()
        setAutolayout()
    }
    
    func addComponents() {
        addSubview(mainContainer)
        mainContainer.addSubview(imgMovie)
        mainContainer.addSubview(infoContainer)
        infoContainer.addSubview(lbMovieName)
        infoContainer.addSubview(lbMovieDate)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imgMovie.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            imgMovie.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            imgMovie.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            imgMovie.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
            
            infoContainer.bottomAnchor.constraint(equalTo: imgMovie.bottomAnchor),
            infoContainer.heightAnchor.constraint(equalToConstant: MovieCollectionViewCellConstraints.InfoContainer.height),
            infoContainer.leadingAnchor.constraint(equalTo: imgMovie.leadingAnchor),
            infoContainer.trailingAnchor.constraint(equalTo: imgMovie.trailingAnchor),
            
            lbMovieName.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor),
            lbMovieName.bottomAnchor.constraint(equalTo: lbMovieDate.topAnchor, constant: MovieCollectionViewCellConstraints.LbMovieName.bottom),
            
            lbMovieDate.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor),
            lbMovieDate.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: MovieCollectionViewCellConstraints.LbMovieDate.bottom),
        ])
    }
    
    func fillMovieInfo(movie: Movie) {
        if let viewModel = viewModel {
            viewModel.getMovieImage(imagePath: movie.posterPath) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imgMovie.image = image
                }
            }
        }
        lbMovieName.text = "Título: \(movie.title)"
        if let date = movie.releaseDate.formatDateString() {
            lbMovieDate.text = "Fecha de estreno: \(date)"
        }
    }
}
