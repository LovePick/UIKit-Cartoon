//
//  CartoonDetail_Interactor.swift
//  Cartoons
//
//  Created by Supapon Pucknavin on 13/11/2565 BE.
//

import Foundation
// Talks to presenter
protocol CartoonDetail_Interactor_Protocol {
    var presenter: CartoonDetail_Presenter_Protocol? {get set}
    var cartoon: Cartoon? {get set}
    
    func getCartoonData()
}

class CartoonDetail_Interactor: CartoonDetail_Interactor_Protocol {
    var presenter: CartoonDetail_Presenter_Protocol?
    
    var cartoon: Cartoon?
    
    func getCartoonData() {
        
        presenter?.interactorUpdateData(cartoon: cartoon)
    }
    
    
}
