import UIKit

class HomeViewController: UIViewController {
    
    var searchProductField = UISearchTextField()
    var productsCollection: UICollectionView!
    
    let products = ProductRepository.getDefaultProducts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: UIColor.label
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        view.backgroundColor = .systemGroupedBackground
        
        style()
        layout()
        setupCollectionView()
    }
}

// MARK: - Layout & Estilo
extension HomeViewController {
    
    private func style() {
        searchProductField.translatesAutoresizingMaskIntoConstraints = false
        searchProductField.placeholder = "Buscar produtos..."
        searchProductField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchProductField.backgroundColor = .systemGroupedBackground
        searchProductField.layer.cornerRadius = 12
        searchProductField.layer.masksToBounds = true
        
    }
    
    private func layout() {
        view.addSubview(searchProductField)
        
        NSLayoutConstraint.activate([
            searchProductField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchProductField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchProductField.trailingAnchor, multiplier: 2),
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let itemWidth = (view.bounds.width - 48) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 230)
        
        productsCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        productsCollection.translatesAutoresizingMaskIntoConstraints = false
        productsCollection.backgroundColor = .clear
        productsCollection.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.reuseID)
        productsCollection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        productsCollection.dataSource = self
        productsCollection.delegate = self
        
        view.addSubview(productsCollection)
        
        NSLayoutConstraint.activate([
            productsCollection.topAnchor.constraint(equalTo: searchProductField.bottomAnchor, constant: 16),
            productsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            productsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.reuseID, for: indexPath) as? HomeItemCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.item]
        cell.config(with: product)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {}
