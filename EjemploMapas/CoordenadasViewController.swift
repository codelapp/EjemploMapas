import UIKit
import CoreLocation

class CoordenadasViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var lbCoordenadas: UILabel!
    var manager = CLLocationManager()
    var latitud: CLLocationDegrees!
    var longitud: CLLocationDegrees!

    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latitud = location.coordinate.latitude
            self.longitud = location.coordinate.longitude
        }
    }
    
    @IBAction func btnVerCoordenadas(_ sender: UIButton) {
        lbCoordenadas.text = "lat: \(self.latitud!) / long: \(self.longitud!)"
    }
    
    @IBAction func btnEnviarCoordenadas(_ sender: UIButton) {
        performSegue(withIdentifier: "enviarCoordenadas", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviarCoordenadas" {
            if let destino = segue.destination as? MapaViewController {
                destino.latitudMapa = latitud
                destino.longitudMapa = longitud
            }
        }
    }
    
}
