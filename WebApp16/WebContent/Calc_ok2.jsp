<%@page import="com.test.Calc"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// Calc_ok1.jsp 코드! (비교해보자)
	/* 
	String strSu1 = request.getParameter("su1");
	String strSu2 = request.getParameter("su2");
	String op = request.getParameter("op");
	
	int su1, su2;
	su1 = su2 = 0;
	String result = "";
	
	if (strSu1 == null || strSu2 == null)
	{
		response.sendRedirect("Calc.jsp");
	}
	else
	{
		su1 = Integer.parseInt(strSu1);
		su2 = Integer.parseInt(strSu2);
		
		Calc ob = new Calc();
		
		ob.setSu1(su1);
		ob.setSu2(su2);
		ob.setOp(op);
		
		result = ob.result();
	}
	*/
%>

<% 
	/*
	String strSu1 = request.getParameter("su1");
	int su1 = Integer.parseInt(strSu1);
	*/
	// 위에 구문 주석처리한다고 
	// Calc.jsp에서 Calc_ok2.jsp 로 값 아예 안 넘어오는 걸까?? No!
	// Calc.jsp 에서 submit() 해서 값은 처리가 되는데 / 전송이 된 건데	
	// Calc_ok2.jsp 에서 받아서 따로 정리를 안 한 것 뿐이다.
%>

<!-- Calc 클래스의 객체를 현재 페이지에서 사용할 수 있도록 지정 -->
<jsp:useBean id="ob" class="com.test.Calc" ></jsp:useBean>
<!-- 이 구문은 스크립 릿 영역에서 
	 『com.test.Calc ob = new com.test.Calc();』
	 을 작성하여 import 구문을 자동으로 처리한 것과
	 마찬가지 효과를 적용하게 된다. -->
<!--  
	Line46 작성하면 ServletContainer 에서 com.test.Calc 클래스 찾아간다.
	그 클래스 접근해서 ServletContainer 가 인스턴스 자기가 생성해준다.
	그리고 ob 있는지 확인하고 없으면 새로 생성해준다.	 
	useBean 만들어진 객체 있으면 그거 그대로 사용하고, 없으면 생성한다.
	별도로 scope 명시 안 하면, page 다.
	그럼 여기 page 만큼에서는 ob 객체로 com.test.Calc 에 접근할 수 있게 해준다.
-->
	 
<%-- <jsp:setProperty property="su1" name="ob" value="<%=strSu1%>"/> --%>	 
<!-- 이렇게 하고싶지만, setSu1은 int로 구성했기 때문에 이렇게 못넘기고, 아래처럼 해야한다. -->
<!-- request.getParameter() 메소드를 통해 넘겨받은(전달받은) 데이터를 
	 『Calc』 클래스를 기반으로 만들어진 『ob』 객체에
	 넘겨주기 위한 속성 지정 -->
<%-- <jsp:setProperty property="su1" name="ob" value="<%=su1%>"/> --%>
<!-- 이 구문은 Calc_ok1.jsp의 『ob.setSu1(su1);』과 같은 구문 -->	 
<!--  
	setProperty() 는 setter 메소드를 호출해준다.
	name 객체가 누군지 먼저 찾는다. 일단 ob 객체 찾아간다.
	ob를 찾게되면, ob라는 객체가 가지고 있는 property 중에서,
	property 값으로 넘긴 su1을 찾는다.
	su1에 대해 set을 해주려면, setSu1() 메소드 호출해야되는데,
	그거 ServeltContainer 가 호출해준다!!
	그러면서 그 안에 넘겨주려는 걸(매개변수를) value에 넣어주면 된다.
-->

<!-- check~!!! -->
<!-- ※ 속성 이름과 동일한 파라미터인 경우
		『getParameter()』 메소드 없이 바로 받을 수 있다. -->

 
	<!-- 둘 중 한 가지 방법으로 쓰면 된다. -->
	<%-- <jsp:~~></jsp:~~> --%>
	<%-- <jsp:~~ />  --%>



<!-- ① request.getParameter() 처리 → 매개변수를 전달하기 위한 데이터 수신 처리-->
<!-- ② Integer.parseInt() 처리 → 매개변수를 전달하기 위한 형 변환 처리 -->
<!-- ③ ob.su1 → ob.setSu1() 호출 처리 -->	 
<!-- ==> 최종적으로 ob → Calc 기반의 ob 객체의 su1 속성에
		 이전페이지로 넘겨받은 데이터를 적절한 타입(형)으로 전달 -->
<!-- 
	 → 이거 엄청나게 대단한 거..... 
		태그 쓰면 ServletContainer 가 알아서 처리해준다는 거..
		html 태그의 일종인건데 그 태그보고 ServletContainer가
		ob객체의 su1에 값 set해 달라는데, 뭘로 해달라고 말 안했네?
		이전 페이지에서 수신해서 넣어주면 되겠다!
		근데 ob가 갖고 있는 su1은 int 이고, 넘겨받은건 String 이니까
		형변환해서 넘겨주면 되겠구나~! 
-->
  		 
		 
<!-- 속성값으로 무슨 value로 채우겠다고 명시하지 않았다. -->
<jsp:setProperty property="su1" name="ob"/>	
<!-- setSu1() 호출하면서, 자기가 알아서 이전페이지로부터 넘겨받은 su1 알아서 끼워넣어준다.
	 왜? 이름이 같으니까!	 -->
<!-- ob가 가지고 있는 su1의 type은 int이고, 이전페이지에서 넘겨받은 su1은 String인데
	 자기가 알아서 형변환도 해준다!!
	 그래서 우리는 넘겨받고 Integer.parseInt() 처리해줬던 건데..!! -->	 
<jsp:setProperty property="su2" name="ob" />
<jsp:setProperty property="op" name="ob" />
<!-- form에서 입력받은 name 속성의 이름과 bean(dto)에서의 이름이 같은 경우에 
	 이런식으로 받을 수 있다. -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calc_ok2.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>두 번째 방법 처리 결과</h1>
	<hr />
</div>

<div>
	<!-- 결과 -->
	<h2><%=ob.result() %></h2>
</div>

</body>
</html>