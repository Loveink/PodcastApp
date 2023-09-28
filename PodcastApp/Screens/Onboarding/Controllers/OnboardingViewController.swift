import Foundation
import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - UI Elements

    private lazy var headView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private lazy var backgroundView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.backgroundColor = UIColor.onboardingViewBlue
        return $0
    }(UIImageView())

    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()

    // MARK: - Init

    init (imageName: String, mainLabel: UILabel, secondLabel: UILabel) {
        super .init(nibName: nil, bundle: nil)
        headView.image = UIImage(named: imageName)
        titleLabel = mainLabel
        subtitleLabel = secondLabel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
}

    // MARK: - Extension

extension OnboardingViewController {

    func layout() {

        [headView, backgroundView, titleLabel, subtitleLabel].forEach( { view.addSubview($0) } )

        let inset: CGFloat = 20
        let titleInset: CGFloat = 30

        let screen = UIScreen.main
        let screenWidth = screen.bounds.size.width
        let viewSize = screenWidth - 40

        NSLayoutConstraint.activate([

            headView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            headView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            headView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            headView.heightAnchor.constraint(equalToConstant: viewSize),

            backgroundView.topAnchor.constraint(equalTo: headView.bottomAnchor, constant: inset),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),

            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: titleInset),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: titleInset),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -titleInset),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleInset),
            subtitleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: titleInset),
            subtitleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -titleInset)
        ])
    }
}
