//
//  LineScatterCandleRadarRenderer.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics

@objc(LineScatterCandleRadarChartRenderer)
open class LineScatterCandleRadarRenderer: BarLineScatterCandleBubbleRenderer
{
    public override init(animator: Animator, viewPortHandler: ViewPortHandler)
    {
        super.init(animator: animator, viewPortHandler: viewPortHandler)
    }
    
    /// Draws vertical & horizontal highlight-lines if enabled.
    /// :param: context
    /// :param: points
    /// :param: horizontal
    /// :param: vertical
    @objc open func drawHighlightLines(context: CGContext, point: CGPoint, set: ILineScatterCandleRadarChartDataSet, drawGradient:[UIColor]? = nil)
    {
        
        // draw vertical highlight lines
        if set.isVerticalHighlightIndicatorEnabled
        {
            
            if drawGradient == nil {
            context.beginPath()
            context.move(to: CGPoint(x: point.x, y: viewPortHandler.contentTop))
            context.addLine(to: CGPoint(x: point.x, y: viewPortHandler.contentBottom))
            context.strokePath()
            }
            else{
                
                let gradientColors3 = [drawGradient![0].cgColor, drawGradient![1].cgColor];
                
                let colorSpace3 = CGColorSpaceCreateDeviceRGB()
                
                let colorLocations3: [CGFloat] = [0.0, 1.0]
                let gradient3 = CGGradient(colorsSpace: colorSpace3,
                                           colors: gradientColors3 as CFArray,
                                           locations: colorLocations3)!
                
                
                context.addRect(CGRect.init(x: point.x, y: viewPortHandler.contentTop, width: 1, height: viewPortHandler.contentBottom  - viewPortHandler.contentTop))
                
                context.clip()
                context.drawLinearGradient(gradient3, start: CGPoint(x: point.x, y: viewPortHandler.contentTop), end: CGPoint(x: point.x, y: viewPortHandler.contentBottom), options: [])
               context.resetClip()
                
            }
        }
        
        // draw horizontal highlight lines
        if set.isHorizontalHighlightIndicatorEnabled
        {
            context.beginPath()
            context.move(to: CGPoint(x: viewPortHandler.contentLeft, y: point.y))
            context.addLine(to: CGPoint(x: viewPortHandler.contentRight, y: point.y))
            context.strokePath()
        }
    }
}
