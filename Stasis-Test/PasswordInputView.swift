import UIKit

class PasswordInputView: UIViewController {

    @IBOutlet private var inputFirst: UITextField!
    @IBOutlet private var inputSecond: UITextField!
    @IBOutlet private var labelHint: UILabel!
    @IBOutlet private var buttonContinue: UIButton!
    weak var delegate: PasswordInputDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        labelHint.isHidden = true
        buttonContinue.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }

    @objc func continueTapped() {
        if let pass1 = inputFirst.text,
           let pass2 = inputSecond.text,
           !pass1.isEmpty,
           !pass2.isEmpty,
           pass1 == pass2 {
            gotPassword(pass1)
        } else {
            labelHint.isHidden = false
        }
    }

    func gotPassword(_ password: String) {
        delegate.gotPassword(password)
    }

}
