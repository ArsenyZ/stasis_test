import UIKit

class ExportViewController: UIViewController {

    @IBOutlet private var imageViewQR: UIImageView!
    @IBOutlet private var buttonCopy: UIButton!

    var imgQR: UIImage!
    var key: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageViewQR.image = imgQR
        self.buttonCopy.addTarget(self, action: #selector(buttonCopyTapped), for: .touchUpInside)

    }

    @objc func buttonCopyTapped() {
        UIPasteboard.general.string = key
    }

}
