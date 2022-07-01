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
<title>LoadingTest.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	// sendBtn이 클릭되어있는지 얘가 모니터한다.
	// ajax도 어떻게 작동되고 있는지 jQuery가 모니터한다.
	// → 'ajax시작하면 어떤 동작해라, 끝나면 어떤 동작해라' 라는 내용
	//    jQuery 함수 안에 있어야 한다.
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
				, url:"LoadingTest_ok.jsp"
				, data:params
				
				// ↓ LoadingTest_ok에서 받아온걸로 작업
				, success:function(args)
				{
					$("#result").html(args);
					
					$("#name").val("");
					$("#content").val("");
					$("#name").focus();
				}
				, beforesend:showRequest
				, err:function(e)
				{
					alert(e.responseText);
				}
			});
		});
		
		// check~!!!
		//$(document).ajaxStart(기능,동작,행위).ajaxComplete(기능,동작,행위);
		// 로딩 이미지로 사용하지 않아도, 
		//어떤 문구를 보이게 했다 안보이게 하는 것도 가능하다!!
		$(document).ajaxStart(function()
		{
			// AJAX 요청 시작 시...
			$("#loading").show();
			$("#result").hide();
			
		}).ajaxComplete(function()
		{
			// AJAX 요청 종료(완료) 시...
			$("#loading").hide();
			$("#result").show();
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
	<h1>jQuery()의 ajax() 활용 실습</h1>
	<p>로딩 이미지 적용</p>
	<hr />
</div>

<div>
	이름 <input type="text" id="name" class="txt" /><br /><br />
	내용 <input type="text" id="content" class="txt" /><br /><br />
	
	<input type="button" value="등록하기" id="sendBtn" class="btn" />
</div>
<br /><br />
<!--  
display:none; 으로 해야되는 속성들은
다른거 다 작성하고 어떻게 나오는지 확인 후에 마지막에 display속성 적어주면 된다.
-->
<div id="loading" style="text-align: center; display: none;">
	<img alt="loading" src="images/loading_01.gif" style="align-items: center;">
</div>

<div id="result">
</div>

</body>
</html>