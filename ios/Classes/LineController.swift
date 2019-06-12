import UIKit
import Mapbox.MGLGeometry

class LineController: NSObject,LineOptionsSink {
    
    var line : MGLLineStyleLayer?
    
    
    func setLineJoin(lineJoin: String) {
        self.line?.lineJoin = NSExpression(forConstantValue: lineJoin)
    }
    
    func setLineOpacity(lineOpacity: Float) {
        self.line?.lineOpacity = NSExpression(forConstantValue: setLineOpacity)
    }
    
    func setLineColor(lineColor: String) {
        self.line?.lineColor = NSExpression(forConstantValue: UIColor.hexadecimalColor(hexadecimal: lineColor))
    }
    
    func setLineWidth(lineWidth: Float) {
        self.line?.lineWidth = NSExpression(forConstantValue: lineWidth)
    }
    
    func setLineGapWidth(lineGapWidth: Float) {
        self.line?.lineGapWidth = NSExpression(forConstantValue: lineGapWidth)
    }
    
    func setLineOffset(lineOffset: Float) {
        self.line?.lineOffset = NSExpression(forConstantValue: lineOffset)
    }
    
    func setLineBlur(lineBlur: Float) {
        self.line?.lineBlur = NSExpression(forConstantValue: lineBlur)
    }
    
    func setLinePattern(linePattern: String) {
        self.line?.linePattern = NSExpression(forConstantValue: linePattern)
    }
    
    func setGeometry(geometry: [MGLCoordinateSpan]) {
        
        var points = [MGLPointFeature]();
        
        for coordinateSpan in geometry {
            
            let point = MGLPointFeature.init();
            
            point.coordinate = CLLocationCoordinate2D(latitude: coordinateSpan.latitudeDelta, longitude: coordinateSpan.longitudeDelta)
            
            points.append(point)
        }
        
        
        let pointId = "lineId_" + String.init(format: "%d", Int(arc4random() % 100))
        
        let shapeSource = MGLShapeSource.init(identifier: pointId, shapes: points, options: nil)
        
        self.line = MGLLineStyleLayer.init(identifier: pointId + String.init(format: "%d", Int(arc4random() % 100)), source: shapeSource)
    }
    
    func setDraggable(draggable: Bool) {
        
    }
    

}