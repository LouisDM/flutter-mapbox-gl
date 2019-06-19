//
//  SymbolController.swift
//  FlutterDemo
//
//  Created by 林思凯 on 5/6/2019.
//  Copyright © 2019 linsikai. All rights reserved.
//

import UIKit
import Mapbox.MGLGeometry

class SymbolController: NSObject{
    
    
    var symbol : MGLSymbolStyleLayer?
    
    
    
    func setIconSize(iconSize : Float){
        self.symbol?.iconScale = NSExpression(forConstantValue: iconSize)
    }
    
    func setIconImage(iconImage : String){
        self.symbol?.iconImageName = NSExpression(forConstantValue: iconImage)
    }
    
    func setIconRotate(iconRotate : Float){
        self.symbol?.iconRotation = NSExpression(forConstantValue: iconRotate)
    }
    
    func setIconOffset(iconOffset : [Float]){
        self.symbol?.iconOffset = NSExpression(forConstantValue: iconOffset)
    }
    
    func setIconAnchor(iconAnchor : String){
        self.symbol?.iconAnchor = NSExpression(forKeyPath: iconAnchor)
    }
    
    func setTextField(textField : String){
        self.symbol?.text = NSExpression(forKeyPath: textField)
    }
    
    func setTextSize(textSize : Float){
        self.symbol?.textFontSize = NSExpression(forConstantValue: textSize)
    }
    
    func setTextMaxWidth(textMaxWidth : Float){
        self.symbol?.maximumTextWidth = NSExpression(forConstantValue: textMaxWidth)
    }
    
    func setTextLetterSpacing(textLetterSpacing : Float){
        self.symbol?.textLetterSpacing = NSExpression(forConstantValue: textLetterSpacing)
    }
    
    func setTextJustify(textJustify : String){
        self.symbol?.textJustification = NSExpression(forKeyPath: textJustify)
    }
    
    func setTextAnchor(textAnchor : String){
        self.symbol?.textAnchor = NSExpression(forKeyPath: textAnchor)
    }
    
    func setTextRotate(textRotate : Float){
        self.symbol?.textRotation = NSExpression(forConstantValue: textRotate)
    }
    
    func setTextTransform(textTransform : String){
        self.symbol?.textTransform = NSExpression(forConstantValue: textTransform)
    }
    
    func setTextOffset(textOffset : [Float]){
        self.symbol?.textOffset = NSExpression(forConstantValue: textOffset)
    }
    
    func setIconOpacity(iconOpacity : Float){
        self.symbol?.iconOpacity = NSExpression(forConstantValue: iconOpacity)
    }
    
    func setIconColor(iconColor : String){
        self.symbol?.iconColor = NSExpression(forConstantValue: UIColor.hexadecimalColor(hexadecimal: iconColor))
    }
    
    func setIconHaloColor(iconHaloColor : String){
        if #available(iOS 11.0, *) {
            self.symbol?.iconHaloColor = NSExpression(forConstantValue: UIColor(named: iconHaloColor))
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setIconHaloWidth(iconHaloWidth : Float){
        self.symbol?.iconHaloWidth = NSExpression(forConstantValue: iconHaloWidth)
    }
    
    func setIconHaloBlur(iconHaloBlur : Float){
        self.symbol?.iconHaloBlur = NSExpression(forConstantValue: iconHaloBlur)
    }
    
    func setTextOpacity(textOpacity : Float){
        self.symbol?.textOpacity = NSExpression(forConstantValue: textOpacity)
    }
    
    func setTextColor(textColor : String){
        self.symbol?.textColor = NSExpression(forConstantValue: UIColor.hexadecimalColor(hexadecimal: textColor))
    }
    
    func setTextHaloColor(textHaloColor : String){
        self.symbol?.textHaloColor = NSExpression(forConstantValue: UIColor.hexadecimalColor(hexadecimal: textHaloColor))
    }
    
    func setTextHaloWidth(textHaloWidth : Float){
        self.symbol?.textHaloWidth = NSExpression(forConstantValue: textHaloWidth)
    }
    
    func setTextHaloBlur(textHaloBlur : Float){
        self.symbol?.textHaloBlur = NSExpression(forConstantValue: textHaloBlur)
    }
    
    func setGeometry(geometry : MGLCoordinateSpan){
        
        let point = MGLPointFeature.init();
        
        point.coordinate = CLLocationCoordinate2D(latitude: geometry.latitudeDelta, longitude: geometry.longitudeDelta)
        
        let pointId = "pointId_" + String.init(format: "%d", Int(arc4random() % 100))
        
        let shapeSource = MGLShapeSource.init(identifier: pointId, shape: point, options: nil)
        
        self.symbol = MGLSymbolStyleLayer.init(identifier: pointId + String.init(format: "%d", Int(arc4random() % 100)), source: shapeSource)
    }
    
    func setZIndex(index : Int){
        
    }
    
    func setDraggable(draggable : Bool){
        
    }
}
