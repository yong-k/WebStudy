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
<title>Test6_result.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
</head>
<body>

<div>
	<h1>JSTL 코어(Core) forEach문을 이용한 자료구조 활용 실습</h1>
	<hr />
</div>

<div>
	<table class="table">
		<tr>
			<th>이름</th>
			<th>나이</th>
		</tr>
		
		<!-- 컬렉션 객체 접근용(출력용) 반복문 구성 -->
		<!-- core의 forEach 구문 → 아래 같은 방법이 훨씬 많이 쓰이니 기억해두자!! -->
		<!-- 컬렉션 컨트롤 할 때는, 일단 먼저!! 항상!! 『items』 속성을 먼저 쓰자 
			 items 속성에 컬렉션 이름 넣어주고, var에 변수 이름 넣어주면 된다!!
			 자바로 보면 → for (타입(var) 변수명 : items 컬렉션명)-->
		<%-- <c:forEach var="변수" items="컬렉션"></c:forEach> --%>
		<c:forEach var="dto" items="${lists }">
		<tr>
			<!-- 원래는 dto.getName() 해야되지만,
			EL에서는 속성명만 적으면 자기가 알아서 호출해준다! -->
			<td style="text-align: center;">${dto.name }</td>
			<td style="text-align: center;">${dto.age }</td>
		</tr>
		</c:forEach>
		
	</table>
</div>

</body>
</html>