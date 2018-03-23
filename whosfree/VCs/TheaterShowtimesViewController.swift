//
//  TheaterShowtimesViewController.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
import SafariServices

class TheaterShowtimesViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var theaterShowtimesView = TheaterShowtimesView()
    
    var theater: Theater
    
    var movieShowtimes = [MovieShowtimes]() {
        didSet {
            DispatchQueue.main.async {
                self.theaterShowtimesView.showtimesTableView.reloadData()
                if self.movieShowtimes.isEmpty { print("No showtimes") }
            }
        }
    }
    
    init(theater: Theater) {
        self.theater = theater
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(theaterShowtimesView)
        theaterShowtimesView.showtimesTableView.delegate = self
        theaterShowtimesView.showtimesTableView.dataSource = self
        navigationItem.title = theater.name
        ShowtimeAPIClient.manager.getShowtimes(with: theater.theatreId, and: "2018-03-23", and: "1", success: { self.movieShowtimes = $0 }, failure: { print($0) })
    }
    
}

extension TheaterShowtimesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let mhv = MovieHeaderView()
        // TODO: Better link to buying movie, shows error in website
        mhv.delegate = self
        guard let url = movieShowtimes[section].showtimes.last?.ticketURI else {
            mhv.buyTicketsButton.isHidden = true
            mhv.configureHeader(imageURL: "https://cuso.tmsimg.com/" + movieShowtimes[section].preferredImage.uri, name: movieShowtimes[section].title, shortDescription: movieShowtimes[section].shortDescription, theURLString: nil, rating: movieShowtimes[section].ratings.first!.code)
            return mhv
        }
        
        mhv.configureHeader(imageURL: "https://cuso.tmsimg.com/" + movieShowtimes[section].preferredImage.uri, name: movieShowtimes[section].title, shortDescription: movieShowtimes[section].shortDescription, theURLString: url, rating: movieShowtimes[section].ratings.first!.code)
        return mhv
    }
}


extension TheaterShowtimesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieShowtimes.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieShowtimes[section].showtimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showtime cell", for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        let currentShowtime: Showtime = movieShowtimes[section].showtimes[row]
        cell.textLabel?.text = currentShowtime.dateTime
        //cell.detailTextLabel?.text = movieShowtimes[section].subType
        return cell
    }
}

extension TheaterShowtimesViewController: MovieHeaderViewDelegate {
    func clickedBuyTicketButton(_ HeaderView: UIView, urlString: String) {
        //        let pmtVC = PurchaseMovieTicketsViewController(url: urlString)
        //
        //        let pmtNavCon = UINavigationController(rootViewController: pmtVC)
        //
        //        pmtVC.modalTransitionStyle = .coverVertical
        //        pmtVC.modalPresentationStyle = .overCurrentContext
        //        present(pmtNavCon, animated: true, completion: nil)
        
        let sfSafariVC: SFSafariViewController = SFSafariViewController(url: URL(string: urlString)!)
        sfSafariVC.delegate = self
        sfSafariVC.modalTransitionStyle = .coverVertical
        sfSafariVC.modalPresentationStyle = .overCurrentContext
        present(sfSafariVC, animated: true, completion: nil)
    }
}

