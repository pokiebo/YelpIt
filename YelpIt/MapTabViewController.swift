//
//  MapTabViewController.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 8/6/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsetsMake(self.mapView.frame.size.height - 100, 0, 0, 0);
    }*/

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y < self.mapView.frame.size.height * -1 ) {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: self.mapView.frame.size.height * -1), animated: false)
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let footerHeight = 700
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: Int(self.tableView.bounds.size.width), height: footerHeight))
        
        
        dummyView.backgroundColor = UIColor.white
        self.tableView.tableFooterView = dummyView;
        
        //Set the content offset of the table view to be the inverse of that footer view's height:
        
        let footerHt = dummyView.bounds.height;
        self.tableView.contentOffset = CGPoint(x: 0, y: -footerHt)
        //Set the content inset of your table view to offset the footer view.
        self.tableView.contentInset = UIEdgeInsets(top: footerHt, left: 0, bottom: -footerHt, right: 0)
        
        //Adjust the scrollbar position, again, based on the footer's height.
        
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(footerHt, 0, 0, 0);
        tableView.backgroundColor = UIColor(named: "clear")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 30.0
        
        
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location : centerLocation)
    
    //tableView.isHidden = true
    
        // Do any additional setup after loading the view.
    }

    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   /* func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw : UIView = UIView()
        
        //let m : MKMapView = MKMapView()
        
        vw.backgroundColor = UIColor(named: "clear")
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300.0
    }*/
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsetsMake(self.mapView.frame.size.height - 400, 0, 0, 0);
        
        

    }*/

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maptabcell") as! MapTableViewCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
