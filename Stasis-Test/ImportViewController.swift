import UIKit

class ImportViewController: UIViewController {

    @IBOutlet private var inputField: UITextView!
    @IBOutlet private var buttonContinue: UIButton!

    var delegate: KeyImportDelegate!
    var password: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.becomeFirstResponder()
        buttonContinue.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }

    @objc func continueTapped() {
        delegate.gotKey(inputField.text, password: password)
    }
}

/*
 MIICXAIBAAKBgQDWnyZzpne4/aNOTRc5qDmjyebbyjDsm8jULk3RJTiNFHlLvRRQCgSQ9QpU9VjLsg8yBGTBd0ycKITZ5GO6vLZ7kx3Tv39yJd2/9W7eEBmr1cJ6y22pWiYBZp72i6k7PHWLt54XFGYViPnio02cY1INS6xiVWxmbW40xj7ynL4znwIDAQABAoGAGexnTJjS5TldvFt7bq9vJuWASRQHDM1UWKyvIZAJYKEUdZ2FEpXjL08pzFFGRHRheX0mXmf2jPYn9dmsYiXhNJsiUH3hV1trsccv4tHG3Ctvq3xJ3BY7K0IGPhGNEAlqTLOqM3QeU55PDUenR8C8Vx4Ooc/lm+YRlZ3w79yX06ECQQD+tDVHmJ6655sipCsJMgOKu9o6Qj4v9FwgJf8InUFLbOqZKAvfAUANBiX8FOKZ/DENAFnU2sQUfB+emoLNEzYNAkEA17a6iGZ2YnRb1jsL+MAj4qOS2z+WG9v2WCVl/ZPATAa/+Np0TUSAu+XorUiG0Zx+pClitmaQgaVBBcwXaPexWwJAOU4gQqiC5fhf/g5DpID9LQSQ19S5mx52b8E8vRpsa2To72aELTthxsxgVXP5e72y54LxsyM5RIacspl+3lb5LQJAQEQjXKHSIVDzT2b2ER0FU+9RwFo4WYJ16RrzQNH1F3FnXjePMLn49IHxiTazW92Y6UWfMCJsaQOX1KdSTiaFQwJBANra8gEZ/e3gN39+Cu4eFyFm8afBd4ffLnpdKiK1yPebsLbTv66pwwCAchv6uyIHihyD6Kyq7XZvhaLMo7xwfck=
 */
