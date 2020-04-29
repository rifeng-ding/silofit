//
//  silofitTests.swift
//  silofitTests
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import XCTest
@testable import Silofit

class MapViewModelTests: XCTestCase {

    var mockAuthService: MockAuthService!
    var mockSpaceService: MockSpaceService!
    var mapViewModel: MapViewModel!
    
    override func setUpWithError() throws {
        
        self.mockAuthService = MockAuthService()
        // When MapViewModel is used, user should already logged in
        self.mockAuthService.hasLoggedIn = true
        
        self.mockSpaceService = MockSpaceService()
        self.mapViewModel = MapViewModel(authService: self.mockAuthService,
                                         spaceService: self.mockSpaceService)
    }

    override func tearDownWithError() throws {
        
        self.mockAuthService = nil
        self.mockSpaceService = nil
        self.mapViewModel = nil
    }

    func testLoadSpaces() {
        
        var serviceError: Error?
        
        let positivePromise = self.expectation(description: "model with spaces is valid")
        self.mockSpaceService.hasSpaces = true
        self.mapViewModel.loadSpaces { (result) in
            switch result {
            case .success():
                break
            case .failure(let error):
                serviceError = error
            }
            positivePromise.fulfill()
        }
        
        self.wait(for: [positivePromise], timeout: 1)
        XCTAssertNil(serviceError)
        XCTAssertEqual(self.mapViewModel.spaces, self.mockSpaceService.mockSpaces)
    }
    
    func testIsValid() {
                
        let positivePromise = self.expectation(description: "model with spaces is valid")
        self.mockSpaceService.hasSpaces = true
        self.mapViewModel.loadSpaces { (_) in
            positivePromise.fulfill()
        }
        
        self.wait(for: [positivePromise], timeout: 1)
        XCTAssertTrue(self.mapViewModel.isValid)
    }
    
    func testIsInvalid() {
                
        let negativePromise = self.expectation(description: "model with no spaces is invalid")
        self.mockSpaceService.hasSpaces = false
        self.mapViewModel.loadSpaces { (result) in
            negativePromise.fulfill()
        }
        
        self.wait(for: [negativePromise], timeout: 1)
        XCTAssertFalse(self.mapViewModel.isValid)
    }
    
    func testTitle() {

        XCTAssertEqual( self.mapViewModel.title, AppInfoUtility.appName)
    }

    func testAnnotationGeneration() {
        
        XCTAssertEqual(self.mapViewModel.currentMapAnnotations.count, 0)
        
        let spaceLoadingPromise = self.expectation(description: "loading spaces")
        self.mapViewModel.loadSpaces { (_) in
            spaceLoadingPromise.fulfill()
        }
        
        self.wait(for: [spaceLoadingPromise], timeout: 1)

        let annotations = self.mapViewModel.generateMapAnnotations()
        for (index, annotation) in annotations.enumerated() {
            XCTAssertEqual(annotation.spaceIdentifer,
                           self.mockSpaceService.mockSpaces[index].identifier)
            XCTAssertEqual(annotation.title,
                           self.mockSpaceService.mockSpaces[index].name)
            XCTAssertEqual(annotation.coordinate.latitude,
                           self.mockSpaceService.mockSpaces[index].latitude)
            XCTAssertEqual(annotation.coordinate.longitude,
                           self.mockSpaceService.mockSpaces[index].longitude)
        }
        
        XCTAssertEqual(self.mapViewModel.currentMapAnnotations, annotations)
    }
    
    func testAnnotationColor() {
        
        let spaceLoadingPromise = self.expectation(description: "loading spaces")
        self.mapViewModel.loadSpaces { (_) in
            spaceLoadingPromise.fulfill()
        }
        
        self.wait(for: [spaceLoadingPromise], timeout: 1)
        let annotations = self.mapViewModel.generateMapAnnotations()
        for (index, annotation) in annotations.enumerated() {
            let color = self.mapViewModel.annotationViewColor(forSpaceWithIdentifer: annotation.spaceIdentifer)
            let correspondingSpace = self.mockSpaceService.mockSpaces[index]
            let targetColor: UIColor
            switch correspondingSpace.status {
            case .comingSoon, .unknown:
                targetColor = StyleColor.pinRed
            case .opened:
                targetColor = StyleColor.pinGreen
            }
            XCTAssertEqual(targetColor, color)
        }
    }
    
    func testLogout() {
        
        XCTAssertTrue(self.mockAuthService.isLogin)
        
        let logoutPromise = self.expectation(description: "logout")
        self.mapViewModel.logout { (result) in
            logoutPromise.fulfill()
        }
        self.wait(for: [logoutPromise], timeout: 1)
        XCTAssertFalse(self.mockAuthService.isLogin)
    }
}
