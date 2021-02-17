//
//  DetailedViewPresenter.swift
//  TranslateApp
//
//  Created by Artur Kushniarou on 17.02.21.
//

import Foundation

protocol DetailedViewPresenter{
    init()
    func addView(view: DetailedView)
}

class DetailedPresenter: DetailedViewPresenter{
    
    private weak var view: DetailedView?
    
    internal func addView(view: DetailedView) {
        self.view = view
    }
    
    required init() {
    }
    
}
