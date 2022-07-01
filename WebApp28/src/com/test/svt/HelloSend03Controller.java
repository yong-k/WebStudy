/*===============================
 	HelloSend03Controller.java
================================*/

package com.test.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloSend03Controller extends HttpServlet
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
		
		// 업무 로직 필요 없이 view만 출동시키면 된다.
		// → view 객체에 대한 연결만 수행하면 된다.
		// '사용자가 이런 요청했는데, 너가 나가서 사용자 만나봐야 할 것 같아' 
		// → 이것만 처리해주면 된다!
		
		// View 객체에 대한 연결
		RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/view/HelloSend03.html");
		rd.forward(request, response);
		//-- 사용자의 요청이 controller를 향하게 만들어줘야 한다.
		//   → web.xml 로 가서 작업하자
		
		
		// → 이 controller 도 web.xml 에 servlet 으로 등록해주러 가자
	}
}
