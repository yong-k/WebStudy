<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// ①
	/* String nickName = request.getParameter("nickName"); */
	// ②
	/* String result = nickName + "님 안녕하세요.\n반갑습니다."; */
%>
<!-- ① -->
<%-- <%=nickName %>님 안녕하세요. <br>반갑습니다. --%>

<!-- ② -->
<%-- <%=result %> --%>

<!-- ③ -->
${param.nickName}님 안녕하세요.
<br>
반갑습니다.