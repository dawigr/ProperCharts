//
//  BarChartView.swift
//  StockFinancials
//
//  Created by Roman Baitaliuk on 28/04/20.
//  Copyright © 2020 Roman Baitaliuk. All rights reserved.
//

import SwiftUI

public struct BarChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private let data: ChartData
    public let title: String
    public let style: ChartStyle
    public let darkModeStyle: ChartStyle?
    public let dropShadow: Bool
    public let frameSize: CGSize
    
    public init(data: ChartData,
                title: String,
                style: ChartStyle,
                darkModeStyle: ChartStyle? = nil,
                dropShadow: Bool = false,
                frameSize: CGSize) {
        self.data = data
        self.title = title
        self.style = style
        self.darkModeStyle = darkModeStyle
        self.dropShadow = dropShadow
        self.frameSize = frameSize
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(self.currentStyle().backgroundColor)
                .shadow(color: self.currentStyle().dropShadowColor,
                        radius: self.dropShadow ? 8 : 0)
            AxesGridView(data: self.data,
                         gridlineColor: self.currentStyle().gridlineColor,
                         labelColor: self.currentStyle().labelColor)
                .padding([.top], AxisLabelInfo.halfHeight)
                .padding([.bottom], AxisLabelInfo.height + AxisLabelInfo.halfHeight)
            BarChartCollectionView(data: self.data.yValues,
                                   gradient: self.currentStyle().gradientColor)
                .padding([.trailing], AxisLabelInfo.maxWidth(values: self.data.yValues))
                .padding([.top], AxisLabelInfo.halfHeight)
                .padding([.bottom], AxisLabelInfo.height + AxisLabelInfo.halfHeight)
        }.frame(minWidth: 0,
                maxWidth: self.frameSize.width,
                minHeight: self.frameSize.height,
                maxHeight: self.frameSize.height)
    }
    
    func currentStyle() -> ChartStyle {
        if let darkModeStyle = self.darkModeStyle {
            return self.colorScheme == .dark ? darkModeStyle : self.style
        } else {
            return self.style
        }
    }
}
