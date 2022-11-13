//
//  CartoonsList_Presenter.swift
//  Cartoons
//
//  Created by Supapon Pucknavin on 13/11/2565 BE.
//

import Foundation
// Talks to router
// Talks to view
// Talks to interactor

protocol CartoonsList_Presenter_Protocol {
    var router: CartoonsList_Router_Protocol? {get set}
    var view: CartoonsList_View_Protocol? {get set}
    var interactor: CartoonsList_Interactor_Protocol? {get set}
    
    func viewDidLoad()
    func interactorWithData(result: Result<[Cartoon], Error>)
    func tapOnDetail(_ cartoon: Cartoon)
    
}

class CartoonsList_Presenter: CartoonsList_Presenter_Protocol {
    var router: CartoonsList_Router_Protocol?
    
    var view: CartoonsList_View_Protocol?
    
    var interactor: CartoonsList_Interactor_Protocol?
    
    func viewDidLoad() {
        interactor?.getCartoonsListData()
    }
    
    func interactorWithData(result: Result<[Cartoon], Error>) {
        switch(result) {
        case .success(let cartoons):
            view?.update(with: cartoons)
        case .failure(let error):
            print(error)
            view?.update(with: "Try again later...")
        }
    }
    
    func tapOnDetail(_ cartoon: Cartoon) {
        router?.gotoDetailView(cartoon: cartoon)
    }
    
    
}
