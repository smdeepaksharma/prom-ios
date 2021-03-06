//
//  FeatureViewController.swift
//  ProM
//
//  Created by Deepak Sharma S M on 2/22/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController, UIScrollViewDelegate {
 

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        let featureViews = createFeaturesViews()
        setUpScrollView(featureViews: featureViews)
        
        pageControl.numberOfPages = featureViews.count
        pageControl.currentPage = 0
        
        view.bringSubview(toFront: pageControl)
    }
    
    
    func createFeaturesViews() -> [FeatureView] {
        
        let feature1 = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as! FeatureView
        feature1.titleLabel.text = "Hello Prom!"
        feature1.descriptionLabel.text = "Ready to get stuff done?"
        
        let feature2 = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as! FeatureView
        feature2.titleLabel.text = "Add details"
        feature2.descriptionLabel.text = "Add project details, deadlines, priority and collaboraters"
        
        let feature3 = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as! FeatureView
        feature3.titleLabel.text = "Team up"
        feature3.descriptionLabel.text = "Invite people to join your story, all for free!"
        
        return [feature1, feature2, feature3]
    }
    
    func setUpScrollView(featureViews: [FeatureView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(featureViews.count), height: view.frame.height)
        
        for viewIndex in 0..<featureViews.count {
            featureViews[viewIndex].frame = CGRect(x: view.frame.width * CGFloat(viewIndex), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(featureViews[viewIndex])
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / view.frame.size.width)
        pageControl.currentPage = Int(page)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
