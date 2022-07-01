<!-- 데이터베이스 내용 읽고, 내용 추가 되게 해보자 -->
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	// 결과값 변수
	String str = "";

	// 데이터베이스 연결
	Connection conn = DBConn.getConnection();

	// 쿼리문 준비 (select)
	String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER ORDER BY SID";

	// 작업 객체 생성 및 준비된 쿼리문 수행
	Statement stmt = conn.createStatement();

	ResultSet rs = stmt.executeQuery(sql);

	// 결과 ResultSet 에 대한 처리 -> 반복문 처리
	str += "<table class='table'>";
	str += "<tr>";
	str += "<th id='numTitle'>번호</th>";
	str += "<th id='nameTitle'>이름</th>";
	str += "<th id='telTitle'>전화번호</th>";
	str += "</tr>";

	while (rs.next())
	{
		str += "<tr>";
		str += "<td class='list'>" + rs.getString("SID") + "</td>";
		str += "<td class='list'>" + rs.getString("NAME") + "</td>";
		str += "<td class='list'>" + rs.getString("TEL") + "</td>";
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
<title>Test002.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
	input { width: 200px; }
	button {
		width: 208px;
		height: 50px;
		font-weight: bold;
	}	
	.errMsg {
		font-size: small;
		color: red;
		display: none;
	}
	#numTitle { width: 50px; }
	#nameTitle { width: 100px; }
	#telTitle { width: 160px; }
	.list { text-align: center; }
</style>

<script type="text/javascript">

	// 필수 입력 항목(이름)에 대한 기본적인 확인
	function formCheck()
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		var uName = document.getElementById("userName");
		var nErr = document.getElementById("nameErr");
		
		nErr.style.display = "none";
		
		if (uName.value == "")
		{
			nErr.style.display = "inline";
			return false;
		}
		
		return true;
	}
	
</script>
</head>
<body>

<div>
	<h1>데이터베이스 연결 및 데이터 처리</h1>
	<hr>
</div>
<!--
	현재, select 구문까지 제대로 작동되는 거는 확인되었다.
	입력폼에서 submit버튼 누르면서 [이름, 전화번호]를 『MemberInsert.jsp』로 넘겨주면
	『MemberInsert.jsp』에서는 insert 쿼리문을 수행하면 된다.
	그냥 insert 실행해준 채로 다시 Test002.jsp로 돌아오기만 하면!
	Test002.jsp 에서는 처음 실행할 때 어차피 select 문 실행하므로
	insert 잘 실행됐다면, 새로운 내용 insert 된 채로 select 되어있을 것이다.
	
	그러면, 클라이언트는 insert 액션이 수행되는 『MemberInsert.jsp』 페이지가 있는지 모를 것이다.
	사용자 입장에서는 → 계속 Test002.jsp 에 있다고 생각할 것이다.
	하지만, insert 구문 발생하면 『MemberInsert.jsp』로 갔다가 다시 Test002.jsp 로 오는 것이다.
	클라이언트 스스로 Test002.jsp 『리다이렉트』 하도록 만들어야
	『MemberInsert.jsp』에서 다시 Test002.jsp 로 돌아와서 업무 수행할 것이다.
-->
<div>
	<form action="MemberInsert.jsp" method="post" onsubmit="return formCheck()">
		<table>
			<tr>
				<th>이름(*)</th>
				<td>
					<input type="text" id="userName" name="userName" class="txt">
					<span class="errMsg" id="nameErr">이름을 입력해야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" id="userTel" name="userTel" class="txt"></td>
			</tr>
			<tr>
				<th></th>
				<td>
					<button type="submit" id="btnAdd" class="btn control">데이터 추가</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<br><br>

<div>
	<!-- 처리 결과 -->
	<%=str %>
</div>
</body>
</html>