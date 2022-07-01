<!--  
	게시판  		  → 로그인여부와 상관없이 접근 가능
	일정관리/친구관리 → 로그인 된 사용자만 접근 가능
						 로그인 전에는 버튼 disabled 설정
						 
	로그인 하고 나면, 첫 페이지도 바뀌어야 한다.
					  버튼도 로그인 대신 로그아웃 버튼 있어야 한다.
					  
	이럴 때 가장 많이 이용하는 것이 Session(세션) 이다.
	
	A.jsp     B     C     D     E    페이지 있을 때,
	로그인
	
	A페이지에서 로그인해서 B로 들어가고, C로 들어가고 한다고 할 때,
	로그인해야 C페이지 이용 가능한 것이다.
	그럴 때, 그 사용자가 로그인 했는지 안했는지 확인해보려면 
	→ 세션을 확인해봐야 한다.
	
	정책적으로 그 사람이 로그인했으면, 세션을 하나 심어두는 것
	그 사람이 B페이지 갔을 때, 세션있는지 먼저 확인하고 서비스 제공
	C페이지, D페이지 갔을 때, 세션 확인 후, 없으면 A페이지로 보냄     
	
	로그인 안해서 세션 없는 사람들은 B,C,D,E 어느 페이지를 가든지
	쫓겨나서 다시 A페이지로 오게 된다.
-->
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// TestSession01_ok.jsp 페이지에서 되돌려 보내면서
	// session 의 userId에 superman 을, userName 에 홍은혜를 담아서 보낸 상황
	
	// session 도 setAttribute(), getAttribute() 다 가능
	//							  --------------
	//							  Object type으로 반환
	
	String userId = (String)session.getAttribute("userId");		// "superman"
	String userName = (String)session.getAttribute("userName");	// "홍은혜"
	//				  ------- -------------------------------
	// 				  String type            Object type 반환
	//				으로 다운캐스팅
	//-- 『session.getAttribute("userId");』는
	//    Object 타입을 반환하므로
	//    String 타입으로 변환하는 과정 필요

	// 이 페이지 최초 요청했을 때, 
	// session 에 userId, userName 없다.
	// 이 페이지가 요청된 이후에 로그인 실패한 후에 돌아오면
	// session 에 userId, userName 없다.
	// 이 페이지가 요청된 이후에 superman 으로 로그인해서 로그인 성공 후 돌아오면
	// session 에 userId, userName 있다!
	
	// 세션이 설정된 브라우저 창을 종료한다고 해도
	// 다른 브라우저 창이 켜져있는 창이라면, 
	// 브라우저 내에서 그 세션이 계속 유지된다.
	
	
	// 추가~!!!
	// 우리는 로그인 한 상태에서, 로그아웃하지 않으면, 세션 계속 살아있다.
	// 이 페이지 닫혀있어도 다른 브라우저 창 열려 있으면 계속 로그인 살아있음
	// 그거 처리해보자
	
	// 세션 시간 변경 -----------------------------------------------------------------------
	
	// ※ 세션 기본(default) 시간은 1800초 
	//    → 아무것도 설정하지 않으면 세션이 기본으로 유지되는 시간은 1800초이다.
	
	session.setMaxInactiveInterval(10);
	//-- 세션이 유지되는 시간을 10초로 설정한 상태
	//   이로 인해...
	//   로그인 후 10초 동안 아무 액션도 없는 상태에서...
	//   다시 페이지 새로고침을 수행하면 로그아웃 처리된 것을 확인할 수 있다.
	
	// ----------------------------------------------------------------------- 세션 시간 변경
	
	// 현재 
	// http://localhost:8090/WebApp13/TestSession01_ok.jsp
	// 위 주소로 직접 들어오는 상태에 대해서는 무방비 상태다...!!!
	// 받은 값이 없으니까 500 서버 오류 뜸
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TestSession01.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	a {
		text-decoration: none;
	}
	
	.btnMenu {
		border: 1px solid gray;
		border-radius: 3px;
		font-size: 8pt;
		width: 60px;
		height: 20px;
	}
</style>
<script type="text/javascript">

	function sendIt()
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		// form 에 id 부여 안하고 name 속성으로 데리고 오는 방법
		var f = document.myForm;
		
		// f.userId.value → form의 해당 값 비어있으면 false 반환하는 듯
		// 공백(" ") 넣어보니까 true 반환됨
		//-- form 과 id에 둘 다 id 부여 안하고 name 속성으로 데리고 옴
		// form의 name속성이 userId의 value값이 없으면 false반환
		if (!f.userId.value)
		{
			alert("아이디를 입력해야 합니다~!!!");
			f.userId.focus();
			return;
		}
		
		if (!f.userPwd.value)
		{
			alert("패스워드를 입력해야 합니다~!!!");
			f.userPwd.focus();
			return;
		}
		
		f.submit();
	}
	
</script>
</head>
<body>

<div>
	<h1>세션 처리 - 로그인</h1>
	<hr />
</div>

<div>
	<table>
		<tr>
			<td>
				<a href="">
					<button type="button" class="btnMenu btn01">게시판</button>
				</a> |
				
				<% 
				if (userId == null)
				{
				%>
				<a href="">
					<button type="button" class="btnMenu btn02" disabled="disabled">일정관리</button>
				</a> |
				<a href="">
					<button type="button" class="btnMenu btn02" disabled="disabled">친구관리</button>
				</a>
				<% 
				}
				else 	// 로그인 성공하면 일정관리/친구관리 버튼 활성화시켜줌 	
				{
				%>
				<a href="Schedule.jsp">
					<button type="button" class="btnMenu btn01">일정관리</button>
				</a> |
				<a href="Friend.jsp">
					<button type="button" class="btnMenu btn01">친구관리</button>
				</a>
				<% 
				}
				%>
				
				
			</td>
		</tr>
	</table>
	<br /><br />
	
	<table>
		<tr>
			<td>
				<%
				 if (userId == null)
				 {
				%>
				<form action="TestSession01_ok.jsp" method="post" name="myForm">
					<table>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="userId" class="txt" style="width: 150px;"/>
							</td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td>
								<!-- <input type="password" /> -->
								<!-- 원래 pw는 type=password 로 구성해야하지만, 지금은 눈으로 확인할 수 있게 
									 아래와 같이 작성함 -->
								<input type="text" name="userPwd" class="txt" style="width: 150px;"/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<!-- 로그인버튼 클릭하면 sendIt() 스크립트 함수 호출하도록 속성 부여 -->
								<!-- js에서 sendIt() 함수로 확인 후, submit()할거라서
									 button type=submit 으로 안하고 그냥 button 으로 만듦!!! -->
								<button type="button" class="btn" style="width: 100%;" onclick="sendIt()">로그인</button>
							</td>
						</tr>
					</table>
				</form>
				<%
				 }
				 else
				 {
				%>
				<h2><%=userName %>(<%=userId %>)님 환영합니다.</h2>
				<h2>이제, 일정관리와 친구관리 서비스를 이용할 수 있습니다.</h2>
				<p>
					<a href="Logout.jsp ">
						<button type="button" class="btnMenu btn01">로그아웃</button>
					</a>
				</p>
				<% 
				 }
				%>
			</td>
		</tr>
	</table>
</div>

</body>
</html>