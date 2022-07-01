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
<title>JsonTest02.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function()
	{
		$("#sendBtn").click(function()
		{
			var params = "name=" + $.trim($("#name").val())
			+ "&content=" + $.trim($("#content").val());
			
			$.ajax(
			{
				type:"POST"
				, url:"JsonTest02_ok.jsp"
				, data:params
				, dataType:"json"			// check~!!! json 객체나 배열이나 다 그냥 dataType은 json이다.
				,success:function(jsonObj)
				{
					var out = "";
					
					
					// 여기에 수신된 jsonObj 는 json 배열 객체이다.
					// → 배열방만큼 반복문 순환
					for (var i=0; i<jsonObj.length; i++)
					{
						var num = jsonObj[i].num;
						var name = jsonObj[i].name
						var content = jsonObj[i].content;
						
						out += "<br>=====================";
						out += "<br> 번호 : " + num;
						out += "<br> 이름 : " + name;
						out += "<br> 내용 : " + content;
						out += "<br>=====================<br>";
					}
					
					$("#result").html(out); 
					$("#name").val("");
					$("#content").val("");
					$("#name").focus();
				}
				, beforeSend:showRequest
				, error:function(e)
				{
					alert(e.responseText)
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
<!-- 
	[[json 배열 컨트롤 해보자]]
	이름, 내용 입력 후, [등록하기] 버튼 누르면
	JsonTest02_ok.jsp 에서 name과 content 수신
	ajax 처리로 
	[{"num":"1", "name":"임소민1", "content":"안녕하세요1"}]
	이거 5개 만든다. num 1~5까지 
-->
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