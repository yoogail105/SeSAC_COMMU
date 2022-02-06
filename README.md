# SeSAC_COMMU

![SesacCommu 001](https://user-images.githubusercontent.com/53874628/152661993-ebecc44e-253e-4c17-b13a-3c3e7c2a24c8.png)

👉서버와 통신하여 **회원가입, 로그인**을 한 후 **게시물과 댓글**을 작성할 수 있는 **커뮤니티 앱**

　✔︎ 회원가입, 로그인, 비밀번호 변경

　✔︎ 게시글과 댓글의 작성/수정/삭제
<br/>
<br/>

# Skils, Framework, Library

- UIkit
- MVVM 패턴
- SnapKit을 통해 Programmatically 뷰 작성
- URL Session, Codable을 통해 API 통신
- RxSwift를 통해 회원가입 시 유효성 검증
<br/>
<br/>

# Video


<br/>
<br/>

# Issues

### 1. API 통신 오류 찾기

- API통신을 하면서 알고보면 간단한(?) 오류들을 많이 겪었다. 내 손가락은 언제든 같은 실수를 반복할 수 있기 때문에.. 어떤 부분들을 확인하며 오류를 발견할 수 있었는지 정리해보자. (핵심은 ***디버그***)

  0. 인섬니아 통해서 api 통신에 필요한 바디, 헤더 등 요청에 필요한 요소와 그리고 결과값의 형태 확인하기

  1. 내가 뭘 보내고 있는지 확인하기

     손가락이 실수를 자주 한다.. 요청 형식과 다르게 보내거나, optional값을 해제하지 않고 그대로 보내는 등의 오류로 애를 먹을 때가 있다(몇시간, 혹은 하루 종일 뭐가 문제인지 못찾기도 했다.)

     `print`를 통해 내가 최종적으로 보낸 정보를 꼼꼼하게 확인하는 것, 중요!

  2. 디버그 창에서 어떤 오류, 어떤 상태코드가 날아오는지 확인한다.

     ```swift
     struct ErrorDetail: Codable {	
         let statusCode: Int
         let error: String
         let message: String
     }
     
     //URLSession
     guard response.statusCode == 200 else {
       do {
         print("statusCode: ", response.statusCode)
         let decoder = JSONDecoder()
     		let errorDetail = try decoder.decode(ErrorDetail.self, from: data)
     		completion(nil, .failed)
     		print("error:", errorDetail.message)
     		return
     	} catch {
     		print("status code do-catch: 여기오류")                    
     		completion(nil, .invalidData)
     		return
     	}
     }
     ```

     상태코드가 200이 아닌 경우 에러 메세지를 확인했다.

     에러 메세지에 따라서 토큰의 문제인지, 내가 요청해야하는 값을 덜 작성했는지 등을 체크해본다.

     ...

     그런데 위에 처럼 굳이 오류메세지를 디코딩하지 않고, 그냥 데이터를 출력해주면 되기도 하다.(첨에 몰랐음)

     ```swift
     let str = String(decoding: data!, as: UTF8.self)
     print("결과:::::::\n data: \(str)\n response: \(response)\n error: \(error)")
     ```

     이런 식으로 출력을 해주어도 상태코드와 메세지가 나온다.

     

  3. 상태코드가 200으로 값이 잘 오고 있는데, 코더블에서 오류가 나는 경우라면, 코더블의 구조를 확인한다.

     내가 자주 틀리는 지점은 응답값이 **array**일 때... 나는 딕셔너리를 보냈는데 array를 받아왔다는 오류 메세지를 자주 봤다.

     

     `debugDescription: "Expected to decode Dictionary<String, Any> but found an array instead."`

     이런 오류를 만난다면 구조체로 달려가 내가 보내고 있는 것이 무엇인지 확인하기
     

### 2. Toast message / Alert 표시 후 화면 전환이 일어날 때

- 댓글을 수정/삭제 하고 나서 '수정되었습니다.', '삭제되었습니다.' 등의 메세지를 표시하는 것에서는 같은 뷰에서 일어나는 일이기 때문에 문제가 없었다. 하지만 토스트 메세지를 띄운 후에 화면을 전환하는 경우에는 추가적인 처리를 해 주어야 했다.

  ```swift
  func makeToast(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    self.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.dismiss(animated: true)
    }
  }
  
  viewModel.postAddPosts(text: mainView.textField.text!) {
    self.showToast(message: "저장 되었습니다🌱")
    self.navigationController?.popViewController(animated: true)
  }
  ```

  - 나의 예상은 저장되었다는 메세지가 3초 정도 띄워진 후, popViewController를 통해서 뷰가 사라지는 것.

    👉 하지만 실제로는,  바로 popViewController가 실행되어서 글 메뉴 화면으로 이동

    ​		⇢ 글 작성 화면에 떠 있는 toast message를 볼 겨를이 없다.

- 액션이 없는 `Alert`과 `asyncAfter`을 통해 Toast message가 뷰에 보여진 후, 일정 시간이 지난 후에 화면이 전환되도록 구현했다.

  ```swift
  func makeToastAndPop(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    self.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
      self.dismiss(animated: true) {
        self.navigationController?.popViewController(animated: true)
      }
    })
  }
  
  viewModel.postAddPosts(text: mainView.textField.text!) {
    self.makeToastAndPop(message: "저장 되었습니다🌱")
  }
  ```

 ### 3. 도전과제1: MVVM 패턴

- 지금까지 MVC패턴으로만 코드를 작성해왔다. 만보랑 출시 프로젝트를 MVC패턴으로 작성하면서, `ViewController`가 주체할 수 없게 길어지는 것을 경험하며.. 자연스럽게 MVVM의 필요성에 대해서 느꼈던 것 같다. 이번 프로젝트에는 이에 대해 공부하여 적용하려고 노력했다.

  1. View와 Model의 분리

     간단하게 말하면, 뷰는 뷰를! 모델은 데이터를 담당하게 해 주면 된다. (말은 쉽다...)

     내가 이해한 것은.. 앞서 말한 것처럼 view는 화면을 그리는 역할에 충실하도록, 그리고 model은 화면에 보여질 데이터와 로직을 가지고 있으면서, viewController는 그 둘을 연결`bind`해 주면 된다.

  2. 그래서 구현은?

     View()는 말그대로 화면을 그리는 역할만을 수행하게 했고, ViewModel에서는 API 통신 등의 처리를 하도록 구현했다. 최대한 뷰컨트롤러가 어떠한 로직을 수행하지 않게 하려고 노력했다. 하지만 여전히 ViewController의 역할을 완전히 덜어내지 못한 것 같다. 더 공부하며 리팩토링을 해야겠다.

### 4. 도전과제2: RxSwift

- 이전에 내가 사용한 옵저버라 하면,, `notificaion center`가 있다. 사용자의 어떠한 행동에 대해서 즉각 반응하는 UI는 앱을 사용하는 사람이라면 자연스럽게, 중요하게 느끼고 있을 것이다. 그리고 개인적으로는 Swift를 공부하면서 어쩌면 가장 마음처럼 되지 않고, 구현하는 데에 어려움을 겪었던 부분이기도 하다. 그래서 `RxSwift`를 활용해 보려고 노력했다.

  1. RxSwift를 통해 텍스트필드의 유효성 검증하기

     ```swift
     // ViewModel
     var passwordObserver = BehaviorRelay<String>(value: "")
     var isValidConfirmPassword: Observable<Bool> {
             return Observable.combineLatest(passwordObserver, confirmPasswordObserver)
                 .map { password, confirmPassword in
                     return password == confirmPassword
                 }
     }
     
     // ViewController
     mainView.passwordTextField.rx.text
                 .map { $0 ?? "" }
                 .bind(to: viewModel.passwordObserver)
                 .disposed(by: disposeBag)
     
     viewModel.isValidConfirmPassword
                 .map { $0 ? UIColor(named: "SSACGreen") : UIColor.red }
                 .bind(to: mainView.confirmPasswordTextField.rx.textColor)
                 .disposed(by: disposeBag)
     
     
     ```

     - 정규식을 통해 비밀번호의 유효성을 검증한 후, 유효하다면`isValidConfirmPassword`, 텍스트의 색상을 녹색으로, 유효하지 않다면 빨간 색으로 바꾸어주도록 했다.

  2. RxSwift를 통해 버튼 활성화 시키기

     ```swift
     // ViewModel
     var isValidForm: Observable<Bool> {
             return Observable.combineLatest(userNameObserver, emailObserver, passwordObserver, confirmPasswordObserver)
                 .map { userName, email, password, confirmPassword in
                     return userName.count > 1 && email.validateEmail() && password.validatePassword() && password == confirmPassword
                 }
     }
     
     // ViewController
     viewModel.isValidForm
                 .bind(to: mainView.signButton.rx.isEnabled)
                 .disposed(by: disposeBag)
     viewModel.isValidForm
                 .map{ $0 ? 1.0 : 0.3}
                 .bind(to: mainView.signButton.rx.alpha)
                 .disposed(by: disposeBag)
     ```

     - 회원가입 시 입력되어야 하는 이메일, 비밀번호, 이름 등의 항목들이 올바르게 채워지면, 회원가입버튼이 활성화 되도록 구현했다.  이렇게 RxSwift를 통해 유효성을 검증하며 클라이언트 단계에서 사용자의 입력값 오류를 최대한 걸러낼 수 있도록 했다.
