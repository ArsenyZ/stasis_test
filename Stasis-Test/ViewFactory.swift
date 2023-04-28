import UIKit

class ViewFactory {

    static func createMainView() -> UIViewController {
        let presenter = MainPresenter()
        let view = MainViewController(nibName: "MainViewController", bundle: .main)
        let router = ViewRouter(mainView: view)
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
        return view
    }

    static func createPasswordView(with delegate: PasswordInputDelegate) -> UIViewController {
        let view = PasswordInputView(nibName: "PasswordInputView", bundle: .main)
        view.delegate = delegate
        return view
    }

    static func createExportView(with delegate: PasswordInputDelegate, payload: KeyPayload) -> UIViewController {
        let view = ExportViewController(nibName: "ExportViewController", bundle: .main)
        let img = createQR(from: payload.publicKey)
        view.imgQR = img
        view.key = payload.privateKey
//        view.delegate = delegate
        return view
    }


    static func createImportView(with delegate: KeyImportDelegate, password: String) -> UIViewController {
        let view = ImportViewController(nibName: "ImportViewController", bundle: .main)
        view.delegate = delegate
        view.password = password
        return view
    }

    static func createQueryAlert(with completion: @escaping (_: String) -> Void ) -> UIAlertController {
        let alert = UIAlertController(title: "Enter password", message: nil, preferredStyle: .alert)
        alert.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in
            let password = alert.textFields![0].text ?? ""
            completion(password)
        }

        alert.addAction(submitAction)
        return alert
    }

    static func createOverwriteAlert(with completion: @escaping () -> Void ) -> UIAlertController {
        let alert = UIAlertController(title: "Key already exists", message: "Overwrite?", preferredStyle: .alert)

        let submitAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        return alert
    }

    static func createQR(from string: String) -> UIImage? {
        let data = string.data(using: .utf8)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

class ViewRouter {
    var mainView: UIViewController

    init(mainView: UIViewController) {
        self.mainView = mainView
    }

    func presentAlert(_ alert: UIAlertController) {
        dismissController()
        mainView.present(alert, animated: true)
    }

    func presentController(_ controller: UIViewController) {
        controller.modalPresentationStyle = .pageSheet
        controller.preferredContentSize = controller.view.intrinsicContentSize
        mainView.present(controller, animated: true)
    }

    func dismissController() {
        mainView.dismiss(animated: true)
    }
}
