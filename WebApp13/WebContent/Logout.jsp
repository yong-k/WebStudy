<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// Logout.jsp
	//-- 세션의 내용을 없애서 로그아웃 액션 처리
	
	// session의 removeAttribute() 메소드가 세션 내용 없애는 거다.
	session.removeAttribute("userId");
	session.removeAttribute("userPwd");
	session.removeAttribute("userName");
	//-- 세션의 사용자 아이디와 패스워드와 이름 삭제
	
	// 위에꺼 수행해도 되고, 아래꺼 수행해도 되고,
	// 위/아래 모두 수행해도 다 상관없다!
	
	// 기존 세션에 저장되어 있는 모~~~든 항목을 한 번에 제거하고
	// 세션을 초기화
	session.invalidate();
	
	
	// 클라이언트에게 다시 로그인 페이지를 요청할 수 있도록 안내
	response.sendRedirect("TestSession01.jsp");
%>
