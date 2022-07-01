<%@ page contentType="text/html; charset=UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%><% 
	// AjaxTest03_ok.jsp → XML 구성
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	response.setContentType("text/xml");
	
%><?xml version="1.0" encoding="UTF-8"?>

<!-- 
	xml에서 최상위 엘리먼트/root 엘리먼트는 딱 하나여야만 한다!!!
	그래야 well-formed
	모든 하위 엘리먼트는 최상위 엘리먼트 아래에 있어야 한다.
	 
	<root>
	</root>
	<root>
	</root>
	
	==> 이러면 안 됨!!!
-->

<!-- 쌤 풀이 -->
<root>
	<status>true</status>
	<records id="1">
		<title>${param.title }</title>
		<content>${param.content }</content>
	</records>
	<records id="2">
		<title>${param.title }</title>
		<content>${param.content }</content>
	</records>
</root>

<!-- 내가 한 거 -->
<%--  
<lists>
	<% 
	for (int i=1; i<=5; i++)
	{
	%>
	<comment num="<%=i %>"> 
		<title><%=title + i %></title>
		<content><%=content + i %></content>
	</comment>
	<%
	}
	%>
</lists>
--%>

<!-- 아래걸로 하면 에러메세지 나옴 
	 근데 쌤이 한거보니까 잘 하면 될거같은데,,복습할 때 다시 해보기!-->
<%--  
<lists>
	<total_datacount>5</total_datacount>
	<c:forEach var="i" begin="1" end="5" step="1">
		<comment num=${i }>
			<title>${param.title + i }</title>
			<content>${content + i }</content>
		</comment>
	</c:forEach>
</lists>
 --%>