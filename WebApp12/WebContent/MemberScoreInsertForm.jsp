<%@page import="com.test.MemberScoreDTO"%>
<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 이전 페이지(MemberScoreSelect.jsp)로부터 데이터(sid) 수신
	String sid = request.getParameter("sid");
	String name = "";	

	// name 을 조회하기 위해 dao 인스턴스 생성 
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try 
	{
		// 데이터베이스 연결
		dao.connection();
		
		// 수신한 sid 를 활용하여 name 얻어내기
		MemberScoreDTO dto = dao.searchScore(sid);
		name = dto.getName();
		
	}
	catch (Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
			dao.close();
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberScoreInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	.errContainer {
		display: block;
	}
	.errMsg {
		font-size: small;
		color: red;
		display: none;
	}
</style>
<script type="text/javascript">

	function memberScoreSubmit()
	{
		var scoreForm = document.getElementById("scoreForm"); 
		
		var kor = document.getElementById("kor");
		var eng = document.getElementById("eng");
		var mat = document.getElementById("mat");
		
		var korMsg = document.getElementById("korMsg");
		var engMsg = document.getElementById("engMsg");
		var matMsg = document.getElementById("matMsg");
		
		korMsg.style.display = "none";
		engMsg.style.display = "none";
		matMsg.style.display = "none";
		
		if (kor.value == "" || isNaN(Number(kor.value)) || Number(kor.value) < 0 || Number(kor.value) > 100)
		{
			korMsg.style.display = "inline";
			kor.focus();
			return;
		}
		else if (eng.value == "" || isNaN(Number(eng.value)) || Number(eng.value) < 0 || Number(eng.value) > 100)
		{
			engMsg.style.display = "inline";
			eng.focus();
			return;
		}
		else if (mat.value == "" || isNaN(Number(mat.value)) || Number(mat.value) < 0 || Number(mat.value) > 100)
		{
			matMsg.style.display = "inline";
			mat.focus();
			return;
		}
		
		// 성적 비어있으면(null) → 『-1』로 처리
		// → 안 됨. 오라클에서 성적 check 조건으로 0~100 사이만 가능하게 해놨음
		/*
		var blank_pattern = /[\s]/g;
		if (kor.value == "" || (kor.value).replace(blank_pattern, '') == "") 
			kor.value = -1;
		if (eng.value == "" || (eng.value).replace(blank_pattern, '') == "")
			eng.value = -1;
		if (mat.value == "" || (mat.value).replace(blank_pattern, '') == "")
			mat.value = -1;
		*/
		
		 scoreForm.submit();
	}

	function memberScoreReset()
	{
		var scoreForm = document.getElementById("scoreForm");
		
		korMsg.style.display = "none";
		engMsg.style.display = "none";
		matMsg.style.display = "none";
		
		scoreForm.reset();
		kor.focus();
	}

</script>
</head>
<body>

<div>
	<h1>회원 <span style="color: blue;">성적</span> 관리
	      및 <span style="color: red;">입력</span> 페이지</h1>
	<hr />
</div>

<div>
	<a href="MemberScoreSelect.jsp"><button type="button">회원 성적 명단</button></a>
</div>
<br />

<div>
	<!-- 회원 성적 데이터 입력 폼 구성 -->
	<!-- form에 번호,이름은 적혀있어야 함 -->
	<!-- hidden 으로 넘기는 것보다 get방식으로 넘기는 게 더 많이 활용된다. -->
	<form action="MemberScoreInsert.jsp?sid=<%=sid %>" method="post" id="scoreForm">
		<table class="table">
			<tr>
				<th>번호</th>
				<td>
					<!-- ★★★ 복습할 때 아래거에 name속성 추가하고 submit 하면 다음 페이지에서 받을 수 있는지 확인하기 ★★★-->
					<input type="text" id="sid" class="sid" value="<%=sid%>" disabled="disabled"/>
					<!-- 쌤은 아래 구문으로 하심 -->
					<%-- <%=sid %> --%>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="name" class="name" value="<%=name%>" disabled="disabled"/>
					<!-- 쌤은 아래 구문으로 하심 -->
					<!-- 테스트해보니 아래처럼 해도 다음 페이지로 name 넘어가지 않는건 내가 한 거와 동일함 -->
					<!-- ★ form 안에 있다고 해도 name을 가진 형태로 있어야 submit 되어야 다음 페이지로 넘어가는 거다. ★ -->
					<%-- <%=name %> --%>
				</td>
			</tr>
			<tr>
				<th>국어점수</th>
				<td>
					<input type="text" id="kor" name="kor" class="score" placeholder="0~100"/>
					<div class="errContainer">
						<span class="errMsg" id="korMsg">0~100 사이의 숫자를 입력해주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>영어점수</th>
				<td>
					<input type="text" id="eng" name="eng" class="score" placeholder="0~100" />
					<div class="errContainer">
						<span class="errMsg" id="engMsg">0~100 사이의 숫자를 입력해주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>수학점수</th>
				<td>
					<input type="text" id="mat" name="mat" class="score" placeholder="0~100" />
					<div class="errContainer">
						<span class="errMsg" id="matMsg">0~100 사이의 숫자를 입력해주세요.</span>
					</div>
				</td>
			</tr>
		</table>
		<br />
		<a href="javascript:memberScoreSubmit()"><button type="button">입력하기</button></a>
		<a href="javascript:memberScoreReset()"><button type="button">취소하기</button></a>
		<a href="MemberScoreSelect.jsp"><button type="button">목록으로</button></a>
	</form>
</div>

</body>
</html>