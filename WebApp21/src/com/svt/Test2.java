/*================
   Test2.java
=================*/

package com.svt;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test2 extends HttpServlet
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
	   // (스크립 릿 영역에서 썼던 자바코드들을 여기에 쓰면 된다.) 
	   // → document 상에 뭐 보이지 않는다. (스크립 릿 영역이니까!)
	   
	   // 이전 페이지로(Test2.jsp)부터 데이터(name, age) 수신
	   
	   // 한글 깨짐 방지 인코딩 처리
	   request.setCharacterEncoding("UTF-8");
	   
	   // 데이터 수신 
	   String name = request.getParameter("name");
	   String age = request.getParameter("age");
	   
	   // 특정 업무에 대한 처리 
	   String str = "이름은 " + name + "이며, 나이는 " + age + "세 입니다.";
	   
	   // 처리한 업무 넘기기 (/Test2_result.jsp 한테)
	   request.setAttribute("result", str);
	   //-- 포워딩하는 페이지에 값을 넘기기 위한 준비(설정)
	   //   즉, str 값을 result 라는 이름으로 Test2_result.jsp 페이지로 넘길 준비
	   
	   
	   // 준비 끝났으니 실제로
	   // 포워딩~!!!
	   RequestDispatcher rd = request.getRequestDispatcher("/Test2_result.jsp");
	   rd.forward(request, response);	  
	   
   }  
}