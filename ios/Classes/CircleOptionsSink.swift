import Mapbox.MGLGeometry

protocol CircleOptionsSink {

    func setCircleRadius(circleRadius : Float)

    func setCircleColor(circleColor : String)

    func setCircleBlur(circleBlur : Float)

    func setCircleOpacity(circleOpacity : Float)

    func setCircleStrokeWidth(circleStrokeWidth : Float)

    func setCircleStrokeColor(circleStrokeColor : String)

    func setCircleStrokeOpacity(circleStrokeOpacity : Float)

    func setGeometry(geometry : MGLCoordinateSpan)

    func setDraggable(draggable : Bool)
}
