//
//  DetailedViewController.swift
//  TranslateApp
//
//  Created by Artur Kushniarou on 17.02.21.
//

import UIKit

protocol DetailedView: class {
    
}

class DetailedViewController: UIViewController {
    
    var translatedWordFromTable: TranslateResult?
    
    @IBOutlet weak var originalLanguage: UILabel!
    @IBOutlet weak var targetLanguage: UILabel!
    @IBOutlet weak var originalWord: UILabel!
    @IBOutlet weak var translatedWord: UILabel!
    
    private var presenter: DetailedViewPresenter = DetailedPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
        
        originalLanguage.text = translatedWordFromTable?.fromLanguage.title
        targetLanguage.text = translatedWordFromTable?.translateLanguage.title
        originalWord.text = translatedWordFromTable?.translated
        translatedWord.text = translatedWordFromTable?.result

        
    }
}

extension DetailedViewController: DetailedView {
    
}
