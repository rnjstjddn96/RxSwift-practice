//
//  ViewController.swift
//  RxSwift-Playground
//
//  Created by 권성우 on 2020/09/28.
//  Copyright © 2020 swkwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    let imageUrl = "https://picsum.photos/800/600/?random"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func loadImageAsync(from imageUrl: String) {
        var image: UIImage = UIImage()
        DispatchQueue.global().async {
            guard let url = URL(string: self.imageUrl) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            if let _image = UIImage(data: imageData) {
                image = _image
            }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func loadImage(_ sender: UIButton) {
// ----> Domain 오류로 실행불가
//        self.loadImageAsync(from: self.imageUrl)
//        Observable<String>.just("800x600")
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
//            .map { $0.replacingOccurrences(of: "x", with: "/") }
//            .map { "http://picsum.photos/\($0)/?random"}
//            .map { URL(string: $0) }
//            .map { $0! }
//            .map { try Data(contentsOf: $0) }
//            .map { UIImage(data: $0) }
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { image in
//                self.imageView.image = image
//            }).disposed(by: disposeBag)
        
        Observable<String>.just("https://madi-1302397712.cos.ap-seoul.myqcloud.com/images/5f068824571c4a3c2510df27_1599185518291.png")
            .map { URL(string: $0) }
            .map { $0! }
            .map { try Data(contentsOf: $0) }
            .map { UIImage(data: $0) }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .do(onNext: { image in
                if let _image = image {
                    print(_image.size)
                }
            })
            .subscribe(onNext: { [weak self] image in
                self?.imageView.image = image
        }).disposed(by: disposeBag)
    }
    
//SideEffect가 혀용되는 공간
//    1. subscribe
//    2. do
    
//    SubscribeOn -------------------------------------------
//    SubscribeOn은 구독(subscribe)에서 사용할 스레드를 지정
//    도중 ObserveOn이 호출되어도 SubscribeOn의 스레드 지정에는 영향을 끼치지 않는다.
    
//    ObserveOn ----------------------------------------------
//    ObserveOn은 Observable이 다음처리를 진행할때 사용할 스레드를 지정
//    ObserveOn이 선언된 후 처리가 진행뒤 다른 ObserveOn이 선언시 다른 ObserveOn에서 선언한 스레드로 변경되어 이후 처리를 진행한다.
    
    @IBAction func cancelImage(_ sender: UIButton) {
    }
    
}

