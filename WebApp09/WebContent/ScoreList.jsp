<!--  
	[[ 추가 구현 ]]
	이름: 필수입력(""), 공백만 여러개입력해도 확인("     ")
	      이름 사이 공백있으면 제거해서 처리(김  정 용 → 김정용)
	      
	점수: 입력안해도 됨(null로 처리)
		  숫자를 입력했는지 확인(isNaN() : Not a Number)
 -->
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	Connection conn = DBConn.getConnection();
	Statement stmt = conn.createStatement();
	String sql = "SELECT SID, NAME, KOR, ENG, MAT"
					+ ", (NVL(KOR,0)+NVL(ENG,0)+NVL(MAT,0)) AS TOT"
					+ ", ROUND((NVL(KOR,0)+NVL(ENG,0)+NVL(MAT,0))/3, 1) AS AVG"
					+ " FROM TBL_SCORE ORDER BY SID";
	ResultSet rs = stmt.executeQuery(sql);
	
	String str = "";
	str += "<table border='1'>";
	str += "<tr>";
	str += "<th>번호</th>";
	str += "<th>이름</th>";
	str += "<th>국어</th>";
	str += "<th>영어</th>";
	str += "<th>수학</th>";
	str += "<th>총점</th>";
	str += "<th>평균</th>";
	str += "</tr>";
	
	while(rs.next())
	{
		str += "<tr>";
		str += "<td>" + rs.getString("SID") + "</td>";
		str += "<td>" + rs.getString("NAME") + "</td>";
		str += "<td class='score'>" + rs.getString("KOR") + "</td>";
		str += "<td class='score'>" + rs.getString("ENG") + "</td>";
		str += "<td class='score'>" + rs.getString("MAT") + "</td>";
		str += "<td class='score'>" + rs.getString("TOT") + "</td>";
		str += "<td class='score'>" + rs.getString("AVG") + "</td>";
		str += "</tr>";
	}
	str += "</table>";
	
	rs.close();
	stmt.close();
	DBConn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ScoreList.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
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
		width: 80px;
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
			return false;
		}
		else if (parseInt(kor.value) < 0 || parseInt(kor.value) > 100 || isNaN(kor.value)) {
			korErr.style.display = "inline";
			return false;
		}
		else if (parseInt(eng.value) < 0 || parseInt(eng.value) > 100 || isNaN(eng.value)) {
			engErr.style.display = "inline";
			return false;
		}
		else if (parseInt(mat.value) < 0 || parseInt(mat.value) > 100 || isNaN(mat.value)) {
			matErr.style.display = "inline";
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<!--  
	○ WebApp09
	
	   - 여러 명의 이름, 국어점수, 영어점수, 수학점수를 입력받아
	     총점과 평균을 계산하여 출력해줄 수 있는 프로그램을 구현한다.
	   - 리스트 출력 시 번호 오름차순 정렬하여 출력할 수 있도록 한다.
	   - 데이터베이스 연동하여 처리한다.
	     (TBL_SCORE, SCORESEQ 활용) 	   	      
	   - 즉, 성적 처리 프로그램을 데이터베이스 연동하여
	     JSP로 구성할 수 있도록 한다.
	     
	     데이터베이스 연결 및 데이터 처리
	     ---------------------------------------------------------------------
	     성적 처리
	     
	     이름(*)	[ textbox ]   → 이름 입력 확인
	     국어점수	[ textbox ]   → 0 ~ 100 사이의 정수가 입력되었는지 확인
	     영어점수	[ textbox ]   → 0 ~ 100 사이의 정수가 입력되었는지 확인
	     수학점수	[ textbox ]   → 0 ~ 100 사이의 정수가 입력되었는지 확인
	     
	     < 성적 추가 >			  → button
	     
	     번호		이름	국어점수 영어점수 수학점수		총점	평균
	     1         이시우	   90      80        70         xxx     xx.x
	     2         이윤태	   80      70        60         xxx     xx.x
	     3         홍은혜	   70      60        70         xxx     xx.x
	     ---------------------------------------------------------------------
	     	   
	○ WebApp09_scott.sql
	   ScoreList.jsp
	   ScoreInsert.jsp
	   com.util.DBConn.java
-->
<div>
	<h1>데이터베이스 연결 및 데이터 처리</h1>
	<hr />
</div>

<h2>성적 처리</h2>
<div>
	<form action="ScoreInsert.jsp" method="post" onsubmit="return formCheck()">
		<span class="tag">이름(*)</span>
		<input type="text" class="text-field" id="name" name="name">
		<span class="error" id ="nameErr">이름을 입력해주세요.</span>
		<br>	
		<span class="tag">국어점수</span>
		<input type="text" placeholder="0~100" class="text-field" id="kor" name="kor">
		<span class="error" id="korErr">0~100 사이의 숫자를 입력해주세요.</span>
		<br>
		<span class="tag">영어점수</span>
		<input type="text" placeholder="0~100" class="text-field" id="eng" name="eng">
		<span class="error" id="engErr">0~100 사이의 숫자를 입력해주세요.</span>
		<br>	
		<span class="tag">수학점수</span>
		<input type="text" placeholder="0~100" class="text-field" id="mat" name="mat">
		<span class="error" id="matErr">0~100 사이의 숫자를 입력해주세요.</span>
		<br><br>
		<button class="btn">성적 추가</button>		
	</form>
</div>

<div>
	<%=str %>
</div>

</body>
</html>