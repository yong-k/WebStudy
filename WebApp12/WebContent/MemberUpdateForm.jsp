<%@page import="com.test.MemberDTO"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// sid 수신해서
	// 수신한 sid 를 가지고 회원 데이터 조회
	// 조회해서 얻어낸 데이터를 폼에서 보여지게끔 해줘야 한다.
	
	// 이전 페이지(MemberSelect.jsp)로부터 데이터(sid) 수신

	request.setCharacterEncoding("UTF-8");
	
	String sid = request.getParameter("sid");
	String name = "";
	String tel = "";

	MemberDAO dao = new MemberDAO();

	try
	{
		// 데이터베이스 연결
		dao.connection();
		
		MemberDTO member = dao.searchMember(sid);
		name = member.getName();
		tel = member.getTel();
		
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try 
		{
			// 데이터베이스 연결 종료
			dao.close();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberUpdateForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<script type="text/javascript">

	function memberSubmit()
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		var memberForm = document.getElementById("memberForm");
		var uName = document.getElementById("uName");
		var nameMsg = document.getElementById("nameMsg");
		
		// 다시 이 함수 요청했을 때, 
		// 이미 해결된 상태면 안보여야 하기 때문에, 아래와 같이 style 처리
		nameMsg.style.display = "none";
		
		if (uName.value == "")
		{
			nameMsg.style.display = "inline";
			uName.focus();
			return;
		}
		memberForm.submit();
	}
	
	function memberReset()
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		var memberForm = document.getElementById("memberForm");
		nameMsg.style.display = "none";
		
		memberForm.reset();
		uName.focus();
	}

</script>

</head>
<body>

<div>
	<h1>회원 <span style="color: red;">명단</span> 관리
		  및 <span style="color: blue;">수정</span> 페이지</h1>
	<hr />
</div>

<div>
	<a href="MemberSelect.jsp"><button type="button">회원 명단 관리</button></a>
</div>
<br />

<div>
	<!-- 회원 데이터 입력 폼 구성 -->
	<!-- sid 다음페이지로 넘기는 방법② get 방식의 장점 이용 -->
	<form action="MemberUpdate.jsp?sid=<%=sid %>" method="post" id="memberForm">
		<table class="table">
			<tr>
				<th>이름(*)</th>
				<td>
					<input type="text" id="uName" name="uName" value="<%=name%>"/>
				</td>
				<td>
					<span class="errMsg" id="nameMsg">이름을 입력해야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" id="uTel" name="uTel" value="<%=tel%>"/>
				</td>
				<td>
				</td>
			</tr>
		</table>
		<!-- sid 다음페이지로 넘기는 방법① input type="hidden" 사용
			 사용자에게 보여주지는 않지만 가지고 있는 거 
		     sid 가 여기페이지로 넘어왔지만, 그 다음 페이지인 MemberUpdate.jsp까지
		     전달되는 건 아니라서, 넘기려고 이렇게 함
		     그럼 form 안에 있기 때문에 다음 페이지에서 값 전달받을 수 있다. -->
		<%-- <input type="hidden" name="sid" value="<%=sid%>"> --%>
		<br />
		<a href="javascript:memberSubmit()"><button type="button">수정하기</button></a>
		<a href="javascript:memberReset()"><button type="button">취소하기</button></a>
		<a href="MemberSelect.jsp"><button type="button">목록으로</button></a>
	</form>
</div>

</body>
</html>