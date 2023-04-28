import UIKit

class MainViewController: UIViewController, MainView {

    var presenter: MainPresenterProtocol!

    @IBOutlet private var buttonCreate: UIButton!
    @IBOutlet private var buttonExport: UIButton!
    @IBOutlet private var buttonImport: UIButton!
    @IBOutlet private var buttonDelete: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonCreate.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        buttonExport.addTarget(self, action: #selector(viewButtonTapped), for: .touchUpInside)
        buttonImport.addTarget(self, action: #selector(importButtonTapped), for: .touchUpInside)
        buttonDelete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc func createButtonTapped() {
        presenter.createKeyRequested()
    }

    @objc func viewButtonTapped() {
        presenter.viewKeyRequested()
    }

    @objc func importButtonTapped() {
        presenter.importKeyRequested()
    }

    @objc func deleteButtonTapped() {
        presenter.deleteKeyRequested()
    }
}

