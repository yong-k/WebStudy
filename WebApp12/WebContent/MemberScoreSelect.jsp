<%@page import="com.test.MemberScoreDTO"%>
<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	StringBuffer str = new StringBuffer();
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try 
	{
		dao.connection();
	
		str.append("<table class='table'>");
		str.append("	<tr>");
		str.append("		<th class='numTh'>번호</th>");
		str.append("		<th class='nameTh'>이름</th>");
		str.append("		<th>국어점수</th><th>영어점수</th><th>수학점수</th>");
		str.append("		<th>총점</th><th>평균</th><th>석차</th>");
		str.append("		<th>성적처리</th>");	
		str.append("	</tr>");
		
		for(MemberScoreDTO score : dao.lists())
		{
			str.append("<tr>");
			str.append("	<td>" + score.getSid() + "</td>");
			str.append("	<td>" + score.getName() + "</td>");
			str.append("	<td class='txtScore'>" + score.getKor() + "</td>");
			str.append("	<td class='txtScore'>" + score.getEng() + "</td>");
			str.append("	<td class='txtScore'>" + score.getMat() + "</td>");
			str.append("	<td class='txtScore'>" + score.getTot() + "</td>");
			str.append("	<td class='txtScore'>" + String.format("%.1f", score.getAvg()) + "</td>");
			str.append("	<td class='txtScore'>" + score.getRank() + "</td>");
			
			/*
			// 성적 처리 항목(입력, 수정, 삭제)
			str.append("	<td>");
			// 주소형태: 'MemberScoreInsertForm.jsp?sid=1&name=\"이윤태\"' 
			// 'MemberScoreInsertForm.jsp?sid=dto.getSid()&name=\"dto.getName()\"' 
			str.append("		<a href='MemberScoreInsertForm.jsp?sid=" + score.getSid() + "&name=\"" + score.getName() + "\"'>");
			str.append("			<button type='button' class='btn01'>입력</button>");
			str.append("		</a>");
			str.append("		<a href='MemberScoreUpdateForm.jsp'>");
			str.append("			<button type='button' class='btn01'>수정</button>");
			str.append("		</a>");
			str.append("		<a href='javascript:memberScoreDelete()'>");
			str.append("			<button type='button' class='btn01'>삭제</button>");
			str.append(			"</a>");
			str.append("	</td>");
			str.append("</tr>");
			*/
			
			/* 
			이미 성적 정보 입력된        사람들은 『입력』버튼 숨기거나, 비활
			아직 성적 정보 입력되지 않은 사람들은 『수정』『삭제』 버튼 숨기거나, 비활
			처리해보자 
			*/
			
			// 아직 성적 정보 입력되지 않은 사람 (수정/삭제 버튼 비활)
			if (score.getKor()==-1 && score.getEng()==-1 && score.getMat()==-1)
			{
				str.append("	<td>");
				
				//str.append("		<a href='MemberScoreInsertForm.jsp?sid=" + score.getSid() + "&name=\"" + score.getName() + "\"'>");
				//str.append("		<a href='MemberScoreInsertForm.jsp?sid=" + score.getSid() + "&name=" + score.getName() + "'>");
				// 이름까지 주소로 넘기지 말고, dao에 있는 searchScore() 사용
				str.append("		<a href='MemberScoreInsertForm.jsp?sid=" + score.getSid() + "'>");
				str.append("			<button type='button' class='btn01'>입력</button>");
				str.append("		</a>");
				
				str.append("		<button type='button' class='btn02' disabled='disabled'>수정</button>");
				
				str.append("		<button type='button' class='btn02' disabled='disabled'>삭제</button>");
				
				str.append("	</td>");
			}
			// 이미 성적 정보 입력된 사람 (입력 버튼 비활)
			else
			{
				str.append("	<td>");
				
				str.append("		<button type='button' class='btn02' disabled='disabled'>입력</button>");
				
				str.append("		<a href='MemberScoreUpdateForm.jsp?sid=" + score.getSid() + "'>");
				str.append("			<button type='button' class='btn01'>수정</button>");
				str.append("		</a>");
				
				str.append("		<a href='javascript:memberScoreDelete(" + score.getSid() + ", \"" + score.getName() + "\")'>");
				str.append("			<button type='button' class='btn01'>삭제</button>");
				str.append(			"</a>");
				
				str.append("	</td>");
			}

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
<title>MemberScoreSelect.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	a { text-decoration: none; }
</style>
<script type="text/javascript">

	function memberScoreDelete(sid, name)
	{
		 // 확인
		 //alert("함수 호출 확인~!!!");
		 
		 // ※ name 문자열 넘기는 과정에서 따옴표 구성에 주의할 것~!!!
		 
		 // 확인
		 //alert("번호: " + sid + ", 이름: " + name);
		 
		 var response = confirm("번호: " + sid + ", 이름: " + name + "\n이 회원의 성적 정보를 삭제하시겠습니까?");
		 
		 // 확인
		 //alert(response);
		 
		 if (response)
			 window.location.href = 'MemberScoreDelete.jsp?sid=' + sid;
	}
	
</script>
</head>
<body>

<div>
	<h1>회원 <span style="color: blue;">성적</span> 관리 및 출력 페이지</h1>
	<hr />
</div>

<div>
	<a href="MemberSelect.jsp"><button type="button">회원 명단 관리</button></a>
</div>
<br />

<div>

<!-- 번호 이름 국어점수 영어점수 수학점수 총점 평균 석차   성적 처리 -->
<!--  													  입력 수정 삭제-->
	<%=str.toString() %>
</div>
</body>
</html>