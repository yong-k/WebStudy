<%@ page contentType="text/html; charset=UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 
 	// 이 페이지 요청 일어났을 때,
 	// 쿠키 생성 (javax.servlet.http)
 	// Cookie(name, value);
 	// 쿠키 생성 (서버에 생성된 쿠키)
 	Cookie c = new Cookie("cookie_test", "studyCookie");
 	//					 --------------
 	//                     key 값
 	// 					 → 나중에 제거할 때 이 이름으로 비어있는걸로 덮어쓰기함
 	// name(key) 값 같은거 여러개 못 만든다.
 	
 	// 쿠키 설정 (서버에 생성된 쿠키에 대해 설정)
 	//c.setMaxAge(10); 	//-- 쿠키는 10초 있다가 사라진다.
 	c.setMaxAge(3600);	// 쿠키 1시간 유지
 	//-- 봤는데 사용자에 대한 이 쿠키가 남아있으면
 	//   아직 이 사용자가 이 사이트에 온 지 1시간이 안 지났구나~ 알 수 있다.
 	// 칫솔에 대한 정보 담긴 쿠키도 있으면,
 	// 아 이 사람이 1시간 동안 와서 칫솔 보고 갔구나~
 	// 특정 칫솔에 대한 거 본 것도 알고 그거에 맞는 광고도 띄어주는 게 그런거!
 	
 	
 	// 쿠키 추가 (서버에서 생성되고 설정된 쿠키를 클라이언트에 전달)
 	response.addCookie(c);
 	
 	// 뭐 위에 이렇게 추가한다고 해서
 	// 클라이언트가 보는 화면은 달라지는 건 없다.
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TestSetCookie.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>쿠키 설정 및 추가</h1>
	<hr />
</div>

<div>
	<a href="TestGetCookie.jsp"><button type="button" class="btn">쿠키 정보 확인</button></a>
	<a href="TestRemoveCookie.jsp"><button type="button" class="btn">쿠키 정보 삭제</button></a>
</div>

</body>
</html>