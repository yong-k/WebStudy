<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 접속자 수 처리
	int n = 0;

	String count = (String)application.getAttribute("count");
	//-- 그냥 여기까지만 하고 body에 count 찍으면 null 로 나온다.
	//   이런 속성 값 지금 application 에 존재하지 않는다.
	
	if (count != null)
		n = Integer.parseInt(count);
	
	n++;
	application.setAttribute("count", Integer.toString(n));
	// 동시 접속이 아니라 총 몇 명이 봤는지(새로고침 기준) count 한다.
	// 한 application 에 여러 jsp 있다고 해도
	// 서로 주거니받거니 하며 count 가능하다.
	
	// 실제 접속자 주소 처리(콘솔 창을 통해 확인)
	String realPath = application.getRealPath("/");
	application.log("접속자 : " + request.getRemoteAddr());
	//-------------
	// application 에 log 남기는거
	// 지금은 사설 ip라서 그렇지만 강의장에서 하면,
	// 콘솔에서 보면
	// 정보: 접속자 : 0:0:0:0:0:0:0:1    
	// └→ 이렇게가 아니라
	// 내가 들어가면 내 IP 주소 찍힘!
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TestApplication.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>Application 을 활용한 접속자 수 체크</h1>
	<hr />
</div>

<div>
	<%-- <h2>총 접속자 : <%=count %></h2> --%>
	<h2>총 접속자 : <%=n %></h2>
	<h2>웹 서버 실제 경로 : <%=realPath %></h2>
</div>

</body>
</html>