
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate{
    
    func didUpdatePrice(price: String, currency: String){
        
        DispatchQueue.main.async{
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }

    func didFailWithError(error: Error){
        print(error)
    }
}

//MARK: - UIPicker View Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    // Determine how many columns I want in my picker.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // See how many rows this picker should have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

