<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- 
	작성 순서
	AjaxTest03.jsp > web.xml(Test03send) > Test03send.java
	> webcontent에 『test03send.do』로 파일만듦(그냥 실행하기 편하려고)
	> Test03.java (ServletSample 복사해옴)
	> Test03Ok.jsp
	> web.xml(/test03.do)
	> AjaxTest03.jsp(callBack() 함수 정의)
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AjaxTest03.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
	#result {
		display: inline-block;
		width: 250px;
		color: #F33;
	}
</style>
<script type="text/javascript" src="<%=cp %>/js/ajax.js"></script>
<script type="text/javascript">

	function check()
	{
		// background에서 냅따 ID 만 들고 중복검사하러 뛰어갔다 와야함

		// 데이터 수집
		var id = document.getElementById("id").value;
		
		// URL 준비
		var url = "test03.do?id=" + id;
		
		// AJAX 객체 생성(→ XMLHttpRequest 객체 생성)
		ajax = createAjax();
		
		// 환경 설정(『open("메소드방식", "URL", 비동기/동기)』)
		ajax.open("GET", url, true);
		
		ajax.onreadystatechange = function()
		{
			// 원래 따로따로 if문 구성했던거 이렇게 한 줄로 해도 문제없다.
			if (ajax.readyState==4 && ajax.status==200)
			{
				// 업무 처리(→ 외부로 추출)
				callBack();
			}
		};
		//-- 『;』 안써도 상관없음
		
		ajax.send("");
	}
	
	// 아이디 중복 검사의 결과 (1 or 0)를 통보받아
	// 사용자에게 메세지 출력 → span → result
	function callBack()
	{
		// 외부로 추출된 업무 처리 내용 구성(responseText / responseXML)
		
		var data = ajax.responseText;
		
		data = parseInt(data);
		
		if (data==0)
			document.getElementById("result").innerText = "사용 가능한 아이디입니다.";
		else
			document.getElementById("result").innerText = "이미 사용중인 아이디입니다.";
	}

</script>
</head>
<body>

<!-- 
	아이디 중복검사할 때, 페이지 자체를 넘겨버리면,
	이름, 주소 값 까지 다 저장해둬야 한다.
	지금은 값 적으니까 그렇지만, 저장해둬야 할 게 많아지면 불편해진다.
	→ ajax 사용해서 해보자 
-->

<div>
	<h1>회원 가입</h1>
	<p>- Test03send.java</p>
	<p>- AjaxTest03.jsp</p>
	<p>- ajax.js</p>
	<p>- main.css</p>
	<p>- Test03.java</p>
	<p>- Test03Ok.jsp</p>
	<p>- web.xml</p>
	<p>※ url : test03send.do / test03.do</p>
	<p>※ 자료구조 활용</p>
</div>

<table class="table">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" id="id" class="control" />
			<input type="button" value="중복검사" class="control" onclick="check()"/>
			<!-- 여기에 결과값 뿌릴거임 -->
			<span id="result"></span>
		</td>
	</tr>
	
	<tr>
		<th>이름</th>
		<td>
			<input type="text" id="name" class="control" />
		</td>
	</tr>
	
	<tr>
		<th>주소</th>
		<td>
			<input type="text" id="addr" class="control" />
		</td>
	</tr>
</table>

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

</body>
</html>