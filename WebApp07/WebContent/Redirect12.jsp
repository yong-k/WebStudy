<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// Redirect12.jsp
	
	// 이전 페이지(Send12.html)로부터 데이터(num1, calResult, num2) 수신
	int num1 = Integer.parseInt(request.getParameter("num1"));
	int num2 = Integer.parseInt(request.getParameter("num2"));
	String op = request.getParameter("calResult");
	
	// 연산 처리
	String str = "";
	if (op.equals("1"))
		str += String.format("%d", (num1+num2));
	else if (op.equals("2"))
		str += String.format("%d", (num1-num2));
	else if (op.equals("3"))
		str += String.format("%d", (num1*num2));
	else if (op.equals("4"))
		str += String.format("%.1f", (num1/(double)num2));
	
	// check~!!!
	// 결과 데이터 재전송 → sendRedirect() 메소드 사용
	// ※ response 객체의 주요 메소드 중 하나인
	//    『sendRedirect(String location)』
	//	   : 지정된 URL(location)로 요청을 재전송한다.
	//response.sendRedirect("Receive12.jsp");
	//-- 클라이언트에 Receive12.jsp 페이지를 다시 요청할 수 있도록 안내
	//   클라이언트가 넘겼던 값들 싹 날아감!
	//   그냥 이대로 놔두면 Receive12.jsp 가 등장하는 걸로 끝난다.
	//-- Receive12로 다시 전화걸어서 눈 껌뻑거리고 있는거
	//   엄...앞에 Redirect12.jsp에 전화걸었는데 여기로 걸라고 했어요...
	//   무슨 일인지는 모르지만 여기로 걸라고 해서 걸었어요...
	//   → 하고 끝나는거!!!
	
	// 클라이언트의 요청내용 그대로 받아가지고 Receive12.jsp 로 가려면!!
	// get 방식의 장점을 이용하면 된다^-^,,
	response.sendRedirect("Receive12.jsp?num1="+num1+"&num2="+num2+"&op="+op+"&str="+str);
	//-- '고갱님 Receive12 로 전화걸어서 ~~~~ 이렇게 하시면 돼요~~' 라고 전달해주는거!
	
	// 에러났던 이유
	// response.sendRedirect()
	// 이거 2개 써놔서. 위에 썼던거 주석처리 안했었음..!
	//--=>> java.lang.IllegalStateException: 응답이 이미 커밋된 후에는, sendRedirect()를 호출할 수 없습니다.
	//	    위와 같은 에러 발생했다.
%>


<!-- 
		밑에 html 쫙 다 지움
		여기 파일에는 자바 코드밖에 없다.
		이렇게 분리해 놓으면 → 얘도 바로 Servlet으로 만들 수 있다~!! 
-->
