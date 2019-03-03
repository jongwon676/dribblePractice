import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{

    let cellId = "cellId"
    let padding:CGFloat = 15
    
    var datasources = [1,1,1,1,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.8757488666, green: 0.8757488666, blue: 0.8757488666, alpha: 1)
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCell
        
        cell.backView.removeFromCollectionView = { [weak self] in
            guard let `self` = self else { return }
            self.datasources.remove(at: indexPath.item)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }, completion: nil)
            }
        }
        return cell
    }
    
    func removeAnimationCell(){
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datasources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width -  2 * padding, height: 100)
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

