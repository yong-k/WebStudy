/*===================
   MVCBegin.java
====================*/

package com.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MVCBegin extends HttpServlet
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
		
		// 얘는 controller 역할 → 클라이언트 직접 만나는 거 아니다.
		
		String message = "안녕하세요, MVC 패턴입니다~!!!";
		
		// View 역할을 수행하는 JSP 페이지에 데이터를 전달해야 한다.
		request.setAttribute("message", message);
		
		
		// check~!!!
		// 제어권(제어 흐름)도 JSP 페이지(View)에 전달해야 한다.
		//RequestDispatcher dispatcher = request.getRequestDispatcher("MVCBegin.jsp");
		// MVCBegin.jsp 파일 WEB-INF 폴더로 이동 후 경로 수정!
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/MVCBegin.jsp");
		dispatcher.forward(request, response);
		//-- 『javax.servlet.RequestDispatcher』 클래스는
		//    현재 클라이언트의 요청을 다른 서블릿/JSP 페이지로 전달하거나
		//    다른 서블릿/JSP 페이지의 결과를 현재 위치에 포함시키고자 할 때 사용된다.
		
		// 현재 이 파일은 Java Resources > src > com.svt 안에 있는데
		// 경로 저렇게만 쓰면 되나??
		// → 이건 설계도일 뿐이고,
		//    Servlet 이 객체 설계하고 실행시키는 위치는 WebContent 이다 !!
		
		
		// ※ RequestDispatcher 객체는
		//    이러한 기능을 제공하기 위해
		//    forward() 메소드와 include() 메소드를 제공하고 있으며
		//    이 두 메소드는 JSP 의 <jsp:forward> 액션 태그, 
		//    <jsp:include> 액션 태그와 동일한 기능을 제공한다.
		//    위의 경우는 현재 요청을 『MVCBegin.jsp』 로
		//    보내고자 하는 경우이다.
		
		//==> 웹 기반 모델2(MVC) 구조는
		//    바로 이 『RequestDispatcher』의 『forward()』
		//    메소드를 통해 구현된다.
		
	}
	
}
