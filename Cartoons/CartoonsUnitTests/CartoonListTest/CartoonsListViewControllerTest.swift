//
//  CartoonListViewTest.swift
//  CartoonsUnitTests
//
//  Created by Supapon Pucknavin on 14/11/2565 BE.
//

import Foundation
import XCTest

@testable import Cartoons

class CartoonsListViewControllerTest: XCTestCase {

    var vc: CartoonsListViewController!
    
    
    override func setUp() {
        super.setUp()
        
       vc = CartoonsListViewController()
    
    }

    func testShowError() throws {
        
        vc.update(with: "Error Message")
        DispatchQueue.main.async {
            XCTAssertEqual("Error Message", self.vc.errorMessageForTesting())
            XCTAssertEqual(false, self.vc.errorLabelIsHiddenForTest())
            XCTAssertEqual(0, self.vc.cartoons.count)
        }
        
    }
    
    func testUpdateData() throws {
        let mockData = Cartoon(
            title: "Spongebob Squarepants",
            year: 1999, creator: [
            "Stephen Hillenburg"
          ],
            rating: "TV-Y",
            genre: [
            "Comedy",
            "Family"
          ],
            runtime_in_minutes: 23,
            episodes: 272,
            image: "https://nick.mtvnimages.com/uri/mgid:arc:content:nick.com:9cd2df6e-63c7-43da-8bde-8d77af9169c7?quality=0.7",
            id: 1)
        
        vc.update(with: [mockData])
        DispatchQueue.main.async {
            XCTAssertEqual(1, self.vc.cartoons.count)
            XCTAssertEqual(true, self.vc.errorLabelIsHiddenForTest())
        }
        
    }
}
