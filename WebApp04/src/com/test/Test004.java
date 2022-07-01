/*===================
	Test004.java
	- Servlet 실습
====================*/

// 현재... 자바의 기본 클래스 Test004
// 이를 Servlet 으로 구성하는 방법

// GenericServlet 을 상속받는 클래스로 설계 → Servlet

package com.test;

import java.io.IOException;
import java.io.PrintWriter;

//import javax.servlet.Servlet;
import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

// Test004가 『Servlet 을 implements 하겠다』고 하면 
// Test004의 정체성 → Servlet
// 그런데 그냥 Servlet을 implements 하면 해야 할 일이 많아지기 때문에
// Servlet 의 하위 객체인 GenericServlet 을 extends 한다.
//Test004가 『GenericServlet 을 extends 하겠다』고 하면
//            --------------
//				└ 추상클래스
// GenericServlet 이 Servlet의 하위 객체이므로 Test004 의 정체성 → Servlet

//public class Test004 implements Servlet
//public abstract class Test004 extends GenericServlet
public class Test004 extends GenericServlet
{
	// 경고 띄워져 있는 건 → 객체직렬화 때문이다.
	// 이건 그냥 노란색에 마우스 커서 올리고
	// add default serial version id 클릭하면 된다.
	// ↓ 그럼 이거 생기고, 경고표시 없어진다.
	private static final long serialVersionUID = 1L;

	/*
	마우스 우클릭 > source > override/implement method .. 
	체크 필수적으로 되어 있는 service() 추상메소드 아직 정의 안됐다. → A라고 써있음
	↓  */
	
	// GenericServlet 의 추상메소드 재정의~!!
	@Override
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException
	{
		// 클라이언트가 어떤 서비스 요청하게 되면 service() 메소드 호출하게 된다.
		// servlet container 에서 호출해준다.
		// 얘가 호출됐을 때, 무슨 일 할 건지 정의해놓으면 된다.
		
		// 내가 응답하는데, 응답하는 컨텐트 타입은 "~" 로 구성하겠다.
		// 요청에 대한 응답 방법
		response.setContentType("text/html; charset=UTF-8");
		
		try
		{
			// 출력 스트림 구성
			PrintWriter out = response.getWriter();
			
			out.print("<html>");
			out.print("<head>");
			out.print("<title>");
			out.print("Test004.java");
			out.print("</title>");
			out.print("</head>");
			
			out.print("<body>");
			out.print("<div>");
			out.print("<h1>");
			out.print("서블릿 관련 실습");
			out.print("<hr>");
			out.print("</h1>");
			out.print("</div>");
			
			out.print("<div>");
			out.print("<h2>");
			out.print("GenericServlet 클래스를 이용한 서블릿 테스트");
			out.print("</h2>");
			out.print("</div>");
			
			out.print("</body>");
			
			out.print("</html>");
			//-- 막노동,,,너무 힘듦
			//   그래서 나온게 JSP...!
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}
}
// 다 작성하고 web.xml 로 간다.
// </web-app> 전에 코드 추가
// 하고 크롬에 http://localhost:8090/WebApp04/test004 치기만하면
// 이 페이지 내용 나온다.
