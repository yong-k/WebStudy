/*===============
	GuestDTO
================*/

package com.test;

public class GuestDTO
{
	private String userName, subject, content;
	
	// 이렇게 변수명 맞춰야 할 때, 추가로 주의해야 할 점이 있다.
	
	//    check~!!!!
	// ※ 여기에서 사용하는 변수명(속성명)의 앞 두 글자는 소문자로 작성할 것~!!!
	//    그러니까 Guest.jsp에서 form 에서 속성명도 앞 두 글자는 소문자로 하는게 좋다.
	// ex)
	// 		numScore → getNumScore() / setNumScore()
	//      nScore   → getNScore()   / setNScore()    → 이렇게 되어버림,,,
	//                  getnScore()   / setnScore()    → 이렇게 만들수는 없다.
	//	  │
	//	  └→ get/set 이랑 n 구분안되니까
	//		   우리가 호출하지 않을 때 
	// 		   ServletContainer 가 호출할 때 문제 생길 수 있다.
	
	// 이와 같이, setter가 속성명을 불러오는 과정에서
	// 인식이 어긋나는 경우가 발생할 수 있기 때문...!!!!
	
	// 자동으로 getter, setter 만들때도, bean 규칙으로도 
	// 속성명의 첫 번째 글자 대문자로 고치면서 get/set  붙인다
	
	// ※ 여기에서 사용하는 변수명(속성명)은
	//    HTML 의 form 태그에서 name 속성으로 지정하여 사용할 것
	//    그래야 속성 데이터 수신 및 속성 매핑을
	//    액션 태그를 활용하여 자동으로 처리해 줄 수 있기 때문...
	
	// 실무에서 작업 순서가
	// bean(DTO) 이 만들어진 상태에서 view 작업을 하게 된다.
	
	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String userName)
	{
		this.userName = userName;
	}

	public String getSubject()
	{
		return subject;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}
	
}
