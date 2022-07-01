/*===========================================
 	Test02.java
 	- AjaxTest02.jsp에 대응하는 controller
============================================*/
// com.svt 에서 ServletSample의 extends부터 끝까지 복붙

package com.test.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test02 extends HttpServlet
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
		
		// Test02.jsp가 ajax 처리해서 넘길때, 
		// 사용자가 입력한 num1, num2 를 파라미터로 구성해서 test02.do로 넘겨줌 
		// 요청 받으면 얘가 그걸 넘겨받는다.
		
		// 데이터 수신(AjaxTest02.jsp 페이지로부터 넘어온 데이터)
		int n1 = Integer.parseInt(request.getParameter("n1"));
		int n2 = Integer.parseInt(request.getParameter("n2"));
		
		// 비즈니스 로직 처리(연산 처리) → 여기서는 덧셈 처리
		int result = n1 + n2;
		//int result2 = n1 - n2;
		
		// 반환할 결과값 준비
		request.setAttribute("result", result);
		//request.setAttribute("result2", result2);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Test02Ok.jsp");
		dispatcher.forward(request, response);
	}
}