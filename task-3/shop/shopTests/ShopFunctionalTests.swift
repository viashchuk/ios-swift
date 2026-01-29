//
//  ShopFunctionalTests.swift
//  shopTests
//

import XCTest

final class ShopFunctionalTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    private func findProduct() -> XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Frappuccino' OR label CONTAINS 'Refresher' OR label CONTAINS 'Pink' OR label CONTAINS 'Dragon'")).firstMatch
    }
    
    private func navigateToCart() {
        let cartTab = app.tabBars.buttons["Cart"]
        if cartTab.waitForExistence(timeout: 3) {
            cartTab.tap()
        }
    }
    
    private func addFirstProductToCart() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            product.tap()
            let addButton = app.buttons["Add to Order"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                _ = app.buttons["In Cart"].waitForExistence(timeout: 2)
            }
        }
    }
    
    func testHomeScreenDisplay() {
        XCTAssertTrue(app.staticTexts["Coffee Shop"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.tabBars.buttons["Shop"].waitForExistence(timeout: 2))
        XCTAssertTrue(findProduct().waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label CONTAINS 'Frappuccino' OR label CONTAINS 'Refresher'")).firstMatch.waitForExistence(timeout: 2))
        XCTAssertTrue(app.tabBars.firstMatch.exists)
    }
    
    func testTabNavigation() {
        let cartTab = app.tabBars.buttons["Cart"]
        XCTAssertTrue(cartTab.waitForExistence(timeout: 2))
        cartTab.tap()
        XCTAssertTrue(app.staticTexts["My Cart"].waitForExistence(timeout: 2))
        
        app.tabBars.buttons["Shop"].tap()
        XCTAssertTrue(app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2))
    }
    
    func testProductDetails() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            let productName = product.label
            product.tap()
            
            _ = app.staticTexts[productName].waitForExistence(timeout: 3)
            
            XCTAssertTrue(app.staticTexts[productName].waitForExistence(timeout: 3), "Product name should be displayed on detail screen")
            
            let priceText = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '$'")).firstMatch
            XCTAssertTrue(priceText.waitForExistence(timeout: 3), "Product price should be displayed")
            
            app.swipeUp()
            
            let addButton = app.buttons["Add to Order"]
            let inCartButton = app.buttons["In Cart"]
            
            let buttonFound = addButton.waitForExistence(timeout: 5) || inCartButton.waitForExistence(timeout: 5)
            XCTAssertTrue(buttonFound, "Add to Order or In Cart button should be displayed on product detail screen")
        }
    }
    
    func testAddToCart() {
        let product = findProduct()
        XCTAssertTrue(product.waitForExistence(timeout: 3))
        
        let productName = product.label
        
        product.tap()
        let addButton = app.buttons["Add to Order"]
        if addButton.waitForExistence(timeout: 2) {
            addButton.tap()
            XCTAssertTrue(app.buttons["In Cart"].waitForExistence(timeout: 3))
        }
        
        if app.navigationBars.buttons.count > 0 {
            app.navigationBars.buttons.element(boundBy: 0).tap()
            _ = app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2)
        }
        
        navigateToCart()
        XCTAssertTrue(app.staticTexts[productName].waitForExistence(timeout: 3))
    }
    
    func testQuantityStepper() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            product.tap()
            XCTAssertTrue(app.staticTexts["1"].waitForExistence(timeout: 2))
            
            let plusButton = app.buttons.matching(NSPredicate(format: "label == 'plus'")).firstMatch
            if plusButton.waitForExistence(timeout: 2) {
                plusButton.tap()
                XCTAssertTrue(app.staticTexts["2"].waitForExistence(timeout: 1))
            }
        }
    }
    
    func testMultipleCartOperations() {
        let firstProduct = findProduct()
        if firstProduct.waitForExistence(timeout: 3) {
            firstProduct.tap()
            let addButton = app.buttons["Add to Order"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
            }
            
            if app.navigationBars.buttons.count > 0 {
                app.navigationBars.buttons.element(boundBy: 0).tap()
                _ = app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2)
            }
            
            let secondProduct = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Frappuccino' OR label CONTAINS 'Refresher' OR label CONTAINS 'Pink' OR label CONTAINS 'Dragon'")).element(boundBy: 1)
            XCTAssertTrue(secondProduct.waitForExistence(timeout: 3))
            
            secondProduct.tap()
            let addButton2 = app.buttons["Add to Order"]
            if addButton2.waitForExistence(timeout: 2) {
                addButton2.tap()
                XCTAssertTrue(app.buttons["In Cart"].waitForExistence(timeout: 2))
            }
            
            if app.navigationBars.buttons.count > 0 {
                app.navigationBars.buttons.element(boundBy: 0).tap()
                _ = app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2)
            }
            
            navigateToCart()
            XCTAssertTrue(app.staticTexts["My Cart"].waitForExistence(timeout: 2))
        }
    }
    
    func testCategoryFiltering() {
        let categoryButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Frappuccino'")).firstMatch
        XCTAssertTrue(categoryButton.waitForExistence(timeout: 3))
        
        categoryButton.tap()
        let filteredProducts = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Frappuccino'"))
        XCTAssertTrue(filteredProducts.count > 0)
    }
    
    func testCartDeletion() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            let productName = product.label
            product.tap()
            let addButton = app.buttons["Add to Order"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                _ = app.buttons["In Cart"].waitForExistence(timeout: 2)
                
                if app.navigationBars.buttons.count > 0 {
                    app.navigationBars.buttons.element(boundBy: 0).tap()
                    _ = app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2)
                }
                
                navigateToCart()
                
                let cartItem = app.staticTexts[productName]
                if cartItem.waitForExistence(timeout: 3) {
                    cartItem.swipeLeft()
                    let deleteButton = app.buttons["Delete"]
                    if deleteButton.waitForExistence(timeout: 1) {
                        deleteButton.tap()
                        XCTAssertFalse(app.staticTexts[productName].waitForExistence(timeout: 2))
                    }
                }
            }
        }
    }
    
    func testNavigationAndPrices() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            product.tap()
            XCTAssertTrue(app.staticTexts["Description"].waitForExistence(timeout: 3))
            
            if app.navigationBars.buttons.count > 0 {
                app.navigationBars.buttons.element(boundBy: 0).tap()
                XCTAssertTrue(app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2))
            }
            XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS '$'")).firstMatch.waitForExistence(timeout: 2))
        }
    }
    
    func testCartQuantityUpdate() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            product.tap()
            let addButton = app.buttons["Add to Order"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                _ = app.buttons["In Cart"].waitForExistence(timeout: 2)
                
                if app.navigationBars.buttons.count > 0 {
                    app.navigationBars.buttons.element(boundBy: 0).tap()
                    _ = app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2)
                }
                
                navigateToCart()
                
                XCTAssertTrue(app.staticTexts["1"].waitForExistence(timeout: 3))
                
                let plusButton = app.buttons.matching(NSPredicate(format: "label == 'plus'")).firstMatch
                if plusButton.waitForExistence(timeout: 2) {
                    plusButton.tap()
                    XCTAssertTrue(app.staticTexts["2"].waitForExistence(timeout: 1))
                }
            }
        }
    }
    
    func testOrderSummary() {
        let product = findProduct()
        if product.waitForExistence(timeout: 3) {
            product.tap()
            
            let addButton = app.buttons["Add to Order"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                _ = app.buttons["In Cart"].waitForExistence(timeout: 3)
                
                if app.navigationBars.buttons.count > 0 {
                    app.navigationBars.buttons.element(boundBy: 0).tap()
                    _ = app.staticTexts["Coffee Shop"].waitForExistence(timeout: 2)
                }
                
                navigateToCart()
                
                _ = app.staticTexts["My Cart"].waitForExistence(timeout: 3)
                
                let totalItemsLabel = app.staticTexts["Total Items"]
                XCTAssertTrue(totalItemsLabel.waitForExistence(timeout: 3), "Total Items label should be displayed")
                
                let totalAmountLabel = app.staticTexts["Total Amount"]
                XCTAssertTrue(totalAmountLabel.waitForExistence(timeout: 3), "Total Amount label should be displayed")
                
                let priceLabels = app.staticTexts.matching(NSPredicate(format: "label ENDSWITH '$'"))
                XCTAssertTrue(priceLabels.count > 0, "Price with $ should be displayed in order summary")
            }
        }
    }
}
