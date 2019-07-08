
class SymbolBuilder: SymbolOptionsSink {
    
    private var symbolOptions: SymbolOptions
    private var symbolManager: SymbolManager
    
    init(symbolManager: SymbolManager, options: SymbolOptions) {
        self.symbolManager = symbolManager
        self.symbolOptions = options
    }
    
    convenience init(symbolManager: SymbolManager) {
        self.init(symbolManager: symbolManager, options: SymbolOptions())
    }
    
    convenience init(symbolManager: SymbolManager, symbol: Symbol) {
        let symbolOptions = SymbolOptions(properties: symbol.properties)
        symbolOptions.setGeometry(geometry: symbol.geometry.coordinates)
        self.init(symbolManager: symbolManager, options: symbolOptions)
    }
    
    func setGeometry(geometry: [Double]) {
        symbolOptions.setGeometry(geometry: [geometry[1], geometry[0]])
    }
    
    func setIconSize(iconSize: Float) {
        symbolOptions.iconSize = iconSize
    }
    
    func setIconImage(iconImage: String) {
        symbolOptions.iconImage = iconImage
    }
    
    func setIconRotate(iconRotate: Float) {
        symbolOptions.iconRotate = iconRotate
    }
    
    func setIconOffset(iconOffset: [Float]) {
        symbolOptions.iconOffset = iconOffset
    }
    
    func setIconAnchor(iconAnchor: String) {
        symbolOptions.iconAnchor = iconAnchor
    }
    
    func setTextField(textField: String) {
        symbolOptions.textField = textField
    }
    
    func setTextSize(textSize: Float) {
        symbolOptions.textSize = textSize
    }
    
    func setTextMaxWidth(textMaxWidth: Float) {
        symbolOptions.textMaxWidth = textMaxWidth
    }
    
    func setTextLetterSpacing(textLetterSpacing: Float) {
        symbolOptions.textLetterSpacing = textLetterSpacing
    }
    
    func setTextJustify(textJustify: String) {
        symbolOptions.textJustify = textJustify
    }
    
    func setTextAnchor(textAnchor: String) {
        symbolOptions.textAnchor = textAnchor
    }
    
    func setTextRotate(textRotate: Float) {
        symbolOptions.textRotate = textRotate
    }
    
    func setTextTransform(textTransform: String) {
        symbolOptions.textTransform = textTransform
    }
    
    func setTextOffset(textOffset: [Float]) {
        symbolOptions.textOffset = textOffset
    }
    
    func setIconOpacity(iconOpacity: Float) {
        symbolOptions.iconOpacity = iconOpacity
    }
    
    func setIconColor(iconColor: String) {
        symbolOptions.iconColor = iconColor
    }
    
    func setIconHaloColor(iconHaloColor: String) {
        symbolOptions.iconHaloColor = iconHaloColor
    }
    
    func setIconHaloWidth(iconHaloWidth: Float) {
        symbolOptions.iconHaloWidth = iconHaloWidth
    }
    
    func setIconHaloBlur(iconHaloBlur: Float) {
        symbolOptions.iconHaloBlur = iconHaloBlur
    }
    
    func setTextOpacity(textOpacity: Float) {
        symbolOptions.textOpacity = textOpacity
    }
    
    func setTextColor(textColor: String) {
        symbolOptions.textColor = textColor
    }
    
    func setTextHaloColor(textHaloColor: String) {
        symbolOptions.textHaloColor = textHaloColor
    }
    
    func setTextHaloWidth(textHaloWidth: Float) {
        symbolOptions.textHaloWidth = textHaloWidth
    }
    
    func setTextHaloBlur(textHaloBlur: Float) {
        symbolOptions.textHaloBlur = textHaloBlur
    }
    
    func setZIndex(index: Int) {
        symbolOptions.zIndex = index
    }
    
    func setDraggable(draggable: Bool) {
        symbolOptions.draggable = draggable
    }
    
    func build() -> Symbol? {
        return symbolManager.create(options: symbolOptions)
    }
    
    func update(id: UInt64) {
        symbolManager.update(id: id, options: symbolOptions)
    }
}
