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
<title>Test4.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>JSTL 코어(Core) if 문 실습</h1>
	<hr>
</div>	

<div>
	<!-- form 태그의 action 속성 생략 → 전송하는 데이터의 수신처는 자기 자신 -->
	<form method="post">
		정수 <input type="text" name="su" class="txt"><br><br>
		<button type="submit" class="btn">결과 확인</button>
	</form>
</div>
<br><br>

<div>
	<%-- <h2>${param.su }</h2> --%>
	
	<!--
		  우리가   
		  prefix로
		  사용한다고 한
		  『c』쓴거임   ┌→ 조건식 지정
	       ---   ---------													-->
	<%-- 『<c:if test=""></c:if>』 : JSTL Core if 문 --%>
	<!-- 		
				Test3.jsp에서 했던 것처럼 아래와 같이 작성하게 되면, 
				페이지 최초요청일 경우만 해당(EL로 처리된건 submit 하면 null로 처리되는 게 아니기 때문에)
				---------------- -->
	<%-- <c:if test="${param.su!=null }"> --%>
	
	<!-- 우리가 표현하고 싶은대로 submit 후에도 비어있는 상태를 확인하고 싶은거라면
	     아래와 같이 구문 작성해야 한다. →  『empty』 사용!! -->
	<!-- 『test=""』  :  조건식 지정. 파라미터로 수신한 su에 값이 있으면...-->  
	<!-- 『param.su』 :  EL을 이용한 폼 전송 데이터 수신하는 부분 -->   
	<c:if test="${!empty param.su }">
	
		<!-- <h2>있다</h2> -->
		
		<!-- 조건문 중첩도 가능하다~! -->
		<!-- 파라미터로 수신한 su가 짝수라면... -->
		<c:if test="${param.su % 2 == 0 }">
			<h2>${param.su } : 짝수</h2>
		</c:if>
	</c:if>
	
	<!-- core의 if문은 생각보다 사용빈도 낮다. core의 if문에는 else 가 없기 때문.. -->
	
	<!-- JSTL Core if 에는... if 는 있지만 else 는 없다. -->
	<c:if test="${param.su % 2 != 0 }">
		<h2>${param.su } : 홀수</h2>
	</c:if>
	
</div>


</body>
</html>




















