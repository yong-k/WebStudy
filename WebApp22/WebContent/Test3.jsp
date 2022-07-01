<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	
	request.setAttribute("result", "EL 테스트");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test3.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<!-- ★ 중요한 실습 ★ -->

<div>
	<h1>EL 관련 실습</h1>
	<hr>
</div>

<div>
	<!-- form 구성했는데 action 속성 명시하지 않은 상태 -->
	<!-- └→ 여기서 전송한 내용을 Test3.jsp에서 그대로 받겠다는 뜻이 된다. -->
	<!-- action 속성 생략 → su1 과 su2 데이터를 전송하며 요청하는 페이지는 자기 자신~!!! -->
	<form method="post">
		정수1 <input type="text" name="su1" class="txt"><br>
		정수2 <input type="text" name="su2" class="txt"><br>
		<button type="submit" class="btn">결과 확인</button>
	</form>
</div>

<div>
	<h2>폼 데이터 수신</h2>
	
	<!-- 폼의 데이터를 수신하는 방법 1 -->
	<h3><%=request.getParameter("su1") %></h3>
	<!-- └→ 처음에 화면에 null 떠 있음 
	 		  개발과정에서 test 할 때는 얘가 더 유용함 -->
	
	
	<!-- EL 문법 사용해서 수신해보자 -->  <%-- ${ } --%>
	<!-- → jQuery 선택자의 기호[→ $( ) ]와 비슷하게 생겨서 jsp 의 EL 문법 기호 잘 눈도장 찍어두기!-->
	<!-- 폼의 데이터를 수신하는 방법 2 -->
	<h3>${param.su1 }</h3> 
	<!-- └→ 처음에 화면에 null 떠 있지 않음 
			  cilent 한테 서비스할 때는 이게 더 유용함 -->
	
	<!-- 
		넘어온 파라미터를 다 받아내는게 있고, 그 중에 param.su1 하면 su1 받아옴
		표현식이 아니라 EL을 사용하면 조금 더 축약된 형태로 받아낼 수 있다.
		EL은 null을 표현하는 방법이 자유롭기 때문에 null 보이지 않는다.
		표현식 기반으로 null 에 대한 기능처리한다고 하면 에러나지만, 
		EL 기반으로 null 에 대한 기능처리한다고 하면 에러나지 않는다.
	-->
</div>
<br /><br />

<div>
	<h2>폼의 데이터를 받아 연산 수행</h2>
	
	<!-- 폼의 데이터를 받아 연산을 수행하는 방법 1 -->
	<%
		String s1 = request.getParameter("su1");
		String s2 = request.getParameter("su2");
		
		int s = 0;
		
		
		/* submit을 해서 넘길 때 EL은 빈문자열로 수신한다. null로 수신하는 것이 아니라!!
		최초 페이지 요청일 때는 아예 값 안넘긴거니까 null 이지만,
		submit 해서는 빈문자열로 넘긴다! */
		
		//-- 이건 이 페이지에 대한 최초요청일 때만 해당되는 것이다.
		//   submit을 했을 때가 아니라!
		if (s1 != null && s2 != null)	
			s = Integer.parseInt(s1) + Integer.parseInt(s2);
	%>
	<h3>합 : <%=s %></h3>
	
	
	<!-- EL 을 사용해보자 -->	
	<!-- 폼의 데이터를 받아 연산을 수행하는 방법 2 -->
	<h3>합 : ${param.su1 + param.su2 }</h3>
	<!-- 
 		→ ① 파라미터 수신도 EL이 알아서 (request.getParameter() 할 필요 없다.)
    	   ② 필요한 캐스팅도 알아서 자동으로 수행해준다. (Integer.parseInt() 할 필요 없다.)
   	       ③ null을 대하는 방식도 되게 유연하다!! check~!!!  
     -->
</div>
<br /><br />

<div>
	<h2>setAttribute() 로 넘긴 데이터 수신</h2>
	
	<!-- setAttribute() 로 넘긴 데이터를 수신하는 방법 1 -->
	<h3><%=request.getAttribute("result") %></h3>
	
	
	<!-- EL 사용해보자 -->
	<!-- setAttribute() 로 넘긴 데이터를 수신하는 방법 2 -->
	<!-- 이제 『param.』 도 없고, ** attribute의 이름만 넘기면 된다.** -->
	<h3>${result }</h3>
</div>




</body>
</html>
























