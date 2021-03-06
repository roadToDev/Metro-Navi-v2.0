import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var departureStation: UISearchBar!
    @IBOutlet weak var arivalStation: UISearchBar!
    
    
    
    var autoCompleteStations = NavigatorData.autoCompleteStations
    var autoComplete = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departureStation.returnKeyType = UIReturnKeyType.done
        arivalStation.returnKeyType = UIReturnKeyType.done
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.departureStation.delegate = self
        self.arivalStation.delegate = self

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    @IBAction func searchWay(_ sender: UIButton) {
        if checkStations() {
            self.removeAnimate()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var substring = (searchBar.text! as NSString).replacingCharacters(in: range, with: text)
        substring = substring.lowercased()
        searchForAutocomplete(substring: substring)
        
        return true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel!.text = autoComplete[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        if departureStation.isFirstResponder {
            departureStation.text = selectedCell.textLabel!.text!
        }
            
        else if arivalStation.isFirstResponder {
            arivalStation.text = selectedCell.textLabel!.text!
        }
        
    }
    
    func searchForAutocomplete(substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        for key in autoCompleteStations {
            var myString: NSString! = key as NSString
            myString = myString.lowercased as NSString
            let substringRange: NSRange! = myString.range(of: substring)
            if substringRange.location == 0 {
                autoComplete.append(key)
            }
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let searchViewController = segue.destination as! ViewController
        let waySearcher = WaySearcher(departure: departureStation.text!, arrival: arivalStation.text!)
        searchViewController.changeStation = waySearcher.getChangeStationsNames().firstChange
        searchViewController.stations = waySearcher.getTheWay()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if checkStations() {
            return true
        } else {
            return false
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func checkStations() -> Bool {
        var flag = 0
        for station in autoCompleteStations {
            if station == arivalStation.text {
                flag += 1
            } else if station == departureStation.text {
                flag += 1
            }
        }
        if flag == 2 && arivalStation.text != departureStation.text {
            return true
        } else {
            return false
        }
    }
    
    ////////////// ANIMATION /////////////
    
    private func showAnimate() {
        self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = self.view.transform.scaledBy(x: 0.7, y: 0.7)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished) {

                self.view.removeFromSuperview()
                
            }
            
        })
    }
    

}
