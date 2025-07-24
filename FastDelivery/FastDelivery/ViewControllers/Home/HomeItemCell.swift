import UIKit

class HomeItemCell: UICollectionViewCell {
    
    static let reuseID = "HomeItemCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let addButton = UIButton(type: .system)
    private let stack = UIStackView()
    
    private var product: Product?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        configureCardStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 120).isActive = true

        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(addButton)
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    private func style() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .darkGray
        
        addButton.setTitle("Adicionar", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
    }

    private func configureCardStyle() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false
    }

    func config(with product: Product) {
        self.product = product
        imageView.image = UIImage(named: product.image)
        titleLabel.text = product.title
        priceLabel.text = product.price
    }
}

// MARK: - Actions
extension HomeItemCell {
    @objc func addProduct() {
        guard let product = product else { return }
        CartService.shared.addItem(product)
    }
}
