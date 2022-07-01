<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hap.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>JSP를 이용한 데이터 송수신 실습 01</h1>
	<hr>
	<p>Hap.jsp ● → HapOk.jsp ○</p>
</div>

<div>
	<!-- 데이터 계산해서 HapOk.jsp 로 보낼거다 
										 
										   상대경로
										 ------------      		-->
	<!-- ※ <form>의 action 속성 지정 시 『HapOk.jsp』로 지정해도 되고
	        『/WebApp05/HapOk.jsp』 형태로 지정해도 된다.
	        단, 『/HapOk.jsp』로 지정하면 안된다. -->
	<form action="HapOk.jsp" method="post">
		정수1 <input type="text" name="su1" class="txt"><br>
		정수2 <input type="text" name="su2" class="txt"><br>
		<br>
		
		<input type="submit" value="결과 확인" class="btn control">
	</form>
	<!-- 처리 순서
	     ① form 내부에 구성한 데이터들을 『HapOk.jsp』로 전송하겠다. → su1, su2
	     자바스크립트에서는 보통 값 수신할 때 Id 사용했었다. (getElementById) 
	     !! 파라미터 값 수신할 때는 기본적으로 name 이다. !!
	     ② HapOk.jsp 페이지를 요청하겠다. → 내가 보내는 데이터들을 받고 나를 그 페이지로 안내해다오~!!!
	-->
	    
</div>

</body>
</html>