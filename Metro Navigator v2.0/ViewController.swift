import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stationsTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stationsTableView.dataSource = self
        self.stationsTableView.delegate = self
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        addLogoToTableViewBackground()
        stationsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StationsTableViewCell
        cell.backgroundColor = .clear
        cell.stationName.text = "Політехнічний Інститут"
        cell.backgroundColor = UIColor(colorLiteralRed: 47/255, green: 226/255, blue: 191/255, alpha: 0.9)
        
        return cell
    }
    
    
    @IBAction func showSearchPopup(_ sender: UIButton) {
        let popOverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchPopUp") as! SearchViewController
        
        self.addChildViewController(popOverViewController)
        popOverViewController.view.frame = self.view.frame
        self.view.addSubview(popOverViewController.view)
        popOverViewController.didMove(toParentViewController: self)
        
    }
    
    private func addLogoToTableViewBackground() {
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        stationsTableView.backgroundView = logoImageView
    }
    
}

