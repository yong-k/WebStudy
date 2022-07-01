<!--  
	[[ 추가 구현 ]]
	이름: 필수입력(""), 공백만 여러개입력해도 확인("     ")
	      이름 사이 공백있으면 제거해서 처리(김  정 용 → 김정용)
	      
	점수: 입력안해도 됨
		  숫자를 입력했는지 확인(isNaN() : Not a Number)
	 성적 → 공백 or 공백여러개 입력 시 → 나중에 null로 처리하기 위해 -99 넣음
	 INSERT 할 때 NULLIF(KOR,-99) 사용	
	 0점 입력한 것과, 입력 안 한거(null) 구분 가능
		  
 -->

<%@page import="com.test.ScoreDTO"%>
<%@page import="com.test.ScoreDAO"%>
<%@page import="com.util.DBConn"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	StringBuffer str = new StringBuffer();
	ScoreDAO dao = null;	

	String count = "<span id='count'>전체 인원 수 : ";
	
	try 
	{
		dao = new ScoreDAO();
		
		count += dao.count() + "명</span>";
		
		str.append("<table class='table'>");
		str.append("<tr><th>번호</th><th>이름</th><th>국어</th><th>영어</th><th>수학</th><th>총점</th><th>평균</th></tr>");
		
		for (ScoreDTO dto : dao.lists())
		{
			str.append("<tr>");
			str.append("<td class='record'>" + dto.getSid() + "</td>");
			str.append("<td class='record'>" + dto.getName() + "</td>");
			str.append("<td class='record'>" + dto.getKor() + "</td>");
			str.append("<td class='record'>" + dto.getEng() + "</td>");
			str.append("<td class='record'>" + dto.getMat() + "</td>");
			str.append("<td class='record'>" + dto.getTot() + "</td>");
			str.append("<td class='record'>" + dto.getAvg() + "</td>");
			str.append("</tr>");
		}
		str.append("</table>");
	} 
	catch(Exception e)
	{
		System.out.println(e.toString());
	} 
	finally 
	{
		try 
		{
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
<title>Scorelist.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<style type="text/css">
	body {
		font-family: 맑은고딕;
	}
	span.tag {
		display: inline-block;
		width: 90px;
	}
	.text-field {
		width: 150px;
	}
	.tag, .text-field, .error {
		margin: 5px;
	}
	span#count {
		display: inline-block;
		margin-top: 10px;
		margin-left: 5px;
		font-weight: bold;
	}
	table { 
		text-align: center; 
		width: 450px;
		margin-top: 20px;
	}
	th { background-color: #bab8bf; }
	td { background-color: #f7f7f7; }
	td.score { text-align: right; }
	.error {
		font-size: small;
		color: red;
		display: none;
	}
	.btn {
		width: 160px;
		height: 30px;
		margin-left: 5px;
	}
</style>
<script type="text/javascript">
	function formCheck()
	{
		var name = document.getElementById("name").value;
		var kor = document.getElementById("kor");
		var eng = document.getElementById("eng");
		var mat = document.getElementById("mat");
		var nameErr = document.getElementById("nameErr");
		var korErr = document.getElementById("korErr");
		var engErr = document.getElementById("engErr");
		var matErr = document.getElementById("matErr");
		nameErr.style.display = "none";
		korErr.style.display = "none";
		engErr.style.display = "none";
		matErr.style.display = "none";

		var blank_pattern = /[\s]/g;		// 정규식으로 공백 나타내는듯,,?
		if (name == "" || name.replace(blank_pattern, '' ) == "" ) {
			nameErr.style.display = "inline";
			document.getElementById("name").focus();
			return false;
		}
		else if (parseInt(kor.value) < 0 || parseInt(kor.value) > 100 || isNaN(kor.value)) {
			korErr.style.display = "inline";
			kor.focus();
			return false;
		}
		else if (parseInt(eng.value) < 0 || parseInt(eng.value) > 100 || isNaN(eng.value)) {
			engErr.style.display = "inline";
			eng.focus();
			return false;
		}
		else if (parseInt(mat.value) < 0 || parseInt(mat.value) > 100 || isNaN(mat.value)) {
			matErr.style.display = "inline";
			mat.focus();
			return false;
		}
		
		// 이름 사이사이에 공백 있으면 없애주기 ex) 김  정  용 → 김정용
		name = name.replace(blank_pattern, '');
			
		// 성적 → 공백 or 공백여러개 입력 시 → 나중에 null로 처리하기 위해 -99 넣음
		// INSERT 할 때 NULLIF(KOR,-99) 사용	
		// 0점 입력한 것과, 입력 안 한거(null) 구분 가능
		if (kor.value == "" || (kor.value).replace(blank_pattern, '') == "") 
			kor.value = -99;
		if (eng.value == "" || (eng.value).replace(blank_pattern, '') == "")
			eng.value = -99;
		if (mat.value == "" || (mat.value).replace(blank_pattern, '') == "")
			mat.value = -99;
		
		return true;
	}
</script>
<body>
<div>
	<h1>데이터베이스 연동 성적관리 실습</h1>
	<hr />
</div>
	<!-- 
		test case
		name : 공백, 공백여러개, 이름사이띄어쓰기
		score: 입력안했을 때, null로 나오나
	 -->
<div>
	<p>DAO, DTO 개념 적용</p>
	<form action="ScoreInsert.jsp" method="post" onsubmit="return formCheck();">
		<span class="tag">이름(*)</span>
		<input type="text" placeholder="ex)홍길동" class="text-field" id="name" name="name" />
		<span class="error" id="nameErr">이름을 입력해주세요.</span>
		<br>
		<span class="tag">국어점수</span>
		<input type="text" placeholder="0~100" class="text-field" id="kor" name="kor" />
		<span class="error" id="korErr">0~100 사이의 숫자를 입력해주세요.</span>
		<br>
		<span class="tag">영어점수</span>
		<input type="text" placeholder="0~100" class="text-field" id="eng" name="eng" />
		<span class="error" id="engErr">0~100 사이의 숫자를 입력해주세요.</span>
		<br>
		<span class="tag">수학점수</span>
		<input type="text" placeholder="0~100" class="text-field" id="mat" name="mat" />
		<span class="error" id="matErr">0~100 사이의 숫자를 입력해주세요.</span>
		<br><br>
		<button class="btn">성적 추가</button>
	</form>
</div>

<%=count %>
<%=str %>

</body>
</html>