<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsptest005.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>JSP 관찰하기</h1>
	<hr>
</div>

<div>
	<h2>HttpServlet 관련 실습</h2>
	
	<!-- ※ form 태그의 action 속성은 데이터 전송 및 페이지 요청을 해야하는
	        대상 페이지를 등록하는 기능을 수행한다.
	        (생략 시 데이터 전송 및 페이지 요청을 하게 되는 대상은 자기 자신이 된다.) 
	          → 내가 공 던지고 내가 공 받는 상황..! 
	     ※ form 에는 method 속성으로 어떤 방식(get/post)인지 지정해줄 수 있다.
	        (생략 시 get 방식) -->
	<!--  주소창 차이
	post로 되어 있으면  → http://localhost:8090/WebApp04/login
	get으로 되어 있으면 → http://localhost:8090/WebApp04/login?userId=superman&userPwd=1234  -->	     
	<form action="/WebApp04/login" method="get">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="userId" size="10" maxlength="10" class="txt">
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="userPwd" size="10" class="pwd">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<!-- submit 액션 → form 데이터 전송 및 페이지 요청 
					     어디에 전송하고, 어떤 페이지를 요청해??
					     → 그건 <form> 에 기재되는 action 설정에서 결정된다. -->
					<input type="submit" value="로그인" class="btn control" style="width: 92px;">
					<input type="reset" value="다시입력" class="btn control" style="width: 92px;">
				</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>


<!--
	jsptest005.jsp 에서 form 작성하고 submit 하면,,,
	form 에 써놓은 action에 /webapp04/login 이거 써있으니까
	web.xml 로 가서 
	url에 /login 있으면 com.test.Test005 에 가서 
	아이디, 비번으로 응답해주는거인듯 
-->