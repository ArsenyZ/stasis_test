class MainPresenter: MainPresenterProtocol, PasswordInputDelegate {

    weak var view: MainView!
    var router: ViewRouter!

    let repository  = KeyRepository()

    func createKeyRequested() {
        let passwordInput = ViewFactory.createPasswordView(with: self)
        router.presentController(passwordInput)
    }

    func gotPassword(_ password: String) {
        repository.createKeys(for: password)
        router.dismissController()
    }

    func viewKeyRequested() {
        let alert = ViewFactory.createQueryAlert { [unowned self] password in
            if let payload = self.repository.getKeys(for: password) {
                let view = ViewFactory.createExportView(with: self, payload: payload)
                router.presentController(view)
            }
        }
        router.presentAlert(alert)
    }

    func importKeyRequested() {
        let alert = ViewFactory.createQueryAlert { [unowned self] password in
            let view = ViewFactory.createImportView(with: self, password: password)
            router.presentController(view)
        }
        router.presentAlert(alert)
    }

    func deleteKeyRequested() {
        let alert = ViewFactory.createQueryAlert { [unowned self] password in
            self.repository.deleteKeys(for: password)
        }
        router.presentAlert(alert)
    }
}

extension MainPresenter: KeyImportDelegate {
    func gotKey(_ key: String, password: String) {

        if let keys = repository.importKeys(for: password, key: key),
           let existing = repository.getKeys(for: password) {
            let alert = ViewFactory.createOverwriteAlert { [unowned self] in
                self.repository.savePayload(password: password, payload: keys)
            }
            router.presentAlert(alert)
        }
    }
}
