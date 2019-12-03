import Flutter
import UIKit
import Mapbox

class MapboxMapController: NSObject, FlutterPlatformView, MGLMapViewDelegate, MapboxMapOptionsSink {
    
    private var registrar: FlutterPluginRegistrar
    private var channel: FlutterMethodChannel?
    
    
    private var mapView: MGLMapView
    private var locales: Locale?
    private var style: MGLStyle?
  
    private var isMapReady = false
    private var mapReadyResult: FlutterResult?
    
    private var initialTilt: CGFloat?
    private var cameraTargetBounds: MGLCoordinateBounds?
    private var trackCameraPosition = false
    private var myLocationEnabled = true
    
    private var lineManager: LineManager?
    private var circleManager: CircleManager?
    private var symbolManager: SymbolManager?
    
    
    func view() -> UIView {

        return mapView
    }

    
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, registrar: FlutterPluginRegistrar) {
        mapView = MGLMapView(frame: frame)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MGLUserTrackingMode.none
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.registrar = registrar
        
        super.init()
        
        channel = FlutterMethodChannel(name: "plugins.flutter.io/mapbox_maps_\(viewId)", binaryMessenger: registrar.messenger())
        channel!.setMethodCallHandler(onMethodCall)
        
        mapView.delegate = self
        
        if let args = args as? [String: Any] {
            Convert.interpretMapboxMapOptions(options: args["options"], delegate: self)
            if let initialCameraPosition = args["initialCameraPosition"] as? [String: Any],
                let camera = MGLMapCamera.fromDict(initialCameraPosition, mapView: mapView),
                let zoom = initialCameraPosition["zoom"] as? Double {
                mapView.setCenter(camera.centerCoordinate, zoomLevel: zoom, direction: camera.heading, animated: false)
                initialTilt = camera.pitch
            }
        }
    }
    
    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera, reason: MGLCameraChangeReason) -> Bool {
        self.onCameraTrackingDismissed()
        return true
    }
    
    func onMethodCall(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(methodCall.method) {
        case "map#waitForMap":
            if isMapReady {
                result(nil)
            } else {
                mapReadyResult = result
            }
        case "map#update":
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            Convert.interpretMapboxMapOptions(options: arguments["options"], delegate: self)
            if let camera = getCamera() {
                result(camera.toDict(mapView: mapView))
            } else {
                result(nil)
            }
        case "camera#move":
            print("点击移动symbol")
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let cameraUpdate = arguments["cameraUpdate"] as? [Any] else { return }
            if let camera = Convert.parseCameraUpdate(cameraUpdate: cameraUpdate, mapView: mapView) {
//                mapView.setCenter(camera.centerCoordinate, zoomLevel: 15, animated: true)
                mapView.fly(to: camera, withDuration: 1, completionHandler: nil)
                mapView.setCenter(camera.centerCoordinate, zoomLevel: 15, animated: true)
            }
        case "camera#animate":
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let cameraUpdate = arguments["cameraUpdate"] as? [Any] else { return }
            
            if let camera = Convert.parseCameraUpdate(cameraUpdate: cameraUpdate, mapView: mapView) {
//                mapView.setCamera(camera, animated: true)
                mapView.setCenter(camera.centerCoordinate, zoomLevel: 15, animated: true)
                 mapView.fly(to: camera, withDuration: 1, completionHandler: nil)
            }
            
        case "camera#ease":
            
//            guard let arguments = methodCall.arguments as? [String: Any] else { return }
//            guard let animates = arguments["easeCamera"] as? [Any] else { return }
//            let lat1:Double = arguments["lat1"] as! Double
//            let lng1:Double = arguments["lng1"] as! Double
//            let zoom:Int = arguments["zoom"] as! Int
//            let durationMs:Int = arguments["durationMs"] as! Int
//
//
//            let  currentCenter = CLLocationCoordinate2DMake(lat1, lng1)
//
//
//            mapView.setCenter(currentCenter, zoomLevel: 15, animated: true)
//            if let camera = Convert.parseCameraUpdate(cameraUpdate: animates, mapView: mapView) {
//
//                if let duration = arguments["durationMs"] as? Int {
//
//                    mapView.fly(to: camera, withDuration: 1, completionHandler: nil)
//                }
//
//            }
//
//
            break
     
            
        case "symbol#add":
            print("打印add")
            guard let symbolManager = symbolManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            
            if let options = arguments["options"] as? NSDictionary {
                
                if let geometry = options["geometry"] as? [Double] {
                    
                    if geometry.count == 0 {
                        
                        result(nil)
                        
                        break
                    }
                }
            }
                        
            // Create a circle and populate it.
            let symbolBuilder = SymbolBuilder(symbolManager: symbolManager)
            Convert.interpretSymbolOptions(options: arguments["options"], delegate: symbolBuilder)
            if let symbol = symbolBuilder.build() {
                result("\(symbol.id)")
            } else {
                result(nil)
            }
            
        case "mapbox#localization":
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let language = arguments["language"] as? String else { return }
            setLangauage(language: language)

            break
            
        case "mapbox#allowSymbolOverlap":

            guard let symbolManager = symbolManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let enable = arguments["allowOverlap"] as? [Bool: Any] else { return }

            symbolManager.layer?.iconAllowsOverlap = NSExpression(forConstantValue: enable)
            symbolManager.layer?.textAllowsOverlap = NSExpression(forConstantValue: enable)
            symbolManager.layer?.textIgnoresPlacement = NSExpression(forConstantValue: enable)
            symbolManager.layer?.iconIgnoresPlacement = NSExpression(forConstantValue: enable)
            
            break
        
            
        case "symbol#update":
            guard let symbolManager = symbolManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let symbolIdString = arguments["symbol"] as? String else { return }
            guard let symbolId = UInt64(symbolIdString) else { return }
            guard let symbol = symbolManager.getAnnotation(id: symbolId) else { return }

            // Create a circle and populate it.
            let symbolBuilder = SymbolBuilder(symbolManager: symbolManager, symbol: symbol)
            Convert.interpretSymbolOptions(options: arguments["options"], delegate: symbolBuilder)
            symbolBuilder.update(id: symbolId)
            result(nil)
        case "symbol#remove":
            guard let symbolManager = symbolManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let symbolIdString = arguments["symbol"] as? String else { return }
            guard let symbolId = UInt64(symbolIdString) else { return }
            guard let symbol = symbolManager.getAnnotation(id: symbolId) else { return }
            
            symbolManager.delete(annotation: symbol)
            result(nil)
        case "line#add":
            guard let lineManager = lineManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            
            if let options = arguments["options"] as? NSDictionary {
                
                if let geometry = options["geometry"] as? [[Double]] {
                    
                    if geometry.count == 0 {
                        
                        result(nil)
                        
                        break
                    }
                }
            }
            
            // Create a line and populate it.
            let lineBuilder = LineBuilder(lineManager: lineManager)
            Convert.interpretLineOptions(options: arguments["options"], delegate: lineBuilder)
            if let line = lineBuilder.build() {
                result("\(line.id)")
            } else {
                result(nil)
            }
        case "line#update":
            guard let lineManager = lineManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let lineIdString = arguments["line"] as? String else { return }
            guard let lineId = UInt64(lineIdString) else { return }
            guard let line = lineManager.getAnnotation(id: lineId) else { return }
            
            // Create a line and update it.
            let lineBuilder = LineBuilder(lineManager: lineManager, line: line)
            Convert.interpretLineOptions(options: arguments["options"], delegate: lineBuilder)
            lineBuilder.update(id: lineId)
            result(nil)
        case "line#remove":
            guard let lineManager = lineManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let lineIdString = arguments["line"] as? String else { return }
            guard let lineId = UInt64(lineIdString) else { return }
            guard let line = lineManager.getAnnotation(id: lineId) else { return }
            
            lineManager.delete(annotation: line)
            result(nil)
        case "circle#add":
            guard let circleManager = circleManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            
            if let options = arguments["options"] as? NSDictionary {
                
                if let geometry = options["geometry"] as? [Double] {
                    
                    if geometry.count == 0 {
                        
                        result(nil)
                        
                        break
                    }
                }
            }
            // Create a circle and populate it.
            let circleBuilder = CircleBuilder(circleManager: circleManager)
            Convert.interpretCircleOptions(options: arguments["options"], delegate: circleBuilder)
            if let circle = circleBuilder.build() {
                result("\(circle.id)")
            } else {
                result(nil)
            }
        case "circle#update":
            guard let circleManager = circleManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let circleIdString = arguments["circle"] as? String else { return }
            guard let circleId = UInt64(circleIdString) else { return }
            guard let circle = circleManager.getAnnotation(id: circleId) else { return }
            
            // Create a circle and populate it.
            let circleBuilder = CircleBuilder(circleManager: circleManager, circle: circle)
            Convert.interpretCircleOptions(options: arguments["options"], delegate: circleBuilder)
            circleBuilder.update(id: circleId)
            result(nil)
        case "circle#remove":
            guard let circleManager = circleManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let circleIdString = arguments["circle"] as? String else { return }
            guard let circleId = UInt64(circleIdString) else { return }
            guard let circle = circleManager.getAnnotation(id: circleId) else { return }
            
            circleManager.delete(annotation: circle)
            result(nil)
        case "location#getLastLatLng":
            if myLocationEnabled == false{
                result(nil)
            }else{
                result(["latitude":mapView.userLocation?.location?.coordinate.latitude,"longitude":mapView.userLocation?.location?.coordinate.longitude])
            }
        case "circle#getGeometry":
            guard let circleManager = circleManager else { return }
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let circleIdString = arguments["circle"] as? String else { return }
            guard let circleId = UInt64(circleIdString) else { return }
            guard let circle = circleManager.getAnnotation(id: circleId) else { return }
            
            let circleGeometry = circle.geometry
            result(["latitude":circleGeometry.coordinates[1],"longitude":circleGeometry.coordinates[0]])
        case "style#addImages":
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            guard let mapDic = arguments["map"] as? [String:String] else {return}
            
            for (key, value) in mapDic {
                
                var imageBase = value
                
                if value.hasPrefix("data:image/png;base64,") {
                    
                    imageBase = String(value.suffix("data:image/png;base64,".count))
                }
                
                guard let imgNSData = NSData(base64Encoded: imageBase, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else {
                    return
                }
                // 3、将NSData的图片，转换成UIImage
                if let codeImage = UIImage(data: imgNSData as Data) {
                    
                    mapView.style?.setImage(codeImage, forName: key);
                }
            }
            result(nil)
        case "extra#snapshot":
            guard let arguments = methodCall.arguments as? [String: Any] else { return }
            
            guard let width = arguments["width"] as? Int else { return  }
            
            guard let height = arguments["height"] as? Int else { return  }
            
            guard let lat = arguments["lat"] as? Double else { return  }
            
            guard let lng = arguments["lng"] as? Double else { return  }
            
            guard let quality = arguments["quality"] as? Int else { return  }
            
            guard let zoom = arguments["zoom"] as? Double else { return  }
            
            let camera = MGLMapCamera.init()
            
            camera.centerCoordinate = CLLocationCoordinate2DMake(lat, lng)
            
            let options = MGLMapSnapshotOptions.init(styleURL: self.mapView.styleURL, camera: camera, size: CGSize.init(width: width, height: height))
            
            options.zoomLevel = zoom
            
            let snapshotter = MGLMapSnapshotter.init(options: options)
            
            snapshotter.start { (snapshot, error) in
                
                if error != nil {
                    
                    if let image = snapshot?.image {
                        
                        /*
                         如果是要用到有symbol等自定义layer的，吧下面两行的注释打开，
                         再吧let data = image.jpegData(compressionQuality: CGFloat(Float(arguments)/100))注释掉就可以了
                         */
                        //                    let imageFinal = self.getMapCurrentImage(target: self.mapView, backImage: image)
                        //
                        //                    let data = imageFinal.jpegData(compressionQuality: CGFloat(Float(arguments)/100))
                        
                        let data = image.jpegData(compressionQuality: CGFloat(Double(quality)/100.0))
                        
                        result((data!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0)) as NSString).replacingOccurrences(of: "\r\n", with: ""))
                    }
                }else{
                    result(error)
                }
                
            }
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    private func updateMyLocationEnabled() {
        //TODO
        if let userLocation = mapView.userLocation {
            
            if let coordinate = userLocation.location {
                mapView.setCenter(coordinate.coordinate, animated: true)
            }
        }
    }
    
    private func getCamera() -> MGLMapCamera? {
        return trackCameraPosition ? mapView.camera : nil
    }
    
    
//    regiondidchangean
    
    private func setLangauage(language:String?){
        switch language {
        case "name_zh_Hans":
            style?.localizeLabels(into: Locale(identifier: "Hans"))
            break
        case "name_zh_Hant":
             style?.localizeLabels(into: Locale(identifier: "Hant"))
            break
        case "name_en":
            style?.localizeLabels(into: Locale(identifier: "en"))
            break
        default:
            break
        }
    }
    
    /*
     *  MGLMapViewDelegate
     */
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
         updateMyLocationEnabled()
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        isMapReady = true
       
        updateMyLocationEnabled()
        
        style.localizeLabels(into: nil)
        
        
        if let initialTilt = initialTilt {
            let camera = mapView.camera
            camera.pitch = initialTilt
            mapView.setCamera(camera, animated: false)
        }
        
        lineManager = LineManager()
        if let lineManager = lineManager {
            style.addSource(lineManager.source)
            style.addLayer(lineManager.layer!)
        }
        
        circleManager = CircleManager()
        if let circleManager = circleManager {
            style.addSource(circleManager.source)
            style.addLayer(circleManager.layer!)
        }
        
        symbolManager = SymbolManager()
        if let symbolManager = symbolManager{
            style.addSource(symbolManager.source)
            style.addLayer(symbolManager.layer!)
        }
        
        mapReadyResult?(nil)
    }

    
    func mapView(_ mapView: MGLMapView, shouldChangeFrom oldCamera: MGLMapCamera, to newCamera: MGLMapCamera) -> Bool {
        guard let bbox = cameraTargetBounds else { return true }
        // Get the current camera to restore it after.
        let currentCamera = mapView.camera
        
        // From the new camera obtain the center to test if it’s inside the boundaries.
        let newCameraCenter = newCamera.centerCoordinate
        
        // Set the map’s visible bounds to newCamera.
        mapView.camera = newCamera
        let newVisibleCoordinates = mapView.visibleCoordinateBounds
        
        // Revert the camera.
        mapView.camera = currentCamera
        
        // Test if the newCameraCenter and newVisibleCoordinates are inside bbox.
        let inside = MGLCoordinateInCoordinateBounds(newCameraCenter, bbox)
        let intersects = MGLCoordinateInCoordinateBounds(newVisibleCoordinates.ne, bbox) && MGLCoordinateInCoordinateBounds(newVisibleCoordinates.sw, bbox)
        
        return inside && intersects
    }
    
    /*
     *  MapboxMapOptionsSink
     */
    func setCameraTargetBounds(bounds: MGLCoordinateBounds?) {
        cameraTargetBounds = bounds
    }
    func setCompassEnabled(compassEnabled: Bool) {
        mapView.compassView.isHidden = compassEnabled
        mapView.compassView.isHidden = !compassEnabled
    }
    func setMinMaxZoomPreference(min: Double, max: Double) {
        mapView.minimumZoomLevel = min
        mapView.maximumZoomLevel = max
    }
    func setStyleString(styleString: String) {
        // Check if json, url or plain string:
        if styleString.isEmpty {
            NSLog("setStyleString - string empty")
        } else if (styleString.hasPrefix("{") || styleString.hasPrefix("[")) {
            // Currently the iOS Mapbox SDK does not have a builder for json.
            NSLog("setStyleString - JSON style currently not supported")
        } else {
            mapView.styleURL = URL(string: styleString)
        }
    }
    func setRotateGesturesEnabled(rotateGesturesEnabled: Bool) {
        mapView.allowsRotating = rotateGesturesEnabled
    }
    func setScrollGesturesEnabled(scrollGesturesEnabled: Bool) {
        mapView.allowsScrolling = scrollGesturesEnabled
    }
    func setTiltGesturesEnabled(tiltGesturesEnabled: Bool) {
        mapView.allowsTilting = tiltGesturesEnabled
    }
    func setTrackCameraPosition(trackCameraPosition: Bool) {
        self.trackCameraPosition = trackCameraPosition
    }
    func setZoomGesturesEnabled(zoomGesturesEnabled: Bool) {
        mapView.allowsZooming = zoomGesturesEnabled
    }
    func setMyLocationEnabled(myLocationEnabled: Bool) {
        if (self.myLocationEnabled == myLocationEnabled) {
            return
        }
        self.myLocationEnabled = myLocationEnabled
        updateMyLocationEnabled()
    }
    func setMyLocationTrackingMode(myLocationTrackingMode: MGLUserTrackingMode) {
        mapView.userTrackingMode = myLocationTrackingMode
       
    }
    
    
    func getMapCurrentImageBase64(zoom: Double) -> NSString {
        
        let options = MGLMapSnapshotOptions.init(styleURL: self.mapView.styleURL, camera: self.mapView.camera, size: self.mapView.bounds.size)
        
        options.zoomLevel = self.mapView.zoomLevel
        
        let snapshotter = MGLMapSnapshotter.init(options: options)
        
        var imageCopy = UIImage.init()
        
        snapshotter.start { (snapshot, error) in
            
            CFRunLoopStop(CFRunLoopGetMain())
            
            if let image = snapshot?.image {
                
                imageCopy = image
            }
            
        }
        
        CFRunLoopRun()
        
        let image = self.getMapCurrentImage(target: self.mapView, backImage: imageCopy)
        
        let data = image.jpegData(compressionQuality: CGFloat(zoom))
        
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0)) as NSString
    }
    
    func  onCameraTrackingDismissed() {
        channel?.invokeMethod("map#onCameraTrackingDismissed", arguments: nil)
     }
    

    func getMapCurrentImage(target: UIView, backImage: UIImage) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(backImage.size, false, UIScreen.main.scale)
        
        let content = UIGraphicsGetCurrentContext()!
        
        backImage.draw(in: CGRect.init(x: 0, y: 0, width: backImage.size.width, height: backImage.size.height))
        
        content.translateBy(x: (backImage.size.width - target.bounds.size.width) * 0.5, y: (backImage.size.height - target.bounds.size.height) * 0.5)
        
        target.layer.render(in: content)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndPDFContext()
        
        return image!
        
    }
    
}

