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
<title>AjaxTest03.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function()
	{
		$("#sendBtn").click(function()
		{
			// 테스트
			//alert("확인");
			
			var params = "title=" + $.trim($("#title").val())
				+ "&content=" + $.trim($("#content").val());
			
			$.ajax(
			{	
				// 내가 해결한 방법
				/*
				type:"POST"
				, url:"AjaxTest03_ok.jsp"
				//, data:params
				// ↑ ↓ 둘 다 됨!
				,data:{"title":$('#title').val()
					 , "content":$('#content').val()}
				, dataType:"xml"
				, success:function(args)
				{
					var out = "";
					
					$(args).find("comment").each(function()
					{
						var item = $(this);
						var num = item.attr("num");
						var title = item.find("title").text();
						var content = item.find("content").text();
						
						out += "<br>=========================";
						out += "<br> >> id=" + num;
						out += "<br> - title=" + title;
						out += "<br> - content=" + content;
						out += "<br>=========================<br>";
					});
					
					$("#resultDiv").html(out);
					
					$("#title").val("");
					$("#content").val("");
					$("#title").focus();
				}
				, beforeSend:showRequest
				, error:function(e)
				{
					alert(e.responseText);
				}
				*/
				
				// 쌤 풀이
				type:"POST"
				, url:"AjaxTest03_ok.jsp"
				, data:params
				,dataType:"xml"
				, success:function(xml)
				{
					$(xml).find("status").each(function()
					{
						var status = $(this).text();
						alert(status);					// 확인
					});
					
					var str = "";
					
					$(xml).find("records").each(function()
					{
						//this 객체 구성할 때는 , 『# . ""』 다 안 들어감!!!
						var records = $(this);
						var id = records.attr("id");
						var title = $(this).find("title").text();
						var content = $(this).find("content").text();
						
						str += ">> id=" + id + "<br>- title=" + title
							+ "<br>- content=" + content + "<br><br>";
					});
					
					$("#resultDiv").html(str);
				}
				, beforeSend:showRequest
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
		});
	});
	
	// 나
	/*
	function showRequest()
	{
		if (!$.trim($("#title").val()))
		{
			alert("제목을 입력해야 합니다.");
			$("#title").focus();
			
			return false;
		}
		
		if (!$.trim($("#content").val()))
		{
			alert("내용을 입력해야 합니다.");
			$("#content").focus();
			
			return false;
		}
		return true;
	}
	*/
	
	// 쌤
	function showRequest()
	{
		var flag = true;
		
		if (!$.trim($("#title").val()))
		{
			alert("제목을 입력해야 합니다.");
			$("#title").focus();
			
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
<!-- XML 형식으로 여러개의 데이터를 바인딩해보자 -->

<div>
	<h1>jQuery의 ajax() 활용 실습</h1>
	<hr />
</div>

<div>
	<!-- AjaxTest02.jsp에서 내용물 구성 바꿈
		 이름 내용(textarea) → 제목 내용(text) -->
	
	제목 <input type="text" id="title" class="txt" /><br /><br />
	내용 <input type="text" id="content" class="txt" /><br><br> 
	<br /><br />
	
	<input type="button" value="등록하기" id="sendBtn" />
</div>
<br /><br />

<div id="resultDiv">
<!--  	 
	제목,내용 입력 후 [등록하기] 누르면 #resultDiv 에
	>> id=1
	- title=테스트
	- content=반갑습니다
	
	>> id=2
	- title=테스트
	- content=반갑습니다
	
	→ 형식으로 나오게 처리해보자
-->
</div>

</body>
</html>