import Mapbox

class SymbolManager: AnnotationManager<SymbolGeometry> {
    
    private let ID_GEOJSON_SOURCE = "mapbox-ios-symbol-source"
    let ID_GEOJSON_LAYER = "mapbox-ios-symbol-layer"
    var layer: MGLSymbolStyleLayer?
    
    init() {
        super.init(sourceId: ID_GEOJSON_SOURCE)
        layer = MGLSymbolStyleLayer(identifier: ID_GEOJSON_LAYER, source: source)
        layer?.iconAllowsOverlap = NSExpression(forConstantValue: true)
        layer?.textAllowsOverlap = NSExpression(forConstantValue: true)
        layer?.textIgnoresPlacement = NSExpression(forConstantValue: true)
        layer?.iconIgnoresPlacement = NSExpression(forConstantValue: true)
    }
    
    func create(options: SymbolOptions) -> Symbol? {
        setDataDrivenLayerProperties(options: options)
        return super.create(options: options)
    }
    
    func update(id: UInt64, options: SymbolOptions) {
        setDataDrivenLayerProperties(options: options)
        super.update(id:id, options: options)
    }
    
    func setDataDrivenLayerProperties(options: SymbolOptions) {
        guard let layer = layer else { return }
        
        if let _ = options.iconSize {
            layer.iconScale = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_SIZE)
        }
        
        if let _ = options.iconImage {
            layer.iconImageName = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_IMAGE)
        }
        
        if let _ = options.iconRotate {
            layer.iconRotation = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_ROTATE)
        }
        
        if let _ = options.iconOffset {
            layer.iconOffset = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_OFFSET)
        }
        
        if let _ = options.iconAnchor {
            layer.iconAnchor = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_ANCHOR)
        }
        
        if let _ = options.textField {
            layer.text = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_FIELD)
        }
        
        if let _ = options.textSize {
            layer.textFontSize = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_SIZE)
        }
        
        if let _ = options.textMaxWidth {
            layer.maximumTextWidth = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_MAXWIDTH)
        }
        
        if let _ = options.textLetterSpacing {
            layer.textLetterSpacing = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_LETTERSPACIMG)
        }
        
        if let _ = options.textJustify {
            layer.textJustification = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_JUSTIFY)
        }
        
        if let _ = options.textAnchor {
            layer.textAnchor = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_ANCHOR)
        }
        
        if let _ = options.textRotate {
            layer.textRotation = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_ROTATE)
        }
        
        if let _ = options.textTransform {
            layer.textTransform = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_TRANSFORM)
        }
        
        if let _ = options.textOffset {
            layer.textOffset = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_OFFSET)
        }
        
        if let _ = options.iconOpacity {
            layer.iconOpacity = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_OPACITY)
        }
        
        if let _ = options.iconColor {
            layer.iconColor = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_COLOR)
        }
        
        if let _ = options.iconHaloColor {
            layer.iconHaloColor = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_HALOCOLOR)
        }
        
        if let _ = options.iconHaloWidth {
            layer.iconHaloWidth = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_HALOWIDTH)
        }
        
        if let _ = options.iconHaloBlur {
            layer.iconHaloBlur = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_ICON_HALOBLUR)
        }
        
        if let _ = options.textOpacity {
            layer.textOpacity = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_OPACITY)
        }
        
        if let _ = options.textColor {
            layer.textColor = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_COLOR)
        }
        
        if let _ = options.textHaloColor {
            layer.textHaloColor = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_HALOCOLOR)
        }
        
        if let _ = options.textHaloWidth {
            layer.textHaloWidth = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_HALOWIDTH)
        }
        
        if let _ = options.textHaloBlur {
            layer.textHaloBlur = NSExpression(forKeyPath: SymbolOptions.KEY_SYMBOL_TEXT_HALOBLUR)
        }
        
    }
}

