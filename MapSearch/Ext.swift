//
//  Ext.swift
//  MapSearch
//
//  Created by 坂尻愛明 on 2019/02/01.
//  Copyright © 2019 cha1ra.com. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        //アラートを作成
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        // OKをクリックされたら閉じる
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        //アラートを表示
        self.present(alert, animated: true)
    }
}
