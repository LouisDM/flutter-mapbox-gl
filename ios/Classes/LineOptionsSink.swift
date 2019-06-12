import Mapbox.MGLGeometry

protocol LineOptionsSink {

    func setLineJoin(lineJoin : String)

    func setLineOpacity(lineOpacity : Float)

    func setLineColor(lineColor : String)

    func setLineWidth(lineWidth : Float)

    func setLineGapWidth(lineGapWidth : Float)

    func setLineOffset(lineOffset : Float)

    func setLineBlur(lineBlur : Float)

    func setLinePattern(linePattern : String)

    func setGeometry(geometry : [MGLCoordinateSpan])

    func setDraggable(draggable : Bool)
}
