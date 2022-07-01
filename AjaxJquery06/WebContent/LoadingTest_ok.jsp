<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	// LoadingTest_ok.jsp
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	
	// 시간 지연 과정에서 문제생기면 잡아낼 수 있도록
	// try~catch 구성 
	try
	{
		// 의도적으로 처리 시간 지연
		Thread.sleep(5000);
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
		
%>
<!-- 버튼 클릭하자마자 결과보여지듯 시간 별로 걸리지 않았다. -->
<!-- ==> 그래서 의도적으로 처리 시간 지연시킬 거임 -->
이름 : <%=name %>
<br />
내용 : <%=content %>
