import UIKit
import RxSwift

let subject: BehaviorSubject<String> = BehaviorSubject<String>(value: "Start?")

subject.onNext("Start please")

let subscriptionOne = subject.subscribe(onNext: {
    print("subs1: \($0)")
})

subject.onNext("next1")
subject.onNext("next2")

let subscriptionTwo = subject.subscribe({ event in
    print("subs2: \(event.element ?? "")")
})

subject.onNext("next3")
subject.onCompleted()

subject.onNext("next4")

subscriptionOne.dispose()
subscriptionTwo.dispose()

let disposeBag = DisposeBag()

subject.subscribe {
    print("subs3:", $0.element ?? $0)
}.disposed(by: disposeBag)

