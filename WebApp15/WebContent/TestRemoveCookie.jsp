<%@ page contentType="text/html; charset=UTF-8"%>
<%
	response.setCharacterEncoding("UTF-8");

	// 세션을 제거하는 메소드는 있었지만
	// 쿠키를 제거하는 메소드는 없다.
	// 그럼 쿠키 어떻게 제거? 
	// → 비어있는 내용으로 기존의 쿠키를 덮어쓰기 하는 개념
	Cookie killCookie = new Cookie("cookie_test", null);
	//-- 아직 덮어쓰지는 않은 상황
	
	// 설정도 바꿔서 심음
	killCookie.setMaxAge(0);
	//-- 0으로 설정하면 생성과 동시에 소멸!!
	//  ·『expiry』 가 『0』일 때
    //     : 생성과 동시에 쿠키가 제거된다.
	response.addCookie(killCookie);
	//-- 이거하면 기존 쿠키에 덮어쓰기!
	//-- 처음 쿠키를 구성할 때에도 『addCookie()』로 처리하였기 때문에
	//   삭제할 때에도 『addCookie()』로 처리해야 안정적으로 삭제
	// killCookie 로 cookie 밀어버림
	
	// 처음에 addCookie()로 쿠키 심었기 때문에,
	// 다시 addCookie()로 비어있는 쿠키 심는다.
	
	// 즉, 내용이 포함된 쿠키를 심었다가...
	// 이번에는 내용이 비어있는 쿠키를 심는다는 개념
	
	// ※ 여기서 쿠키 삭제는 클라이언트 입장에서의 삭제이다.
	//    한 명의 클라이언트가 쿠키를 삭제했다고 해서
	//    다른 클라이언트들의 쿠키도 삭제되면 안되기 때문에
	//    이 쿠키의 정보는 로컬 PC 에서 컨트롤하게 된다. (브라우저가...)
	//-->  A가 오늘 하루 이 창 보지 않음 체크했는데, 그게 B, C, D 한테도 안보이면 안되니까!
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>쿠키 정보 삭제하기</h1>
	<hr />
</div>

<div>
	<h2>성공적으로 쿠키를 제거했습니다~~!!</h2>
</div>

<div>
	<a href="TestSetCookie.jsp"><button type="button" class="btn">쿠키 정보 설정</button></a>
	<a href="TestGetCookie.jsp"><button type="button" class="btn">쿠키 정보 확인</button></a>
</div>

</body>
</html>

<!--  
		클라이언트가 가지고 있는 브라우저에는
		Cookie 통이 있고, 그 안에
		
		---- Cookie 통 ----
		쿠팡상품명
		쿠팡접속일
		
		민성접속일    → key: "date", value: "2022-04-20"
		
		전자문서출력번호
		전자신문최종접속일
		전자신문열람기사
			
				:
				:
				:
		--------------------
		
		클라이언트가 어느 사이트 접속되면,
		그 사이트가 '야 너 date있으면 내놔!' 해서 주면
		→ getCookie("date")
		'아 4월 20일에 접속했었구나~' 확인
		아예 없으면 '아 우리 페이지 처음왔구나!' 
		
		그리고 오늘 접속했으면 setCookie 해서 
		value 값 2022-04-21 로 바꿈
		
		그런데 회원탈퇴나 이 사이트에 추천 이벤트 더 이상 보고싶지않아!
		이런 사이트에 거부적인 의사 표현해서 지워달라고 하면
		date라는 쿠키값을 하루동안 보관하게 만들었기 때문에
		destroy 쏴서 파괴할 수는 없음
		
		그럼 date에 null 이 들어가있는 cookie를 다시 얘한테 심어버리면
		민성접속일 확인했을 때, date값 null 이 된다.
		
		심는 걸로 끝나는게 아니라, 생성과 동시에 사라지는 
		.setMaxAge(0)으로 주면 
		아예 민성 접속일 자체가 사라진다!!
		
		★ 중요한건 !!!!!! 
		처음 발행받았던 key 값 이름이어야 한다!!!!!!!!!
		"cookie_test"로 만들었으면, 그 이름으로 추가해줘야 한다!!!!
		
-->


