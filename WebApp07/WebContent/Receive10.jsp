<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 이전 페이지(Send10_re.jsp 또는 Send10_for.jsp)로부터 데이터(userName, message) 수신
	
	request.setCharacterEncoding("UTF-8");
	
	String userName = request.getParameter("userName");
	
	// setAttribute() 한 건, getAttribute() 로 얻어낸다.
	Object message = (String)request.getAttribute("message");
	//-- 형식만 Object이고, 실제 담겨있는 것은 String이니까 다운캐스팅 진행
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Receive10.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h2>데이터 송수신 실습 10</h2>
</div>

<div>
	<h2>최종 수신 페이지(Receive10.jsp)</h2>
</div>

<div>
	<p>이름 : <%=userName %></p>
	<p>내용 : <%=message %></p>
</div>

</body>
</html>

<!-- 
	<< 관찰 >>

	리다이렉트 누르면
	Send10_re.jsp 안보이고 Receive10.jsp로 바로 넘어온다.
	그리고 이름, 내용 둘 다 null 로 넘어온다. 
	처음 요청할 때 넘겼던 거는 Send10_re.jsp인데 Receive10.jsp로 넘어오고,
	처음 요청할 때 넘겼던 데이터 하나도 확인되지 않는다.
	클라이언트에게 '너 Receive10.jsp로 가야할 것 같아~' 하고 쪽지주고
	Receive10.jsp 로 보내주는데, 거기에 가면 내가 입력했던 데이터 남아있지 않다.
	
	
	포워드 누르면
	이름, 내용 다 제대로 넘어온다.
	실제 페이지는 Receive10.jsp가 결과 보여주는 건데,
	실제 열심히 일해서 결과 보여주고 있는 건 Receive10.jsp 인데
	근데 결과 보여주고 있는 페이지의 주소 → Send10_for.jsp 로 보인다.
	→ 클라이언트에게는 Send10_for.jsp가 처리해서 주는 걸로 보인다!! 
-->