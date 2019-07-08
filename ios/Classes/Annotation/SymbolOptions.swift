import Mapbox

class SymbolOptions: Options<SymbolGeometry> {
    
    static let KEY_SYMBOL_ICON_SIZE = "symbol-iconSize"
    static let KEY_SYMBOL_ICON_IMAGE = "symbol-iconImage"
    static let KEY_SYMBOL_ICON_ROTATE = "symbol-iconRotate"
    static let KEY_SYMBOL_ICON_OFFSET = "symbol-IconOffset"
    static let KEY_SYMBOL_ICON_ANCHOR = "symbol-iconAnchor"
    static let KEY_SYMBOL_TEXT_FIELD = "symbol-textField"
    static let KEY_SYMBOL_TEXT_SIZE = "symbol-textSize"
    static let KEY_SYMBOL_TEXT_MAXWIDTH = "symbol-textMaxWidth"
    static let KEY_SYMBOL_TEXT_LETTERSPACIMG = "symbol-textLetterSpacing"
    static let KEY_SYMBOL_TEXT_JUSTIFY = "symbol-textJustify"
    static let KEY_SYMBOL_TEXT_ANCHOR = "symbol-textAnchor"
    static let KEY_SYMBOL_TEXT_ROTATE = "symbol-textRotate"
    static let KEY_SYMBOL_TEXT_TRANSFORM = "symbol-textTransform"
    static let KEY_SYMBOL_TEXT_OFFSET = "symbol-textOffset"
    static let KEY_SYMBOL_ICON_OPACITY = "symbol-iconOpacity"
    static let KEY_SYMBOL_ICON_COLOR = "symbol-iconColor"
    static let KEY_SYMBOL_ICON_HALOCOLOR = "symbol-iconHaloColor"
    static let KEY_SYMBOL_ICON_HALOWIDTH = "symbol-iconHaloWidth"
    static let KEY_SYMBOL_ICON_HALOBLUR = "symbol-iconHaloBlur"
    static let KEY_SYMBOL_TEXT_OPACITY = "symbol-textOpacity"
    static let KEY_SYMBOL_TEXT_COLOR = "symbol-textColor"
    static let KEY_SYMBOL_TEXT_HALOCOLOR = "symbol-textHaloColor"
    static let KEY_SYMBOL_TEXT_HALOWIDTH = "symbol-textHaloWidth"
    static let KEY_SYMBOL_TEXT_HALOBLUR = "symbol-textHaloBlur"
    static let KEY_SYMBOL_GEOMETRY = "symbol-geometry"
    static let KEY_SYMBOL_Z_INDEX = "symbol-zindex"
    static let KEY_SYMBOL_DRAGGABLE = "symbol-draggable"
    
    
    private var properties: [String: AnyEncodable]
    
    init(properties: [String: AnyEncodable]) {
        self.properties = properties
    }
    
    convenience override init() {
        self.init(properties: [String: AnyEncodable]())
    }
    
    private(set) var geometry: SymbolGeometry?
    
    func setGeometry(geometry: [Double]) {
        self.geometry = SymbolGeometry(coordinates: geometry)
    }
    
    
    var iconSize: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_SIZE] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_SIZE] = AnyEncodable(newValue)
        }
    }
    
    var iconImage: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_IMAGE] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_IMAGE] = AnyEncodable(newValue)
        }
    }
    
    var iconRotate: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_ROTATE] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_ROTATE] = AnyEncodable(newValue)
        }
    }
    
    var iconOffset: [Float]? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_OFFSET] {
                return value.encodable as? [Float]
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_OFFSET] = AnyEncodable(newValue)
        }
    }
    
    var iconAnchor: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_ANCHOR] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_ANCHOR] = AnyEncodable(newValue)
        }
    }
    
    var textField: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_FIELD] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_FIELD] = AnyEncodable(newValue)
        }
    }
    
    var textSize: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_SIZE] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_SIZE] = AnyEncodable(newValue)
        }
    }
    
    var textMaxWidth: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_MAXWIDTH] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_MAXWIDTH] = AnyEncodable(newValue)
        }
    }
    
    var textLetterSpacing: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_LETTERSPACIMG] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_LETTERSPACIMG] = AnyEncodable(newValue)
        }
    }
    
    var textJustify: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_JUSTIFY] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_JUSTIFY] = AnyEncodable(newValue)
        }
    }
    
    var textAnchor: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_ANCHOR] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_ANCHOR] = AnyEncodable(newValue)
        }
    }
    
    var textRotate: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_ROTATE] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_ROTATE] = AnyEncodable(newValue)
        }
    }
    
    var textTransform: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_TRANSFORM] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_TRANSFORM] = AnyEncodable(newValue)
        }
    }
    
    var textOffset: [Float]? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_OFFSET] {
                return value.encodable as? [Float]
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_OFFSET] = AnyEncodable(newValue)
        }
    }
    
    var iconOpacity: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_OPACITY] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_OPACITY] = AnyEncodable(newValue)
        }
    }
    
    var iconColor: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_COLOR] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_COLOR] = AnyEncodable(newValue)
        }
    }
    
    var iconHaloColor: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_HALOCOLOR] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_HALOCOLOR] = AnyEncodable(newValue)
        }
    }
    
    var iconHaloWidth: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_HALOWIDTH] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_HALOWIDTH] = AnyEncodable(newValue)
        }
    }
    
    var iconHaloBlur: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_ICON_HALOBLUR] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_ICON_HALOBLUR] = AnyEncodable(newValue)
        }
    }
    
    var textOpacity: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_OPACITY] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_OPACITY] = AnyEncodable(newValue)
        }
    }
    
    var textColor: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_COLOR] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_COLOR] = AnyEncodable(newValue)
        }
    }
    
    var textHaloColor: String? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_HALOCOLOR] {
                return value.encodable as? String
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_HALOCOLOR] = AnyEncodable(newValue)
        }
    }
    
    var textHaloWidth: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_HALOWIDTH] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_HALOWIDTH] = AnyEncodable(newValue)
        }
    }
    
    var textHaloBlur: Float? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_TEXT_HALOBLUR] {
                return value.encodable as? Float
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_TEXT_HALOBLUR] = AnyEncodable(newValue)
        }
    }
    
    var zIndex: Int? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_Z_INDEX] {
                return value.encodable as? Int
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_Z_INDEX] = AnyEncodable(newValue)
        }
    }
    
    var draggable: Bool? {
        get{
            if let value = properties[SymbolOptions.KEY_SYMBOL_DRAGGABLE] {
                return value.encodable as? Bool
            }
            return nil
        }
        set(newValue) {
            properties[SymbolOptions.KEY_SYMBOL_DRAGGABLE] = AnyEncodable(newValue)
        }
    }
    
    
    
    override func build(id: UInt64) -> Feature<SymbolGeometry>? {
        if let geometry = geometry  {
            return Symbol(id: id, geometry: geometry, properties: properties)
        }
        return nil
    }
}
