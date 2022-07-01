<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// TestSession01_ok.jsp
	request.setCharacterEncoding("UTF-8");
	
	// 이전페이지(TestSession01.jsp)로부터 넘어온 데이터(userId, userPwd) 수신
	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	// 사실 여기서는
	// dto 활용 → 로그인 관련 테이블과 데이터와 비교해야 한다.
	// 비교하는 과정에서 → dao 활용 → 최종적으로 로그인 액션 처리
	
	// 지금은 일단 생략하고
	// id,pw 받아서 아래와 같이 처리,,! 
	String memberId = "superman";
	String memberPwd = "123456";
	String memberName = "홍은혜";
	
	if (userId.equals(memberId) && userPwd.equals(memberPwd))
	{
		// 로그인 액션 처리
		session.setAttribute("userId", userId);			//-- userId   에 'superman' 넣어주고
		session.setAttribute("userName", memberName);	//-- userName 에 '홍은혜' 넣음
		
		// 클라이언트가 페이지를 다시 요청할 수 있도록 안내
		response.sendRedirect("TestSession01.jsp");
	}
	
	// if 문 안에 못 들어가면 response.sendRedirect(); 못 받아서 
	// 이 페이지 안에 계속 남아있을 것이다.
%>

<!--  
	위와 아래 둘 다 결국은 TestSession01.jsp 로 돌아가는데,
	둘의 차이점은?
	
	로그인 성공해서 TestSession01.jsp 돌아갔으면,
	userId와 userName 이 들어있을 거고
	
	로그인 실패해서
	아래에서 링크 눌러서 돌아가면 session 에 userId와 userName 이 들어있지 않음
-->

<h1>로그인 실패~!!!</h1>

<a href="TestSession01.jsp">이전 페이지로 돌아가기</a>