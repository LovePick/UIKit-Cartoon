//
//  CartoonDetail_View.swift
//  Cartoons
//
//  Created by Supapon Pucknavin on 13/11/2565 BE.
//

import Foundation
import UIKit

// Talks To presenter
protocol CartoonDetail_View_Protocol {
    var presenter: CartoonDetail_Presenter_Protocol? {get set}
    
    func update(with cartoon:Cartoon)
    func update(with error:String)
}

class CartoonDetailViewController: UIViewController, CartoonDetail_View_Protocol {

    // MARK: - COMPONENT
    let stackView = UIStackView()
    let label = UILabel()
    let imageView = UIImageView()
    
    
    // MARK: - PROPERTY
    var presenter: CartoonDetail_Presenter_Protocol?
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        presenter?.viewDidLoad()
    }
}

extension CartoonDetailViewController {
    func style() {
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dummy"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - CartoonDetail_View_Protocol
extension CartoonDetailViewController {
    
    func update(with cartoon: Cartoon) {
        
        label.textColor = .black
        label.text = cartoon.title

        if let url = URL(string: cartoon.image) {
            imageView.load(url: url)
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
    }
    
    func update(with error: String) {
        imageView.isHidden = true
        label.text = error
        label.textColor = .red
    }
}
