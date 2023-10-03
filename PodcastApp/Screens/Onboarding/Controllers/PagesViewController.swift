import UIKit

class PagesViewController: UIPageViewController {

    // MARK: - Properties

    var pages = [UIViewController]()
    let initialPage = 0
    var nextIndex = 0

    // MARK: - UI Elements

    let pageControl: UIPageControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.currentPageIndicatorTintColor = .black
        $0.pageIndicatorTintColor = .systemGray2
        return $0
    }(UIPageControl())

    let skipButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Skip", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.addTarget(self, action: #selector(goToLoginPage(_:)), for: .primaryActionTriggered)
        return $0
    }(UIButton())

    let nextButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Next", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.backgroundColor = UIColor.borderGray
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        return $0
    }(UIButton())

    let getStarted: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Get Started", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.manropeBold(size: 16)
        $0.backgroundColor = UIColor.bluePlayer
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(goToLoginPage(_:)), for: .primaryActionTriggered)
        return $0
    }(UIButton())

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        layout()
    }
}

extension PagesViewController {

    func setup() {

        dataSource = self
        delegate = delegate

        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)

        let page1 = OnboardingViewController(imageName: "page1",
                                             mainLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                  font: UIFont.plusJakartaSansBold(size: 34),
                                                                                  textColor: UIColor.textDarkgray2,
                                                                                  numberOfLines: 3),
                                             secondLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                    font: UIFont.plusJakartaSansMedium(size: 15),
                                                                                    textColor: UIColor.textDarkgray2,
                                                                                    numberOfLines: 3))

        let page2 = OnboardingViewController(imageName: "page2",
                                             mainLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                  font: UIFont.plusJakartaSansBold(size: 34),
                                                                                  textColor: UIColor.textDarkgray2,
                                                                                  numberOfLines: 3),
                                             secondLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                    font: UIFont.plusJakartaSansMedium(size: 15),
                                                                                    textColor: UIColor.textDarkgray2,
                                                                                    numberOfLines: 3))

        let page3 = OnboardingViewController(imageName: "page3",
                                             mainLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                  font: UIFont.plusJakartaSansBold(size: 34),
                                                                                  textColor: UIColor.textDarkgray2,
                                                                                  numberOfLines: 3),
                                             secondLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                    font: UIFont.plusJakartaSansMedium(size: 15),
                                                                                    textColor: UIColor.textDarkgray2,
                                                                                    numberOfLines: 3))

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }

    func layout() {

        [pageControl, nextButton, skipButton, getStarted].forEach { view.addSubview($0) }

        getStarted.isHidden = true

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage

        NSLayoutConstraint.activate([

            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),

            skipButton.widthAnchor.constraint(equalToConstant: 85),
            skipButton.heightAnchor.constraint(equalToConstant: 58),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),

            nextButton.widthAnchor.constraint(equalToConstant: 85),
            nextButton.heightAnchor.constraint(equalToConstant: 58),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),

            getStarted.heightAnchor.constraint(equalToConstant: 58),
            getStarted.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            getStarted.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            getStarted.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
    }
}

    // MARK: - Data Source

extension PagesViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        nextIndex = currentIndex - 1

        if currentIndex != 0 {
            pageControl.currentPage = nextIndex
            return pages[currentIndex - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        nextIndex = currentIndex + 1

        if currentIndex < pages.count - 1 {
            pageControl.currentPage = nextIndex
            return pages[currentIndex + 1]
        } else {
            let loginVC = LoginViewController()
            hideControls()
            return loginVC
        }
    }

    private func hideControls() {
        self.skipButton.isHidden = true
        self.nextButton.isHidden = true
        self.pageControl.isHidden = true
    }
}

    // MARK: - Extension

extension PagesViewController {

    func goToNextPage() {

        guard let currentPage = viewControllers?.first as? OnboardingViewController, let currentIndex = pages.firstIndex(of: currentPage) else { return }

        let nextIndex = currentIndex + 1
        if nextIndex < pages.count && nextIndex != 3 {
            setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
        } else if nextIndex == 3 {
            self.goToLoginPage(skipButton)
        }
    }

    private func animateControlsIfNeeded() {

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                       delay: 0,
                                                       options: [.curveEaseOut],
                                                       animations: { self.view.layoutIfNeeded() },
                                                       completion: nil)
    }

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }

    @objc func goToLoginPage (_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}
