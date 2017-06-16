import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    
    @IBOutlet weak var stationsCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stationsCollectionView.delegate = self
        self.stationsCollectionView.dataSource = self
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        addLogoToCollectionViewBackground()
        
        
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coll_cell", for: indexPath) as! StationsCollectionViewCell
        
        cell.stationName.text = "Політехнічний Інститут"
        
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
        stationsCollectionView.backgroundColor = UIColor(colorLiteralRed: 53/255, green: 73/255, blue: 93/255, alpha: 1.0)
        stationsCollectionView.backgroundView = logoImageView
    }
    
}

