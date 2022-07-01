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
<title>JsonTest01.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		$("#sendBtn").click(function()
		{
			// 테스트
			//alert("확인");
			
			var params = "name=" + $.trim($("#name").val())
				+ "&content=" + $.trim($("#content").val());
			
			$.ajax(
			{
				type:"POST"
				, url:"JsonTest01_ok.jsp"
				, data:params
				, dataType:"json"			//-- check~!!! (지난번까지는 xml 썼었다.)
				, success:function(jsonObj)
				{
					var out = "";
					
					var num = jsonObj.num;	// 넘겨받은 json객체로 num 에 접근하고 있는 것
					var name = jsonObj.name;
					var content = jsonObj.content;
					
					out += "<br>=====================";
					out += "<br> 번호 : " + num;
					out += "<br> 이름 : " + name;
					out += "<br> 내용 : " + content;
					out += "<br>=====================<br>";
					
					$("#result").html(out);
					$("#name").val("");
					$("#content").val("");
					$("#name").focus();
				}
				, beforeSend:showRequest
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
		});
	});
	
	function showRequest()
	{
		var flag = true;
		
		if (!$.trim($("#name").val()))
		{
			alert("이름을 입력해야 합니다.");
			$("#name").focus();
			
			flag = false;
		}
		
		if (!$.trim($("#content").val()))
		{
			alert("내용을 입력해야 합니다.");
			$("#content").focus();
			
			flag = false;
		}
		return flag;
	}
	
</script>
</head>
<body>

<div>
	<h1>jQuery의 ajax() 활용 실습</h1>
	<p>json control</p>
	<hr />
</div>

<div>
	이름 <input type="text" id="name" class="txt" /><br /><br />
	내용 <input type="text" id="content" class="txt" /><br /><br />
	
	<input type="button" value="등록하기" id="sendBtn" class="btn" />
</div>
<br /><br />

<div id="result">
</div>

</body>
</html>