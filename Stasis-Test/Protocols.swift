protocol MainView: AnyObject {

}

protocol MainPresenterProtocol {
    func createKeyRequested()
    func viewKeyRequested()
    func importKeyRequested()
    func deleteKeyRequested()
}

protocol KeyImportDelegate {
    func gotKey(_ key: String, password: String)
}

protocol PasswordInputDelegate: AnyObject {
    func gotPassword(_ password: String)
}
