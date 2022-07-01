/*============================================
   MVCTest01.java
   - Controller 역할을 수행할 서블릿 클래스
=============================================*/

package com.svt;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MVCTest01 extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGetPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGetPost(request, response);
	}
	
	protected void doGetPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// 서블릿 관련 코딩	
		
		// 클라이언트 요청들어오면
		// 1 부터 100 까지의 수를 객체(컬렉션)에 저장하는 과정을 거칠 것이다.
		List<String> lists = new ArrayList<String>();
		for (int i = 1; i <= 100; i++)
			// 문자열을 담겠다고 했기 때문에 String.valueOf() 사용
			lists.add(String.valueOf(i));
		
		request.setAttribute("lists", lists);
		
		// MVCTest01.jsp 파일 web-inf>view 폴더로 이동 후 주소 변경
		//RequestDispatcher dispatcher = request.getRequestDispatcher("MVCTest01.jsp");
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/MVCTest01.jsp");
		dispatcher.forward(request, response);
	}
	
	// 뷰한테 컨트롤러가 원하는거 객체 형태로 얼마든지 넘겨줄 수 있다.
	// DB 연동도 가능
	// view 가 얻어낸 값을 또 다른 컨트롤러가 받아서 DB에 넣어줄 수도 있다.
	// 다른 객체도 구성할 수도 있고...등등
	// → 그래서 MVC 적용해서 코딩하는 것이다.
	
}


















