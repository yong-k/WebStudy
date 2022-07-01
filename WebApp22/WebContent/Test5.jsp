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
<title>Test5.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>JSTL 코어(Core) forEach문 실습</h1>
	<hr />
</div>

<div>
	<table class="table">
		
		<!-- JSTL 코어(Core) 반복문 -->
		<!-- 향상된 for문과 상당히 유사한 형태를 갖고 있다. -->
		<%-- <c:forEach var="루프변수" begin="시작값" end="끝값" step="증가값"></c:forEach> --%>
		
		<!-- a 루프변수에 1부터 9까지 1씩 증가시키면서 넣을거야 -->
		<c:forEach var="a" begin="1" end="9" step="1">	<!-- 1 2 3 4 5 6 7 8 9 -->
		<!-- tr을 9개 만들거야 -->
		<tr>	
			<!-- 중첩가능하다 -->
			<!-- 각각의 tr 안에 td 9개 만들거야 -->
			<c:forEach var="b" begin="1" end="9" step="1">
			<td style="width: 20px;">
				${a*b }
			</td>	
			</c:forEach>
		</tr>
		</c:forEach>
		
		<!-- 
			일반적 숫자 처리하는 것보다는 객체 순차적으로 처리하는데 많이 사용된다.
			자바에서 처럼 자료구조를 컨트롤하는 형태로 훨씬 더 많이 쓰인다.
			for (변수명 : 자료구조) 처럼!! 
		-->
		
	</table>
</div>

</body>
</html>