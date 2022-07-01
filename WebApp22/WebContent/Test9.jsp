<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test9.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>

<div>
	<h1>JSTL 코어(Core) import문 실습</h1>
	<hr />
</div>

<div>
	<p>『c:import』는 URL 처리에 관여하며
	URL을 활용하여 다른 자원의 결과를 삽입할 때 사용한다.</p>
</div>
<br />

<c:set var="url" value="Gugudan.jsp"></c:set>
<!-- Gugudan.jsp 는 사용자한테 입력받아서 구구단 출력하는 형태이다. -->

<!-- import 문 안에서 파라미터 넘기는 작업해주기 -->
<c:import url="${url }" var="impt">
	<!-- Gugudan.jsp에서 input 부분에 쓴 name이랑 같게 해주기 -->
	<c:param name="dan" value="7"></c:param>
</c:import>

<!-- 결과 화면 출력 -->
<c:out value="${impt }"></c:out>
<!-- → 결과 화면 출력 과정에서 HTML 코드를 그대로 출력하는 구문 -->
<!-- 	c:out 에는 『escapeXML』 속성이 있다.
 		『escapeXML』 속성의 기본값(default)은 true로 설정되어 있다.
 		그래서 HTML 코드 그대로 출력된다. -->
 		
<br /><br />

<!-- 결과 화면 출력 -->
<c:out value="${impt }" escapeXml="false"></c:out>

</body>
</html>










