//
//  FeatureViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 2/22/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import Firebase

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
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "authUserRedirect" {
            let _ = segue.destination as! StoryBoardsViewController
        }
    }
    
    func createFeaturesViews() -> [FeatureView] {
        
        let feature1 = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as! FeatureView
        feature1.title.text = "Hello Prom!"
        feature1.descriptionLabel.text = "Manage your workload, communicate with your team and celebrate success"
        feature1.icon.image = UIImage.init(named: "prom")
        
        let feature2 = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as! FeatureView
        feature2.title.text = "Add details"
        feature2.descriptionLabel.text = "Add project details, deadlines, priority and collaboraters"
        feature2.icon.image = UIImage.init(named: "add_details")
        
        let feature3 = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as! FeatureView
        feature3.title.text = "Team up"
        feature3.descriptionLabel.text = "Invite people to join your story, all for free!"
        feature3.icon.image = UIImage.init(named: "team")
        
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
        if scrollView.contentOffset.y >= 0 {
            scrollView.contentOffset.y = 0
        }
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
