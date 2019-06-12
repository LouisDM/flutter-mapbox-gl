import UIKit
import Mapbox.MGLGeometry

class CircleController: NSObject,CircleOptionsSink {
    
    
    var circle : MGLCircleStyleLayer?
    
    var geometry : MGLCoordinateSpan?
    
    func setCircleRadius(circleRadius: Float) {
        self.circle?.circleRadius = NSExpression(forConstantValue: circleRadius)
    }
    
    func setCircleColor(circleColor: String) {
        self.circle?.circleColor = NSExpression(forConstantValue: UIColor.hexadecimalColor(hexadecimal: circleColor))
    }
    
    func setCircleBlur(circleBlur: Float) {
        self.circle?.circleBlur = NSExpression(forConstantValue: circleBlur)
    }
    
    func setCircleOpacity(circleOpacity: Float) {
        self.circle?.circleOpacity = NSExpression(forConstantValue: circleOpacity)
    }
    
    func setCircleStrokeWidth(circleStrokeWidth: Float) {
        self.circle?.circleStrokeWidth = NSExpression(forConstantValue: circleStrokeWidth)
    }
    
    func setCircleStrokeColor(circleStrokeColor: String) {
        if #available(iOS 11.0, *) {
            self.circle?.circleStrokeColor = NSExpression(forConstantValue: UIColor.init(named: circleStrokeColor))
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setCircleStrokeOpacity(circleStrokeOpacity: Float) {
        self.circle?.circleStrokeOpacity = NSExpression(forConstantValue: circleStrokeOpacity)
    }
    
    func setGeometry(geometry: MGLCoordinateSpan) {
        
        self.geometry = geometry
        
        let point = MGLPointFeature.init();
        
        point.coordinate = CLLocationCoordinate2D(latitude: geometry.latitudeDelta, longitude: geometry.longitudeDelta)
        
        let pointId = "circleId_" + String.init(format: "%d", Int(arc4random() % 100))
        
        let shapeSource = MGLShapeSource.init(identifier: pointId, shape: point, options: nil)
        
        self.circle = MGLCircleStyleLayer.init(identifier: pointId + String.init(format: "%d", Int(arc4random() % 100)), source: shapeSource)
    }
    
    func setDraggable(draggable: Bool) {
        
    }
    

}