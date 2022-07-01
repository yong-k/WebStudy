<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 이전 페이지(SendAndReceive06.jsp → 자기 자신 페이지)로부터 데이터 수신
	request.setCharacterEncoding("UTF-8");
	
	String temp = "";
	
	temp = request.getParameter("userInput");
	
	if (temp == null)
		temp = "없음";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SendAndReceive06.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>데이터 송수신 실습 06</h1>
	<hr>
</div>

<div>
<!-- Test999.jsp 없으니 404 에러뜸 -->
<!-- 
	<form action="Test999.jsp" method="post">
		입력 <input type="text" id="userInput" name="userInput" class="txt">
		<br>
		
		<button type="submit" class="btn control">테스트</button>
		<button type="reset" class="btn control">취소</button>
	</form>
-->

<!-- action 비워놨더니 아무 일도 안 일어나는 것 처럼 보인다 
     → 주소창 변화 없음 -->
<!-- 
	<form action="" method="post">
		입력 <input type="text" id="userInput" name="userInput" class="txt">
		<br>
		
		<button type="submit" class="btn control">테스트</button>
		<button type="reset" class="btn control">취소</button>
	</form>
-->

<!-- method 방식 get으로 바꾸니까, submit 버튼 누르면 주소 다음과 같이 바뀐다.
	 http://localhost:8090/WebApp07/SendAndReceive06.jsp	
						↓
	 http://localhost:8090/WebApp07/SendAndReceive06.jsp?userInput=	
	 → 나 스스로를 부른 상황이다.	 -->	
<!-- 	 	
	<form action="" method="get">
		입력 <input type="text" id="userInput" name="userInput" class="txt">
		<br>
		
		<button type="submit" class="btn control">테스트</button>
		<button type="reset" class="btn control">취소</button>
	</form>
 -->
 
<!-- action 속성 아예 빼보자.
	 그래도 위에와 똑같은 결과. 
	 → action 명시 안해도/생략해도, submit 대상은 자기 자신페이지가 된다.	 -->
<!-- 	 
	<form method="get">
		입력 <input type="text" id="userInput" name="userInput" class="txt">
		<br>
		
		<button type="submit" class="btn control">테스트</button>
		<button type="reset" class="btn control">취소</button>
	</form>
 -->
 
<!-- 그냥 form 만 존재하게 해보자 
	 http://localhost:8090/WebApp07/SendAndReceive06.jsp?userInput=
	 method 생략하면 → get 방식으로 된다! -->	
<!-- 	 
	<form>
		입력 <input type="text" id="userInput" name="userInput" class="txt">
		<br>
		
		<button type="submit" class="btn control">테스트</button>
		<button type="reset" class="btn control">취소</button>
	</form>
 -->	


	<form method="post">
		입력 <input type="text" id="userInput" name="userInput" class="txt">
		<br>
		
		<button type="submit" class="btn control">테스트</button>
		<button type="reset" class="btn control">취소</button>
	</form>
	
	<!-- check~!!! -->
	<!-- ※ form 의 action 속성을 『action=""』과 같이 구성하거나
	        action 속성을 생략하여 『<form method="post">』와 같이 구성하게 되면
	        페이지 요청 및 데이터 전송에 대한 수신처 페이지는 자기 자신이 된다. -->
</div>

<div>
	<h2>수신된 데이터 확인</h2>
	<h3>→ <%=temp %></h3>
</div>


</body>
</html>