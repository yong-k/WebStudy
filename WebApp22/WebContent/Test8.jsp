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
<title>Test8.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>
<!-- 
	 정수 입력하고 [결과확인] 버튼 누르면
	 3의 배수인지, 4의 배수인지, 3과4의 배수인지, 둘다 아닌지 
	 결과출력하려고 한다. 
-->
<!-- 
	Core의 if문에는 else문 없다.
	else가 필요한 if문을 써야 한다면, Core의 choose문 많이 쓴다.
-->	
<div>
	<h1>JSTL 코어(Core) choose문 실습</h1>
	<h2>배수 확인하기</h2>
	<hr />
</div>

<div>
	<form action="" method="post">
		정수 <input type="text" name="su" class="txt" /><br /><br />
		
		<button type="submit" class="btn">결과 확인</button>
	</form>
</div>
<br /><br />

<div>
	<c:if test="${!empty param.su }">
	
		<%-- ${param.su } --%>
		
		<%-- <c:choose></c:choose> --%>
		<%-- JSTL Core 에서 if ~ else 를 대신할 수 있는 구문 --%>
		
		
		<c:choose>
			
			<%-- 여기서도 if~else문과 같이 순서 중요!! --%>
			<%-- 조건 순서 명시하는 순서 유의하자! --%>
			
			<c:when test="${param.su % 3 == 0 && param.su % 4 == 0 }">
				<p>${param.su }은(는) 3과 4의 배수~!!!</p>
			</c:when>
			
			<c:when test="${param.su % 3 == 0 }">
				<p>${param.su }은(는) 3의 배수~!!!</p>
			</c:when>
			
			<c:when test="${param.su % 4 == 0 }">
				<p>${param.su }은(는) 4의 배수~!!!</p>
			</c:when>
			
			<%-- check~!!! --%>
			<%-- else를 수행하는 아이 → <c:otherwise> --%>
			<c:otherwise>
				<p>${param.su }은(는) 3 또는 4의 배수가 아님~!!!</p>
			</c:otherwise>
			
		</c:choose>
		
	</c:if>
</div>


</body>
</html>







