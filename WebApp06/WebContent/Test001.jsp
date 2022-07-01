<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 안만들어도 페이지에서 기본적으로 갖는 설정값 
	 buffer는 8kb
	 autoFlush 는 true -->
<%-- <%@ page buffer="8kb" autoFlush="true"%> --%>

<!-- 페이지의 임시기억크기/공간을 1kb로 줄이고,
	 autoFlush 라고 하는 버퍼가 다 채워졌을 때 자동으로 밀어내고,
	 다시 버퍼 채우게하고, 밀어내는 기능의 옵션 속성을 false로 부여했다. -->
<%-- <%@ page buffer="1kb" autoFlush="false"%> --%>
<!-- 그러면 서버오류인 500 에러 발생한다.
	 --==>> HTTP 상태 500 – 내부 서버 오류
            java.io.IOException: 오류: JSP 버퍼 오버플로우 -->
            
<!-- 버퍼 크기를 10kb로 늘려보자 -->            
<%-- <%@ page buffer="10kb" autoFlush="false"%> --%>            
<!-- 에러 발생하지 않는다. → 우리가 출력하는 게 10kb 넘지 않는다는 뜻 
	 1000번 반복하는거 4000번 반복으로 고치면 500 에러 발생함 ㅎㅎ-->
	 
<%@ page buffer="1kb" autoFlush="true"%>
<!-- 1kb 채워지면 그거 밀어내고 다시 받아서 에러 발생하지 않는다. -->	 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test001.jsp</title>
</head>
<body>

<div>
	<h1>page 디렉티브 buffer 속성 및 autoFlush 실습</h1>
	<hr>
</div>

<div>
	<h2>반복문 구성</h2>
	
	<% 
	for(int i=1; i<=1000; i++)
	{
	%>1234<% 
	}
	%>
</div>

</body>
</html>