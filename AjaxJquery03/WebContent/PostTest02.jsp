<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PostTest02.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
	#resultDiv {
		width: 240px;
		height: 180px;
		border: 2px solid #499bd7;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		$("#sendBtn").click(function()
		{
			$.post("PostTest02_ok.jsp"
			, {title:$("#title").val(), content:$("#content").val()}
			, function(data)
			{
				$("#resultDiv").html(data);
			});
		});
	});
	
</script>
</head>
<body>
<!-- 
	함수 이름 바뀌었는데, get(), post() 사용법 똑같다.
	get방식으로 문자열 형식으로 다 넘기는게 아니라
	post()는 data따로 바인딩해서 넘기는거
	form에 submit 하듯이! 
-->
<!--  
	[보내기] 버튼 누르면 PostTest02_ok.jsp 에서 수신해서
	그 내용 PostTest02.jsp 에 띄워주는거 해보자
-->
<div>
	<h1>jQuery 의 post() 활용 실습</h1>
	<hr />
</div>

<div>
	제목 <input type="text" id="title" class="txt" /><br />
	내용 <input type="text" id="content" class="txt" /><br />
	<input type="button" value="보내기" id="sendBtn" class="btn" />
</div>
<br /><br />

<div id="resultDiv">
</div>

</body>
</html>