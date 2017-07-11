import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stationsCollectionView: UICollectionView!
    
    var changeStation : String?
    var stations = [Station]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stationsCollectionView.delegate = self
        self.stationsCollectionView.dataSource = self
        
        self.timeLabel.text = TimeHandler.getFullTime(stations)
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if stations.count == 0 {
            addLogoToCollectionViewBackground()
        } else {
            addBackgroundColorToCollectionView()
        }
        
       
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return stations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coll_cell", for: indexPath) as! StationsCollectionViewCell
       
        cell.stationName.text = stations[indexPath.row].name
        cell.timeToNextStation.text = TimeHandler.secondsToMinutesSeconds(seconds: (stations[indexPath.row].timeToNextStation))
        switch stations[indexPath.row].line{
        case .red:
            cell.backgroundColor = UIColor(red: 232/255, green: 79/255, blue: 61/255, alpha: 1.0)
        case .blue:
            cell.backgroundColor = UIColor(red: 49/255, green: 150/255, blue: 219/255, alpha: 1.0)
        case .green:
            cell.backgroundColor = UIColor(red: 16/255, green: 188/255, blue: 156/255, alpha: 1.0)
        }
        
        if stations[indexPath.row].name == changeStation {
            cell.transferImage.image = #imageLiteral(resourceName: "transfer")
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: stationsCollectionView.frame.width, height: 33)
    }
    
    
    @IBAction func showSearchPopup(_ sender: UIButton) {
        let popOverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchPopUp") as! SearchViewController
        
        self.addChildViewController(popOverViewController)
        popOverViewController.view.frame = self.view.frame
        self.view.addSubview(popOverViewController.view)
        popOverViewController.didMove(toParentViewController: self)
        
    }
    
    private func addLogoToCollectionViewBackground() {
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        addBackgroundColorToCollectionView()
        stationsCollectionView.backgroundView = logoImageView
    }
    
    private func addBackgroundColorToCollectionView(){
        stationsCollectionView.backgroundColor = UIColor(colorLiteralRed: 53/255, green: 73/255, blue: 93/255, alpha: 1.0)
    }
    
}

