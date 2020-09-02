//
//  IntroductionVC.swift
//  CashMe
//
//  Created by Chirag Bhojani on 7/23/20.
//  Copyright © 2020 Chirag Bhojani. All rights reserved.
//

import UIKit

class IntroductionVC: BaseVC, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageC: UIPageControl!
    @IBOutlet weak var viewPageController: UIView!
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var viewProductInfo: UIView!
    
    
    var currentIndex : Int = 0
    var pageIndex : Int = 0
    
    var pageViewController : UIPageViewController?
    var pageTitles: NSArray = ["Welcome to  Cash Me", "Add Money to Wallet", "Send Money", "Withdraw Money"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.pageC.numberOfPages = self.pageTitles.count
        self.pageC.currentPage = currentIndex

        self.pageC.pageIndicatorTintColor = UIColor.hexStringToUIColor(hex: "EDF1F9")
        self.pageC.currentPageIndicatorTintColor = UIColor.hexStringToUIColor(hex: "21B5FB")
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController?.delegate = self
        let startingViewController: InstructionView = viewControllerAtIndex(index: currentIndex)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);
        let viewq = pageViewController!.view
        let view1 = self.viewPageController
        view1!.addSubview(viewq!)
        pageViewController!.didMove(toParent: self)

    }
    
    @IBAction func btnNextClick(_ sender: UIButton) {
        if sender.titleLabel?.text == "Next" {
            currentIndex = currentIndex + 1
            if currentIndex >= pageTitles.count - 1 {
               currentIndex = pageTitles.count - 1
                self.btnNext.setTitle("Finish", for: .normal)
                self.btnSkip.isHidden = true
            } else {
                self.btnNext.setTitle("Next", for: .normal)
                self.btnSkip.isHidden = false
            }
            self.pageC.currentPage = currentIndex
            let startingViewController: InstructionView = viewControllerAtIndex(index: currentIndex)!
            let viewControllers = [startingViewController]
            pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        } else {
            
            AppPrefsManager.sharedInstance.setIsIntroFinish(obj: true)
            let viewVC = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.ViewController.rawValue) as! ViewController
            self.navigationController?.pushViewController(viewVC, animated: true)
        }
    }
    
    @IBAction func btnSkipClick(_ sender: Any) {
        AppPrefsManager.sharedInstance.setIsIntroFinish(obj: true)
        let viewVC = Storyboard.main.storyboard().instantiateViewController(withIdentifier: Identifier.ViewController.rawValue) as! ViewController
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! InstructionView).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index = index - 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! InstructionView).pageIndex
        
        if index == NSNotFound || (index == self.pageTitles.count){
            return nil
        }
        index = index + 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if completed {
            if let currentViewController = pageViewController.viewControllers![0] as? InstructionView {
                    self.pageC.currentPage = currentViewController.pageIndex
                if currentViewController.pageIndex == self.pageTitles.count - 1 {
                    self.btnNext.setTitle("Finish", for: .normal)
                    self.btnSkip.isHidden = true
                } else {
                    self.btnNext.setTitle("Next", for: .normal)
                    self.btnSkip.isHidden = false
                }
            }
        }
    }
    
    func viewControllerAtIndex(index: Int) -> InstructionView?
    {
        if self.pageTitles.count == 0 || index >= self.pageTitles.count
        {
            if index == 0 {
                currentIndex = 0
            } else if index == self.pageTitles.count - 1 {
                currentIndex = self.pageTitles.count - 1
            }
            return nil
        }
        
        let pageContentViewController = Storyboard.Introduction.storyboard().instantiateViewController(withIdentifier: Identifier.InstructionView.rawValue) as! InstructionView
        pageContentViewController.pageIndex = index
        currentIndex = index
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
}

class InstructionView: UIViewController
{
    
    var pageIndex : Int = 0
    var titleText : String = ""
    var subTitleText : String = ""
    var imageFile : String = ""
    
    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblSubTitle: UILabel?
    @IBOutlet weak var lblDescription: UILabel?
    @IBOutlet weak var viewDescription: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if pageIndex == 0 {
            self.imgView?.isHidden = true
            self.lblTitle?.isHidden = false
            self.lblSubTitle?.isHidden = false
            self.lblDescription?.isHidden = false
        } else if pageIndex == 1 {
            self.lblTitle?.isHidden = true
            self.lblSubTitle?.isHidden = true
            self.lblDescription?.isHidden = true
            self.imgView?.isHidden = false
        } else if pageIndex == 2 {
            self.lblTitle?.isHidden = true
            self.lblSubTitle?.isHidden = true
            self.lblDescription?.isHidden = true
            self.imgView?.isHidden = false
            self.viewDescription?.removeFromSuperview()
        } else {
            self.lblTitle?.isHidden = true
            self.lblSubTitle?.isHidden = true
            self.lblDescription?.isHidden = true
            self.imgView?.isHidden = true
            self.viewDescription?.frame = self.view.bounds
            self.view.addSubview(self.viewDescription!)
        }
    }
}

