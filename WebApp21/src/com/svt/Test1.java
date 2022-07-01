/*==========================
   Test1.java
==========================*/

package com.svt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test1 extends HttpServlet
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
   
   /*
    이렇게만 한다고 되는 거 아니다.
    web.xml(배치기술서)에 가서 servlet과 servlet mapping 작업 해줘야 한다!
    어떤 요청이 오면 어떻게 해라~! 라고 연결해주는 작업 
    */
   protected void doGetPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
	   // ①
	   /*
	   String name = "홍길동";
	   String age = "19";
	   
	   response.setContentType("text/html;charset=UTF-8");
	   PrintWriter pw = response.getWriter();
	   
	   pw.println("<html>");
	   pw.println("<head>");
	   pw.println("<title>" + "Test1.java" + "</title>");
	   pw.println("</head>");
	   pw.println("<body>");
	   pw.println("<h1>name : " + name + "</h1>");
	   pw.println("<h1>age : " + age + "</h1>");
	   pw.println("</body>");
	   pw.println("</html>");
	   */
	   
	   
	   // ②
	   
	   // 『ServletConfig』
	   //-- 컨테이너가 서블릿을 초기화할 때(즉 init() 메소드를 호출할 때)
	   //   서블릿 당 하나씩 ServletConfig 을 생성하게 된다.
	   ServletConfig config = getServletConfig();
	   //					  ------------------
	   //                      서블릿 정보 얻어옴
	   
	   // 『web.xml』에 『<init-param>』한 거 그 값을 얻어오는 것이다.
	   String name = config.getInitParameter("name");
	   String age = config.getInitParameter("age");
	   //			-----------------------------
	   //              config의 초기화된(init) parameter를 얻어오겠다.
	   
	   /*
	   response.setContentType("text/html;charset=UTF-8");
	   PrintWriter pw = response.getWriter();
	   
	   pw.println("<html>");
	   pw.println("<head>");
	   pw.println("<title>" + "Test1.java" + "</title>");
	   pw.println("</head>");
	   pw.println("<body>");
	   pw.println("<h1>name : " + name + "</h1>");
	   pw.println("<h1>age : " + age + "</h1>");
	   pw.println("</body>");
	   pw.println("</html>");
	   */
	   
	   
	   // ③
	   // 『ServletContext』
	   //-- ServletConfig 는 서블릿에 대한 환경을 설정하는 과정에서
	   //   필요한 값들을 전달하는 형태로 주로 사용된다면
	   //   ServletContext 는 서블릿에서 사용되는 컨텍스트/컨텐츠를
	   //   구성하는 형태로 활용된다.
	   // 구성된 서블릿에 initParameter 로 집어넣는게 아니라,
	   // contextParameter 형태로 서블릿에 추가하는 형태로 사용
	   ServletContext context = getServletContext();
	   
	   // 『web.xml』에 『<context-param>』 사용 가능
	   String type = context.getInitParameter("type");
	   
	   
	   response.setContentType("text/html;charset=UTF-8");
	   PrintWriter pw = response.getWriter();
	   
	   pw.println("<html>");
	   pw.println("<head>");
	   pw.println("<title>" + "Test1.java" + "</title>");
	   pw.println("</head>");
	   pw.println("<body>");
	   pw.println("<h1>name : " + name + "</h1>");
	   pw.println("<h1>age : " + age + "</h1>");
	   
	   pw.println("<h1>type : " + type + "</h1>");
	   
	   pw.println("</body>");
	   pw.println("</html>");
	   
	   
	   // init-param은 A 서블릿에 있으면 그냥 A 서블릿 것이다.
	   // context-param 은 얘 뿐만 아니라 다른 서블릿에서도 사용할 수 있다.
	   // └→ A 서블릿에 종속된 것이 아니라 독립적으로 만든 것!
	   //      B 서블릿 만들면 걔도 쓸 수 있다.
	   
	   
	   
	   /*
	     자바 파일 컨트롤  vs  XML 파일 컨트롤
	     
	     자바 파일 컨트롤 해서 → 값 넘김 (값을 전달) 
	     	→ 컴파일하고 실행하는 과정에서
	     	   우리가 값 빼거나 추가하거나 이런거 불가능하다.
	     	   │
	     	   둘이 의미 완전 다름
	     	   │
	     XML  파일 컨트롤 해서 → 값 넘김 (값을 전달)
	     	→ xml파일은 text 파일 같은 애들이다. 
	     	   우리가 편집할 수 없는 형태로 바뀌는 거 아니다.
	     	   배포된 이후에도 프로그램 안에 들어있는 값 바꿀 수 있는 장점이 있다.
	     	   추후에 프로그램 완성되고 배포된 이후에도
	     	   설정값을 xml 통해서 변경하는 거 가능하다! 
	     	   └→ 자바에서는 불가능하다.
	   */
   }
   
   
   
   
   
}