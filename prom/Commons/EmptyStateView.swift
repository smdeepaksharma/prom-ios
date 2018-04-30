//
//  EmptyStateView.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/24/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    @IBOutlet var contentView: UIView!
    var nib: String?
    var image: UIImage?
    var message: String?
    
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    init(frame: CGRect, nib: String, image: UIImage, message: String) {
        super.init(frame: frame)
        self.nib = nib
        self.image = image
        self.message = message
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        if let nibName = self.nib {
            Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
            addSubview(contentView)
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.imageView.image = self.image
            self.textView.text = self.message
        }
    }

}
