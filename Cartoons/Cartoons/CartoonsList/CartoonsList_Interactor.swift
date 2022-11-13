//
//  CartoonsList_Interactor.swift
//  Cartoons
//
//  Created by Supapon Pucknavin on 13/11/2565 BE.
//

import Foundation
// Talk to presenter
protocol CartoonsList_Interactor_Protocol {
    var presenter: CartoonsList_Presenter_Protocol? {get set}
    
    func getCartoonsListData()
}

class CartoonsList_Interactor: CartoonsList_Interactor_Protocol {
    var presenter: CartoonsList_Presenter_Protocol?
    
    func getCartoonsListData() {
        
        guard let url = URL(string: "https://sample-api-nine.vercel.app/cartoons2D.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorWithData(result: .failure(NetworkError.serverError))
                return
            }
            
            do {
                let cartoons = try JSONDecoder().decode([Cartoon].self, from: data)
                self?.presenter?.interactorWithData(result: .success(cartoons))
            } catch {
                self?.presenter?.interactorWithData(result: .failure(NetworkError.deodingError))
            }
        }
        
        task.resume()
    }
    
    
}
