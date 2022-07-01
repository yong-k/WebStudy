/*============================
 	HelloReceive03Model.java
=============================*/

package com.test.logic;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloReceive03Model
{
	// 메소드는 우리 임의로 만들면 된다.
	// 매개변수는 (HttpServletRequest request, HttpServletResponse response)
	public String process(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		String result = "";
		
		// 한글 포함되어 있을 수 있으니 인코딩 처리
		request.setCharacterEncoding("UTF-8");
		//-- 일반 클래스의 일반 메소드인데 인코딩 처리 들어가게 되면
		//   시스템에서 지원할 수 없는 인코딩일 수도 있어서 
		//   ex) request.setCharacterEncoding("aaa");
		//   UnsupportedEncodingException 발생한다! 
		//   → 시스템에서 지원할 수 없는 인코딩일 경우 예외발생
		
		
		// 데이터 수신
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		
		// 추가적인 업무 처리 삽입
		lastName = "[ "+ lastName + " ]"; 

		// 데이터 전달
		request.setAttribute("firstName", firstName);
		request.setAttribute("lastName", lastName);
		
		// 상황에 따른 뷰 선택(지정) 가능~!!!
		result = "WEB-INF/view/HelloReceive03.jsp";

		return result;
	}
}
