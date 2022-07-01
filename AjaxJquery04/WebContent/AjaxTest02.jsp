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
<title>AjaxTest02.jsp</title>
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
			/*
			$.ajax(
			{
				type:"POST"
				, url:"AjaxTest02_ok.jsp"
				, data:params
				//, async:false  	//-- 동기
					// 안써도 기본으로 들어가있는 값 → default 값은 true  
					// → true(비동기) / false(동기)
				, dataType:"xml"	// check~!!! 앞에서는 안썼던거
				, success:동작
				// └→ 어떤 형식으로 수신할 지 들어가야 한다.
				, beforeSend:true
				, error:동작
			
			});
			*/
			
			
			// jQuery 에서 XML 처리하는거 집중해서 보기!!!!
			$.ajax(
			{
				type:"POST"
				, url:"AjaxTest02_ok.jsp"
				, data:params
				//, async:false  	//-- 동기
				, dataType:"xml"	// check~!!!
				, success:function(args)
				{
					var out = "";
					out = ">> 게시물 개수 : " + $(args).find("total_dataCount").text() + "<br>";
					
					$(args).find("comment").each(function()
					{
						/*
						<lists>
							<total_datacount>5</total_datacount>
							<comment num="1">
								<name>한충희1</name>
								<content>안녕하세요1</content>
							</comment>
						</lists>
						→ 이런거 5개가 그대로 넘어온다.
						*/
						
						var item = $(this);							// <comment></comment> 한 구성씩을 말함
						var num = item.attr("num");					// 1
						var name = item.find("name").text();		// 한충희1
						var content = item.find("content").text();	// 안녕하세요1
						
						
						out += "<br>=========================";
						out += "<br> 번호 : " + num;
						out += "<br> 이름 : " + name;
						out += "<br> 내용 : " + content;
						out += "<br>=========================<br>";
					});
					
					$("#resultDiv").html(out);
					
					$("#name").val("");
					$("#content").val("");
					$("#name").focus();
				}
				// name, content 잘 들어있는지 확인
				, beforeSend:showRequest
				, error:function(e)
				{
					alert(e.responseText);
				}
			});
		});
	});
	
	// beforeSend:반환값확인
	// → 이 함수 독립적으로 빼서 진행했음
	function showRequest()
	{
		if (!$.trim($("#name").val()))
		{
			alert("이름을 입력해야 합니다.");
			$("#name").focus();
			
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
	
</script>
</head>
<body>
<!-- XML 형식으로 여러개의 데이터를 바인딩해보자 -->

<div>
	<h1>jQuery의 ajax() 활용 실습</h1>
	<hr />
</div>

<div>
	이름 <input type="text" id="name" class="txt" /><br /><br />
	내용
	<textarea id="content" cols="50" rows="3"></textarea>
	<br /><br />
	
	<input type="button" value="등록하기" id="sendBtn" />
</div>
<br /><br />

<div id="resultDiv">
</div>

</body>
</html>