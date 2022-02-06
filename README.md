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

 
