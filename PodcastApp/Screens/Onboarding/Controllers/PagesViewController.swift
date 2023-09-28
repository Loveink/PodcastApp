import UIKit

class PagesViewController: UIPageViewController {

    // MARK: - Properties

    var pages = [UIViewController]()
    let initialPage = 0

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
        $0.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        return $0
    }(UIButton())

    let nextButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Next", for: .normal)
        $0.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        return $0
    }(UIButton())

    var pageControlBottomAnchor: NSLayoutConstraint?
//    var skipButtonTopAnchor: NSLayoutConstraint?
//    var nextButtonTopAnchor: NSLayoutConstraint?

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
                                             secondLabel: UILabel.makeLabelForCells(text: "Superapp Superapp Superapp",
                                                                                    font: UIFont.plusJakartaSansMedium(size: 15),
                                                                                    textColor: UIColor.textDarkgray2,
                                                                                    numberOfLines: 3))

        let page3 = OnboardingViewController(imageName: "page3",
                                             mainLabel: UILabel.makeLabelForCells(text: "SUPERAPP SUPERAPP SUPERAPP",
                                                                                  font: UIFont.plusJakartaSansBold(size: 34),
                                                                                  textColor: UIColor.textDarkgray2,
                                                                                  numberOfLines: 3),
                                             secondLabel: UILabel.makeLabelForCells(text: "Superapp Superapp Superapp",
                                                                                    font: UIFont.plusJakartaSansMedium(size: 15),
                                                                                    textColor: UIColor.textDarkgray2,
                                                                                    numberOfLines: 3))

        let page4 = LoginViewController()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }

    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage

        NSLayoutConstraint.activate([

            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),

            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2)
        ])

        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 4)
//        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 2)
//        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 2)

        pageControlBottomAnchor?.isActive = true
//        skipButtonTopAnchor?.isActive = true
//        nextButtonTopAnchor?.isActive = true
    }
}

    // MARK: - Data Source

extension PagesViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}

    // MARK: - Delegate

extension PagesViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }

    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1

        if lastPage {
            hideControls()
        } else {
            showControls()
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func hideControls() {
//        pageControlBottomAnchor?.constant = -80
    }

    private func showControls() {
        pageControlBottomAnchor?.constant = -30
    }
}

extension PagesViewController {

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

    @objc func skipTapped (_ sender: UIButton) {
        let lastPage = pages.count - 1
        pageControl.currentPage = lastPage

        goToLoginPage(index: lastPage, ofViewControllers: pages)
        animateControlsIfNeeded()
    }

    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }
}

extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToLoginPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
