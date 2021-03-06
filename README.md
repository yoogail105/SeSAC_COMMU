# SeSAC_COMMU

![SesacCommu 001](https://user-images.githubusercontent.com/53874628/152661993-ebecc44e-253e-4c17-b13a-3c3e7c2a24c8.png)

๐์๋ฒ์ ํต์ ํ์ฌ **ํ์๊ฐ์, ๋ก๊ทธ์ธ**์ ํ ํ **๊ฒ์๋ฌผ๊ณผ ๋๊ธ**์ ์์ฑํ  ์ ์๋ **์ปค๋ฎค๋ํฐ ์ฑ**

ใโ๏ธ ํ์๊ฐ์, ๋ก๊ทธ์ธ, ๋น๋ฐ๋ฒํธ ๋ณ๊ฒฝ

ใโ๏ธ ๊ฒ์๊ธ๊ณผ ๋๊ธ์ ์์ฑ/์์ /์ญ์ 
<br/>
<br/>

# Skils, Framework, Library

- UIkit
- MVVM ํจํด
- SnapKit์ ํตํด Programmatically ๋ทฐ ์์ฑ
- URL Session, Codable์ ํตํด API ํต์ 
- RxSwift๋ฅผ ํตํด ํ์๊ฐ์ ์ ์ ํจ์ฑ ๊ฒ์ฆ
<br/>
<br/>

# Issues

### 1. API ํต์  ์ค๋ฅ ์ฐพ๊ธฐ

- APIํต์ ์ ํ๋ฉด์ ์๊ณ ๋ณด๋ฉด ๊ฐ๋จํ(?) ์ค๋ฅ๋ค์ ๋ง์ด ๊ฒช์๋ค. ๋ด ์๊ฐ๋ฝ์ ์ธ์ ๋  ๊ฐ์ ์ค์๋ฅผ ๋ฐ๋ณตํ  ์ ์๊ธฐ ๋๋ฌธ์.. ์ด๋ค ๋ถ๋ถ๋ค์ ํ์ธํ๋ฉฐ ์ค๋ฅ๋ฅผ ๋ฐ๊ฒฌํ  ์ ์์๋์ง ์ ๋ฆฌํด๋ณด์. (ํต์ฌ์ ***๋๋ฒ๊ทธ***)

  0. ์ธ์ฌ๋์ ํตํด์ api ํต์ ์ ํ์ํ ๋ฐ๋, ํค๋ ๋ฑ ์์ฒญ์ ํ์ํ ์์์ ๊ทธ๋ฆฌ๊ณ  ๊ฒฐ๊ณผ๊ฐ์ ํํ ํ์ธํ๊ธฐ

  1. ๋ด๊ฐ ๋ญ ๋ณด๋ด๊ณ  ์๋์ง ํ์ธํ๊ธฐ

     ์๊ฐ๋ฝ์ด ์ค์๋ฅผ ์์ฃผ ํ๋ค.. ์์ฒญ ํ์๊ณผ ๋ค๋ฅด๊ฒ ๋ณด๋ด๊ฑฐ๋, optional๊ฐ์ ํด์ ํ์ง ์๊ณ  ๊ทธ๋๋ก ๋ณด๋ด๋ ๋ฑ์ ์ค๋ฅ๋ก ์ ๋ฅผ ๋จน์ ๋๊ฐ ์๋ค(๋ช์๊ฐ, ํน์ ํ๋ฃจ ์ข์ผ ๋ญ๊ฐ ๋ฌธ์ ์ธ์ง ๋ชป์ฐพ๊ธฐ๋ ํ๋ค.)

     `print`๋ฅผ ํตํด ๋ด๊ฐ ์ต์ข์ ์ผ๋ก ๋ณด๋ธ ์ ๋ณด๋ฅผ ๊ผผ๊ผผํ๊ฒ ํ์ธํ๋ ๊ฒ, ์ค์!

  2. ๋๋ฒ๊ทธ ์ฐฝ์์ ์ด๋ค ์ค๋ฅ, ์ด๋ค ์ํ์ฝ๋๊ฐ ๋ ์์ค๋์ง ํ์ธํ๋ค.

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
     		print("status code do-catch: ์ฌ๊ธฐ์ค๋ฅ")                    
     		completion(nil, .invalidData)
     		return
     	}
     }
     ```

     ์ํ์ฝ๋๊ฐ 200์ด ์๋ ๊ฒฝ์ฐ ์๋ฌ ๋ฉ์ธ์ง๋ฅผ ํ์ธํ๋ค.

     ์๋ฌ ๋ฉ์ธ์ง์ ๋ฐ๋ผ์ ํ ํฐ์ ๋ฌธ์ ์ธ์ง, ๋ด๊ฐ ์์ฒญํด์ผํ๋ ๊ฐ์ ๋ ์์ฑํ๋์ง ๋ฑ์ ์ฒดํฌํด๋ณธ๋ค.

     ...

     ๊ทธ๋ฐ๋ฐ ์์ ์ฒ๋ผ ๊ตณ์ด ์ค๋ฅ๋ฉ์ธ์ง๋ฅผ ๋์ฝ๋ฉํ์ง ์๊ณ , ๊ทธ๋ฅ ๋ฐ์ดํฐ๋ฅผ ์ถ๋ ฅํด์ฃผ๋ฉด ๋๊ธฐ๋ ํ๋ค.(์ฒจ์ ๋ชฐ๋์)

     ```swift
     let str = String(decoding: data!, as: UTF8.self)
     print("๊ฒฐ๊ณผ:::::::\n data: \(str)\n response: \(response)\n error: \(error)")
     ```

     ์ด๋ฐ ์์ผ๋ก ์ถ๋ ฅ์ ํด์ฃผ์ด๋ ์ํ์ฝ๋์ ๋ฉ์ธ์ง๊ฐ ๋์จ๋ค.

     

  3. ์ํ์ฝ๋๊ฐ 200์ผ๋ก ๊ฐ์ด ์ ์ค๊ณ  ์๋๋ฐ, ์ฝ๋๋ธ์์ ์ค๋ฅ๊ฐ ๋๋ ๊ฒฝ์ฐ๋ผ๋ฉด, ์ฝ๋๋ธ์ ๊ตฌ์กฐ๋ฅผ ํ์ธํ๋ค.

     ๋ด๊ฐ ์์ฃผ ํ๋ฆฌ๋ ์ง์ ์ ์๋ต๊ฐ์ด **array**์ผ ๋... ๋๋ ๋์๋๋ฆฌ๋ฅผ ๋ณด๋๋๋ฐ array๋ฅผ ๋ฐ์์๋ค๋ ์ค๋ฅ ๋ฉ์ธ์ง๋ฅผ ์์ฃผ ๋ดค๋ค.

     

     `debugDescription: "Expected to decode Dictionary<String, Any> but found an array instead."`

     ์ด๋ฐ ์ค๋ฅ๋ฅผ ๋ง๋๋ค๋ฉด ๊ตฌ์กฐ์ฒด๋ก ๋ฌ๋ ค๊ฐ ๋ด๊ฐ ๋ณด๋ด๊ณ  ์๋ ๊ฒ์ด ๋ฌด์์ธ์ง ํ์ธํ๊ธฐ
     

### 2. Toast message ํ์ ํ ํ๋ฉด ์ ํ์ด ์ผ์ด๋  ๋

- ๋๊ธ์ ์์ /์ญ์  ํ๊ณ  ๋์ '์์ ๋์์ต๋๋ค.', '์ญ์ ๋์์ต๋๋ค.' ๋ฑ์ ๋ฉ์ธ์ง๋ฅผ ํ์ํ๋ ๊ฒ์์๋ ๊ฐ์ ๋ทฐ์์ ์ผ์ด๋๋ ์ผ์ด๊ธฐ ๋๋ฌธ์ ๋ฌธ์ ๊ฐ ์์๋ค. ํ์ง๋ง ํ ์คํธ ๋ฉ์ธ์ง๋ฅผ ๋์ด ํ์ ํ๋ฉด์ ์ ํํ๋ ๊ฒฝ์ฐ์๋ ์ถ๊ฐ์ ์ธ ์ฒ๋ฆฌ๋ฅผ ํด ์ฃผ์ด์ผ ํ๋ค.

  ```swift
  func makeToast(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    self.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.dismiss(animated: true)
    }
  }
  
  viewModel.postAddPosts(text: mainView.textField.text!) {
    self.showToast(message: "์ ์ฅ ๋์์ต๋๋ค๐ฑ")
    self.navigationController?.popViewController(animated: true)
  }
  ```

  - ๋์ ์์์ ์ ์ฅ๋์๋ค๋ ๋ฉ์ธ์ง๊ฐ 3์ด ์ ๋ ๋์์ง ํ, popViewController๋ฅผ ํตํด์ ๋ทฐ๊ฐ ์ฌ๋ผ์ง๋ ๊ฒ.

    ๐ ํ์ง๋ง ์ค์ ๋ก๋,  ๋ฐ๋ก popViewController๊ฐ ์คํ๋์ด์ ๊ธ ๋ฉ๋ด ํ๋ฉด์ผ๋ก ์ด๋

    โ		โข ๊ธ ์์ฑ ํ๋ฉด์ ๋  ์๋ toast message๋ฅผ ๋ณผ ๊ฒจ๋ฅผ์ด ์๋ค.

- ์ก์์ด ์๋ `Alert`๊ณผ `asyncAfter`์ ํตํด Toast message๊ฐ ๋ทฐ์ ๋ณด์ฌ์ง ํ, ์ผ์  ์๊ฐ์ด ์ง๋ ํ์ ํ๋ฉด์ด ์ ํ๋๋๋ก ๊ตฌํํ๋ค.

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
    self.makeToastAndPop(message: "์ ์ฅ ๋์์ต๋๋ค๐ฑ")
  }
  ```
  
 ###  3. Toast message, Alert ๋ชจ๋ํ

- ์ด์ด์, ์ด ํ๋ก์ ํธ์๋ ๋ค์ํ Alert์ ํํ๊ฐ ํ์ํ๊ณ , ๋ฐ๋ณต์ ์ผ๋ก ์ฌ์ฉ๋์๋ค.

  ๋จผ์  ๋ด๊ฐ Toast message๋ก ์ฌ์ฉํ ์ก์์ด ์๋ Alert, ๊ทธ๋ฆฌ๊ณ  ํ ํฐ์ด ๋ง๋ฃ๋์๊ฑฐ๋ ํ์๊ฐ์ ๋ง๋ฃ ์ ๋ฑ ์ ์ ๊ฐ `ํ์ธ` ๋ฒํผ๋ง์ ๋๋ฅด๋ Alert, ๋ง์ง๋ง์ผ๋ก `์ทจ์`์ `ํ์ธ`์ด ๋ชจ๋ ์๋ Alert.

  ๐ ํ์ํ  ๋ ๊ฐ๋จํ๊ฒ ํธ์ถํด์ ์ฌ์ฉํ  ์ ์๋๋ก, `๋ชจ๋ํ`๋ฅผ ํตํด ๊ตฌํํ๋ค.

  ```swift
  func makeAlert(message: String, okTitle: String, okAction: @escaping ((UIAlertAction) -> Void)) {
         let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
         okAction.redAlertText()
         alert.addAction(okAction)
          
         let cancelAction = UIAlertAction(title: "์ทจ์", style: .cancel)
         cancelAction.greenAlertText()
         alert.addAction(cancelAction)
          
          self.present(alert, animated: true)
  }
  
  func makeAlertWithoutCancel(message: String, okTitle: String, okAction: ((UIAlertAction) -> Void)?) {
     
          self.view.tintColor = UIColor(named: "SSACGreen")
          let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
          let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
          okAction.redAlertText()
          alert.addAction(okAction)
    
          self.present(alert, animated: true)
  }
  
  func makeToast(message: String) {
          let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
          
          self.present(alert, animated: true)
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.dismiss(animated: true)
          }
  }
  
  func makeToastAndPop(message: String) {
    
          let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
          self.present(alert, animated: true)
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
              self.dismiss(animated: true) {
                  self.navigationController?.popViewController(animated: true)
              }
          })
  }
  ```

   

 ### 4. ๋์ ๊ณผ์ 1: MVVM ํจํด

- ์ง๊ธ๊น์ง MVCํจํด์ผ๋ก๋ง ์ฝ๋๋ฅผ ์์ฑํด์๋ค. ๋ง๋ณด๋ ์ถ์ ํ๋ก์ ํธ๋ฅผ MVCํจํด์ผ๋ก ์์ฑํ๋ฉด์, `ViewController`๊ฐ ์ฃผ์ฒดํ  ์ ์๊ฒ ๊ธธ์ด์ง๋ ๊ฒ์ ๊ฒฝํํ๋ฉฐ.. ์์ฐ์ค๋ฝ๊ฒ MVVM์ ํ์์ฑ์ ๋ํด์ ๋๊ผ๋ ๊ฒ ๊ฐ๋ค. ์ด๋ฒ ํ๋ก์ ํธ์๋ ์ด์ ๋ํด ๊ณต๋ถํ์ฌ ์ ์ฉํ๋ ค๊ณ  ๋ธ๋ ฅํ๋ค.

  1. View์ Model์ ๋ถ๋ฆฌ

     ๊ฐ๋จํ๊ฒ ๋งํ๋ฉด, ๋ทฐ๋ ๋ทฐ๋ฅผ! ๋ชจ๋ธ์ ๋ฐ์ดํฐ๋ฅผ ๋ด๋นํ๊ฒ ํด ์ฃผ๋ฉด ๋๋ค. (๋ง์ ์ฝ๋ค...)

     ๋ด๊ฐ ์ดํดํ ๊ฒ์.. ์์ ๋งํ ๊ฒ์ฒ๋ผ view๋ ํ๋ฉด์ ๊ทธ๋ฆฌ๋ ์ญํ ์ ์ถฉ์คํ๋๋ก, ๊ทธ๋ฆฌ๊ณ  model์ ํ๋ฉด์ ๋ณด์ฌ์ง ๋ฐ์ดํฐ์ ๋ก์ง์ ๊ฐ์ง๊ณ  ์์ผ๋ฉด์, viewController๋ ๊ทธ ๋์ ์ฐ๊ฒฐ`bind`ํด ์ฃผ๋ฉด ๋๋ค.

  2. ๊ทธ๋์ ๊ตฌํ์?

     View()๋ ๋ง๊ทธ๋๋ก ํ๋ฉด์ ๊ทธ๋ฆฌ๋ ์ญํ ๋ง์ ์ํํ๊ฒ ํ๊ณ , ViewModel์์๋ API ํต์  ๋ฑ์ ์ฒ๋ฆฌ๋ฅผ ํ๋๋ก ๊ตฌํํ๋ค. ์ต๋ํ ๋ทฐ์ปจํธ๋กค๋ฌ๊ฐ ์ด๋ ํ ๋ก์ง์ ์ํํ์ง ์๊ฒ ํ๋ ค๊ณ  ๋ธ๋ ฅํ๋ค. ํ์ง๋ง ์ฌ์ ํ ViewController์ ์ญํ ์ ์์ ํ ๋์ด๋ด์ง ๋ชปํ ๊ฒ ๊ฐ๋ค. ๋ ๊ณต๋ถํ๋ฉฐ ๋ฆฌํฉํ ๋ง์ ํด์ผ๊ฒ ๋ค.

  3. ๊ฐ์ ํด์ผํ  ์ง์ 

   ์ง๊ธ ๋์ ์ฝ๋๋ ํ๋์ ํ๋ฉด์ `View, ViewModel, ViewController`๊ฐ ํ ์์ด๋ค. ๊ทธ๋ฐ๋ฐ ๊ตณ์ด `1:1` ๊ด๊ณ๋ฅผ ์ ์งํด์ผํ  ํ์๊ฐ ์์๊น? ๋ง์ฝ ํ์๊ฐ์ ๋ทฐ๊ฐ ํ ํ์ด์ง์ ์์ฑ๋์ง ์๊ณ  ์ฌ๋ฌ ํ๋ฉด์ ๊ฑธ์ณ์ ์งํ๋์๋ค๋ฉด, ์ด ๋์ ๋๋ ํด๋น๋๋ ๋ทฐ ๋งํผ์ viewModel์ ๋ง๋ค์์ ๊ฒ ๊ฐ๋ค. ์ ์ฌํ ๊ธฐ๋ฅ์ viewModel๋ค์ ํตํฉํด์ `1๋ ๋ค`๋ก ์์ ํด๋ณผ ํ์๊ฐ ์๋ค.

### 5. ๋์ ๊ณผ์ 2: RxSwift

- ์ด์ ์ ๋ด๊ฐ ์ฌ์ฉํ ์ต์ ๋ฒ๋ผ ํ๋ฉด,, `notificaion center`๊ฐ ์๋ค. ์ฌ์ฉ์์ ์ด๋ ํ ํ๋์ ๋ํด์ ์ฆ๊ฐ ๋ฐ์ํ๋ UI๋ ์ฑ์ ์ฌ์ฉํ๋ ์ฌ๋์ด๋ผ๋ฉด ์์ฐ์ค๋ฝ๊ฒ, ์ค์ํ๊ฒ ๋๋ผ๊ณ  ์์ ๊ฒ์ด๋ค. ๊ทธ๋ฆฌ๊ณ  ๊ฐ์ธ์ ์ผ๋ก๋ Swift๋ฅผ ๊ณต๋ถํ๋ฉด์ ์ด์ฉ๋ฉด ๊ฐ์ฅ ๋ง์์ฒ๋ผ ๋์ง ์๊ณ , ๊ตฌํํ๋ ๋ฐ์ ์ด๋ ค์์ ๊ฒช์๋ ๋ถ๋ถ์ด๊ธฐ๋ ํ๋ค. ๊ทธ๋์ `RxSwift`๋ฅผ ํ์ฉํด ๋ณด๋ ค๊ณ  ๋ธ๋ ฅํ๋ค.

  1. RxSwift๋ฅผ ํตํด ํ์คํธํ๋์ ์ ํจ์ฑ ๊ฒ์ฆํ๊ธฐ

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

     - ์ ๊ท์์ ํตํด ๋น๋ฐ๋ฒํธ์ ์ ํจ์ฑ์ ๊ฒ์ฆํ ํ, ์ ํจํ๋ค๋ฉด`isValidConfirmPassword`, ํ์คํธ์ ์์์ ๋น์์ผ๋ก, ์ ํจํ์ง ์๋ค๋ฉด ๋นจ๊ฐ ์์ผ๋ก ๋ฐ๊พธ์ด์ฃผ๋๋ก ํ๋ค.

  2. RxSwift๋ฅผ ํตํด ๋ฒํผ ํ์ฑํ ์ํค๊ธฐ

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

     - ํ์๊ฐ์ ์ ์๋ ฅ๋์ด์ผ ํ๋ ์ด๋ฉ์ผ, ๋น๋ฐ๋ฒํธ, ์ด๋ฆ ๋ฑ์ ํญ๋ชฉ๋ค์ด ์ฌ๋ฐ๋ฅด๊ฒ ์ฑ์์ง๋ฉด, ํ์๊ฐ์๋ฒํผ์ด ํ์ฑํ ๋๋๋ก ๊ตฌํํ๋ค.  ์ด๋ ๊ฒ RxSwift๋ฅผ ํตํด ์ ํจ์ฑ์ ๊ฒ์ฆํ๋ฉฐ ํด๋ผ์ด์ธํธ ๋จ๊ณ์์ ์ฌ์ฉ์์ ์๋ ฅ๊ฐ ์ค๋ฅ๋ฅผ ์ต๋ํ ๊ฑธ๋ฌ๋ผ ์ ์๋๋ก ํ๋ค.
