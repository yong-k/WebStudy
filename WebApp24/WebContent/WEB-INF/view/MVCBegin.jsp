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
<title>MVCBegin.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>

<!-- View -->

<div>
	<h1>MVC 실습</h1>
	<hr />
</div>

<div>
	<!-- 컨트롤러로부터 수신한 내용 -->
	<h2>${message }</h2>
	
	<!-- 
	클라이언트가 
	이 페이지 자체를 요청하게 할 게 아니라, /mvcbegin 을 요청하게 할거니까
	web.xml 에서 작업 ㄱㄱ
	
	클라이언트가 MVCBegin.jsp라고 입력해버리면, 메시지 수신하지 못한채 질질 끌려나가게 됨
	→ 입력해도 호출 안되게 해줘야 한다.
	→ 보호해줘야 한다.
	→ WEB-INF 폴더 안에 view 폴더 만들어서 그 안에 파일 넣어줌
	→ 클라이언트는 WEB-INF 폴더에 접근할 수 없기 때문에
	   이제 접근못한다!! 
	   이 페이지 자체에서 ctrl+f11 눌러서 실행하더라도 나오지 않는다.(404에러)
	   → 그런데 이 경로를 servlet은 접근할 수 있다.
	   MVCBegin.java 에서 getdispatcher 주소 수정
	   
	   RequestDispatcher dispatcher = request.getRequestDispatcher("MVCBegin.jsp");
	   	↓
	   	↓   수정 
	   	↓
	   RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/MVCBegin.jsp");
	   
	   이렇게 되면 『/mvcbegin』 주소 한땀한땀 입력해줘야한다.
	   WebContent 에 그냥 file 하나 만들어서 이름 『mvcbegin』 하고 걔를 ctrl+f11 해주면 된다.
	   확장자도 없이 그래서 만든거임! 실습 편의상 생성한거임
	   → 비어있는 file 생성안해줘도 상관없는데, 주소 걍 입력하는 방법밖에 없으니까ㅣ
	      주소 치기 귀찮으니까 파일 생성해서 걍 거기서 실행하려고 만든거임 ㅋㅋ 
	   → 이 파일은 어플리케이션의 구성요소 아님!!!
	
	-->
</div>

</body>
</html>