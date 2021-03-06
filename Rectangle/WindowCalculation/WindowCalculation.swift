//
//  WindowCalculation.swift
//  Rectangle, Ported from Spectacle
//
//  Created by Ryan Hanson on 6/13/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Cocoa

protocol Calculation {
    
    func calculate(_ window: Window, lastAction: RectangleAction?, usableScreens: UsableScreens, action: WindowAction) -> WindowCalculationResult?
    
    func calculateRect(_ window: Window, lastAction: RectangleAction?, visibleFrameOfScreen: CGRect, action: WindowAction) -> RectResult
}

class WindowCalculation: Calculation {
    
    func calculate(_ window: Window, lastAction: RectangleAction?, usableScreens: UsableScreens, action: WindowAction) -> WindowCalculationResult? {
        
        let rectResult = calculateRect(window, lastAction: lastAction, visibleFrameOfScreen: usableScreens.visibleFrameOfCurrentScreen, action: action)
        
        if rectResult.rect.isNull {
            return nil
        }
        
        return WindowCalculationResult(rect: rectResult.rect, screen: usableScreens.currentScreen, resultingAction: action, resultingSubAction: rectResult.subAction)
    }

    func calculateRect(_ window: Window, lastAction: RectangleAction?, visibleFrameOfScreen: CGRect, action: WindowAction) -> RectResult {
        return RectResult(CGRect.null)
    }
    
    func rectCenteredWithinRect(_ rect1: CGRect, _ rect2: CGRect) -> Bool {
        let centeredMidX = abs(rect2.midX - rect1.midX) <= 1.0
        let centeredMidY = abs(rect2.midY - rect1.midY) <= 1.0
        return rect1.contains(rect2) && centeredMidX && centeredMidY
    }
    
    func rectFitsWithinRect(rect1: CGRect, rect2: CGRect) -> Bool {
        return (rect1.width <= rect2.width) && (rect1.height <= rect2.height)
    }
    
    func isLandscape(_ rect: CGRect) -> Bool {
        return rect.width > rect.height
    }
    
}

struct Window {
    let id: Int
    let rect: CGRect
}

struct RectResult {
    let rect: CGRect
    let subAction: SubWindowAction?
    
    init(_ rect: CGRect, subAction: SubWindowAction? = nil) {
        self.rect = rect
        self.subAction = subAction
    }
}

struct WindowCalculationResult {
    var rect: CGRect
    let screen: NSScreen
    let resultingAction: WindowAction
    let resultingSubAction: SubWindowAction?
    
    init(rect: CGRect, screen: NSScreen, resultingAction: WindowAction,  resultingSubAction: SubWindowAction? = nil) {
        self.rect = rect
        self.screen = screen
        self.resultingAction = resultingAction
        self.resultingSubAction = resultingSubAction
    }
}

class WindowCalculationFactory {
    
    static let leftHalfCalculation = LeftRightHalfCalculation()
    static let rightHalfCalculation = LeftRightHalfCalculation()
    static let centerHalfCalculation = CenterHalfCalculation()
    static let bottomHalfCalculation = BottomHalfCalculation()
    static let topHalfCalculation = TopHalfCalculation()
    static let centerCalculation = CenterCalculation()
    static let nextPrevDisplayCalculation = NextPrevDisplayCalculation()
    static let maximizeCalculation = MaximizeCalculation()
    static let changeSizeCalculation = ChangeSizeCalculation()
    static let lowerLeftCalculation = LowerLeftCalculation()
    static let lowerRightCalculation = LowerRightCalculation()
    static let upperLeftCalculation = UpperLeftCalculation()
    static let upperRightCalculation = UpperRightCalculation()
    static let maxHeightCalculation = MaximizeHeightCalculation()
    static let firstThirdCalculation = FirstThirdCalculation()
    static let firstTwoThirdsCalculation = FirstTwoThirdsCalculation()
    static let centerThirdCalculation = CenterThirdCalculation()
    static let lastTwoThirdsCalculation = LastTwoThirdsCalculation()
    static let lastThirdCalculation = LastThirdCalculation()
    static let moveLeftRightCalculation = MoveLeftRightCalculation()
    static let moveUpCalculation = MoveUpCalculation()
    static let moveDownCalculation = MoveDownCalculation()
    static let almostMaximizeCalculation = AlmostMaximizeCalculation()
    static let firstFourthCalculation = FirstFourthCalculation()
    static let secondFourthCalculation = SecondFourthCalculation()
    static let thirdFourthCalculation = ThirdFourthCalculation()
    static let lastFourthCalculation = LastFourthCalculation()
    static let topLeftSixthCalculation = TopLeftSixthCalculation()
    static let topCenterSixthCalculation = TopCenterSixthCalculation()
    static let topRightSixthCalculation = TopRightSixthCalculation()
    static let bottomLeftSixthCalculation = BottomLeftSixthCalculation()
    static let bottomCenterSixthCalculation = BottomCenterSixthCalculation()
    static let bottomRightSixthCalculation = BottomRightSixthCalculation()
    
    static let calculationsByAction: [WindowAction: WindowCalculation] = [
     .leftHalf: leftHalfCalculation,
     .rightHalf: rightHalfCalculation,
     .maximize: maximizeCalculation,
     .maximizeHeight: maxHeightCalculation,
     .previousDisplay: nextPrevDisplayCalculation,
     .nextDisplay: nextPrevDisplayCalculation,
     .larger: changeSizeCalculation,
     .smaller: changeSizeCalculation,
     .bottomHalf: bottomHalfCalculation,
     .topHalf: topHalfCalculation,
     .center: centerCalculation,
     .bottomLeft: lowerLeftCalculation,
     .bottomRight: lowerRightCalculation,
     .topLeft: upperLeftCalculation,
     .topRight: upperRightCalculation,
     .firstThird: firstThirdCalculation,
     .firstTwoThirds: firstTwoThirdsCalculation,
     .centerThird: centerThirdCalculation,
     .lastTwoThirds: lastTwoThirdsCalculation,
     .lastThird: lastThirdCalculation,
     .moveLeft: moveLeftRightCalculation,
     .moveRight: moveLeftRightCalculation,
     .moveUp: moveUpCalculation,
     .moveDown: moveDownCalculation,
     .almostMaximize: almostMaximizeCalculation,
     .centerHalf: centerHalfCalculation,
     .firstFourth: firstFourthCalculation,
     .secondFourth: secondFourthCalculation,
     .thirdFourth: thirdFourthCalculation,
     .lastFourth: lastFourthCalculation,
     .topLeftSixth: topLeftSixthCalculation,
     .topCenterSixth: topCenterSixthCalculation,
     .topRightSixth: topRightSixthCalculation,
     .bottomLeftSixth: bottomLeftSixthCalculation,
     .bottomCenterSixth: bottomCenterSixthCalculation,
     .bottomRightSixth: bottomRightSixthCalculation
        //     .restore: nil
    ]
}
