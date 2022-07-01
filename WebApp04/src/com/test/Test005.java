/*===================
	Test005.java
	- Servlet 실습
====================*/

// 현재... 자바의 기본 클래스 Test005
// 이를 Servlet 으로 구성하는 방법

// Test004 에서는
// GenericServlet 을 상속받는 클래스로 설계해서 그걸 Servlet 으로 만들었다.

// Test005 에서는
// HttpServlet    을 상속받는 클래스로 설계해서 그걸 Servlet 으로 만들 것이다.

package com.test;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// HttpServlet : 추상클래스로 구상되었지만, 안에 추상메소드는 없다.
// HttpServlet은 get 방식과 post 방식으로 응답하는 방식이 나뉜다.
// get  방식의 요청일 때는 doGet()  호출
// post 방식의 요청일 때는 doPost() 호출하게 된다.
// → doGet(), doPost() 방식 나눠서 처리하는 게 일반적이다.
//    -----------------
//     사실상 service 에 있는 하위메소드들
public class Test005 extends HttpServlet		
{
	private static final long serialVersionUID = 1L;

	// 사용자의 http 프로토콜 요청이 GET 방식일 경우 호출되는 메소드
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// GET 방식의 요청에 대해 처리하는 코드
		doGetPost(request, response);
	}

	// 사용자의 http 프로토콜 요청이 POST 방식일 경우 호출되는 메소드
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// POST 방식의 요청에 대해 처리하는 코드
		doGetPost(request, response);
	}
	
	// 만약 doGetPost() 를 만들어서
	// Get 방식일 때, Post 방식일 때 각각 doGetPost(); 호출해준다면
	// Get 방식이든, Post 방식이든 어떤 방식의 요청에도 모두 처리할 수 있는 사용자 정의 메소드
	protected void doGetPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// GET 방식이든 POST 방식이든
		// 어떤 방식의 요청에도 모두 처리할 수 있는 사용자 정의 메소드
		
		// request  → 요청 객체
		// 사용자가 넘겨준 아이디와 패스워드는, 
		// name="userId", name="userPwd"으로 request 안에 저장되어 전송된다.
		// → 클라이언트로부터 서버로... 전송된 데이터... 객체
		// request 객체에 대한 세팅 → 인코딩 방식 처리 
		// 		→ (영문이나 숫자는 상관없지만)한글 깨짐 방지
		// ※ 꺼내기 전에 먼저 인코딩 방식 처리먼저!!
		request.setCharacterEncoding("UTF-8");
	
		String id = request.getParameter("userId");
		String pwd = request.getParameter("userPwd");
		
		// response → 응답 객체
		// → 서버로부터 클라이언트로...
		// 어떤 방식으로 응답해줄 건지
		response.setContentType("text/html; charset=UTF-8");
		
		String str = "아이디 : " + id + ", 패스워드 : " + pwd;
		
		// 응답을 출력 스트림으로 구성하기 위한 준비
		PrintWriter out = response.getWriter();
		
		// 출력 스트림을 활용해서 페이지 랜더링
		out.print("<!DOCTYPE html>");
		out.print("<html>");
		out.print("<head>");
		out.print("<meta charset=\"UTF-8\">");
		out.print("<title>Test005.java</title>");
		out.print("</head>");
		out.print("<body>");
		out.print("");
		out.print("<div>");
		out.print("	<h1>서블릿 관련 실습</h1>");
		out.print("	<hr>");
		out.print("</div>");
		out.print("");
		out.print("<div>");
		out.print("	<h2>HttpServlet 클래스를 활용한 서블릿 테스트</h2>");
		out.print("	");
		out.print("	<p>" + str + "</p>");
		out.print("</div>");
		out.print("");
		out.print("</body>");
		out.print("</html>");

		
		
		
	}
	
	
}
