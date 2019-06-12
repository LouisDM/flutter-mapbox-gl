import Mapbox.MGLGeometry

protocol SymbolOptionsSink {

    func setIconSize(iconSize : Float)

    func setIconImage(iconImage : String)

    func setIconRotate(iconRotate : Float)

    func setIconOffset(iconOffset : [Float])

    func setIconAnchor(iconAnchor : String)

    func setTextField(textField : String)

    func setTextSize(textSize : Float)

    func setTextMaxWidth(textMaxWidth : Float)

    func setTextLetterSpacing(textLetterSpacing : Float)

    func setTextJustify(textJustify : String)

    func setTextAnchor(textAnchor : String)

    func setTextRotate(textRotate : Float)

    func setTextTransform(textTransform : String)

    func setTextOffset(textOffset : [Float])

    func setIconOpacity(iconOpacity : Float)

    func setIconColor(iconColor : String)

    func setIconHaloColor(iconHaloColor : String)

    func setIconHaloWidth(iconHaloWidth : Float)

    func setIconHaloBlur(iconHaloBlur : Float)

    func setTextOpacity(textOpacity : Float)

    func setTextColor(textColor : String)

    func setTextHaloColor(textHaloColor : String)

    func setTextHaloWidth(textHaloWidth : Float)

    func setTextHaloBlur(textHaloBlur : Float)

    func setGeometry(geometry : MGLCoordinateSpan)

    func setZIndex(index : Int)

    func setDraggable(draggable : Bool)
}
