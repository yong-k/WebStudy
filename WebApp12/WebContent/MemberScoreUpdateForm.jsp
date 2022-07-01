<%@page import="com.test.MemberScoreDTO"%>
<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sid = request.getParameter("sid");
	MemberScoreDAO dao = new MemberScoreDAO();
	String name = "";
	// 어차피 지금은 0~100 사이 정수 입력안하면, null 값은 입력 못하게 해놨기 때문에
	// 그냥 0으로 초기화해도 될 듯 하다.........→ 쌤은 0으로 초기화 함
	//나
	int kor = -1;
	int eng = -1;
	int mat = -1; 
	
	try 
	{
		dao.connection();
		MemberScoreDTO dto = new MemberScoreDTO();
		dto = dao.searchScore(sid);
		name = dto.getName();
		kor = dto.getKor();
		eng = dto.getEng();
		mat = dto.getMat();	
		
		
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
<title>MemberScoreUpdateFrom.jsp</title>
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
		var memberScoreForm = document.getElementById("memberScoreForm"); 
		var kor = document.getElementById("kor");
		var eng = document.getElementById("eng");
		var mat = document.getElementById("mat");
		var korMsg = document.getElementById("korMsg");
		var engMsg = document.getElementById("engMsg");
		var matMsg = document.getElementById("matMsg");
		
		korMsg.style.display = "none";
		engMsg.style.display = "none";
		matMsg.style.display = "none";
		
		if (Number(kor.value) < 0 || Number(kor.value) > 100 || isNaN(Number(kor.value)) || kor.value == "")
		{
			korMsg.style.display = "inline";
			kor.focus();
			return false;
		}
		else if (Number(eng.value) < 0 || Number(eng.value) > 100 || isNaN(Number(eng.value)) || eng.value == "")
		{
			engMsg.style.display = "inline";
			eng.focus();
			return false;
		}
		else if (Number(mat.value) < 0 || Number(mat.value) > 100 || isNaN(Number(mat.value)) || mat.value == "")
		{
			matMsg.style.display = "inline";
			mat.focus();
			return false;
		}
		 
		memberScoreForm.submit();
	}

	function memberScoreReset()
	{
		var memberScoreForm = document.getElementById("memberScoreForm");
		
		korMsg.style.display = "none";
		engMsg.style.display = "none";
		matMsg.style.display = "none";
		
		memberScoreForm.reset();
		kor.focus();
	}

</script>
</head>
<body>

<div>
	<h1>회원 <span style="color: blue;">성적</span> 관리
	      및 <span style="color: red;">수정</span> 페이지</h1>
	<hr />
</div>

<div>
	<a href="MemberScoreSelect.jsp"><button type="button">회원 성적 명단</button></a>
</div>
<br />

<div>
	<!-- 회원 성적 데이터 입력 폼 구성 -->
	<!-- form 다 내용 적혀있어야 함 -->
	<form action="MemberScoreUpdate.jsp?sid=<%=sid %>" method="post" id="memberScoreForm">
		<table class="table">
			<tr>
				<th>번호</th>
				<td>
					<input type="text" id="sid" class="sid" value="<%=sid%>" disabled="disabled"/>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" id="name" class="name" value="<%=name%>" disabled="disabled"/>
				</td>
			</tr>
			<tr>
				<th>국어점수</th>
				<td>
					<input type="text" id="kor" name="kor" class="score" placeholder="0~100" value="<%=kor%>"/>
					<div class="errContainer">
						<span class="errMsg" id="korMsg">0~100 사이의 숫자를 입력해주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>영어점수</th>
				<td>
					<input type="text" id="eng" name="eng" class="score" placeholder="0~100" value="<%=eng%>" />
					<div class="errContainer">
						<span class="errMsg" id="engMsg">0~100 사이의 숫자를 입력해주세요.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>수학점수</th>
				<td>
					<input type="text" id="mat" name="mat" class="score" placeholder="0~100" value="<%=mat%>" />
					<div class="errContainer">
						<span class="errMsg" id="matMsg">0~100 사이의 숫자를 입력해주세요.</span>
					</div>
				</td>
			</tr>
		</table>
		<br />
		<a href="javascript:memberScoreSubmit()"><button type="button">수정하기</button></a>
		<a href="javascript:memberScoreReset()"><button type="button">되돌리기</button></a>
		<a href="MemberScoreSelect.jsp"><button type="button">목록으로</button></a>
	</form>
</div>

</body>
</html>