<%@ page contentType="text/html; charset=UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	response.setContentType("text/xml");
%><?xml version="1.0" encoding="UTF-8"?>
<!-- ↑ 앞에 이음새 없도록 처리!! ★★★ -->
<list>
	<c:forEach var="item" items="${lists }">
	<item>${item.word }</item>
	</c:forEach>
</list>
