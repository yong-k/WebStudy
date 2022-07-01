<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- 
	작성순서
	AjaxTest04.jsp : callBack() 내용부분 제외 작성
	> Test04send.java(controller) : ServletSample 복붙
	> web.xml(/test04send.do)
	> test04send.do : 그냥 실행 편하기 위한 file 생성
	> Test04.java(controller) : 주소(addr) 받을 controller 만듦
							    ServletSample 복붙
	> ZipCodeDTO.java
	> Test04.java 에서 다시 작업
	> Test04Ok.jsp : xml 형식으로 작성
					 web.xml 의 제일 위에 있는 줄 복사해서 붙여넣음
	> web.xml(/test04.do)
	> AjaxTest04.jsp : callBack() 함수 작성
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AjaxTest04.jsp</title>
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

	// AjaxTest03.jsp 에서 했던 중복검사 js 함수 가져옴
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
	
	
	function search()
	{
		// 테스트
		//alert("함수 호출 확인");
		
		// 데이터 수집
		var addr = document.getElementById("addr").value;
		
		// URL 준비
		var url = "test04.do?addr=" + addr;
		
		// XMLHttpRequest 객체(→ AJAX 객체) 생성
		ajax = createAjax();						//-- ajax.js
		
		// 설정
		ajax.open("GET", url, true);
		ajax.onreadystatechange = function()
		{
			if (ajax.readyState==4 && ajax.status==200)
			{
				// 수행 업무
				callBack2();
			}
		}
		
		ajax.send("");
	}
	
	// 추출된 수행 업무
	// → 우편번호 검색 결과를 통보받아서 
	//    사용자에게 안내해 줄 수 있도록 처리
	function callBack2()
	{
		// ★★ 주의깊게 보기!! ★★
		// 앞에 진행했던 실습(text 처리)과 달리 XML 처리 하려고 한다.
		
		// XML 문서 전체의 참조 객체 (흔히 XML 문서 객체라고 한다.)
		var doc = ajax.responseXML;
		
		
		// 어떤 XML이든 well-formed XML 이 되려면, (구성대로 잘 작성된)
		// xml을 구성한 첫번째 엘리먼트 안에 모든게 다 들어있어야 한다.
		// web.xml 에서는 [web-app] 엘리먼트 안에 모든게 다 들어있다.
		/*
		<?xml version="1.0" ~~>
		<member>
		</member>
		<address>
		</address>
		--==>> well-formed (Ⅹ)
		
		<?xml version="1.0" ~~>
		<member>
		</member>
		--==>> well-formed (○)
		*/
		
		// XML 문서의 최상위 엘리먼트(루트 엘리먼트)
		//-- 현재는 『<list>』 엘리먼트
		var root = doc.documentElement;
		
		// list 는 하나지만 item 은 여러개
		// 모든 『<item>』 엘리먼트 반환받기
		var itemList = root.getElementsByTagName("item");
		//-- 이거 selectbox 에 넣어주려고 한다.
		
		// select box 초기화
		document.getElementById("addrResult").innerHTML = "";
		
		// 검색 결과 확인
		if (itemList.length==0)		//-- 찾지 못함
		{
			document.getElementById("addrResult").innerHTML 
			= "<option>주소를 입력하세요.</option>";
		}
		else
		{
			// check~!!! 
			// 이거 안하면, 맨위에 있는게 내 주소일 경우 바뀌지 않는다.
			document.getElementById("addrResult").innerHTML 
			= "<option value='0'>주소를 선택하세요.</option>";
		}
		
		// 검색 결과가 존재할 경우... 반복문을 순환하며 각 데이터 가져오기
		for (var i=0; i<itemList.length; i++)	// 수신한 아이템의 개수만큼 반복 순환
		{
			var zipcode = itemList[i].getElementsByTagName("zipcode")[0];
			var address = itemList[i].getElementsByTagName("address")[0];
			
			// ※ 태그가 가지는 텍스트는
			//    태그의 첫 번째 자식이고...
			//    텍스트 노드의 값은
			//    nodeValue 로 가져온다.
			
			var zipcodeText = zipcode.firstChild.nodeValue;
			var addressText = address.firstChild.nodeValue;
			
			// select box 에 아이템 추가
			document.getElementById("addrResult").innerHTML
					+= "<option value='" + zipcodeText + "/" + addressText
					+ "'>[" + zipcodeText + "] " + addressText + "</option>";
		}
	}
	
	function selectZipCode(sel)
	{
		// 테스트
		//alert("선택 확인");
		
		//alert(sel.value);
		
		if (sel.value != "0")
		{
			//-- 현재 value 값 아래와 같은 형태이다.
			//   06253/서울특별시 강남구 강남대로 310 (역삼동, 유니온센터오피스텔)
			//-- split() 하면 배열로 값 반환된다.
			document.getElementById("addr1").value = sel.value.split("/")[0];	
			document.getElementById("addr2").value = sel.value.split("/")[1];	
			document.getElementById("addr3").focus();
			
		}
	}
	
</script>
</head>
<body>

<!-- 우편번호 ajax 처리해보자 -->

<div>
	<h1>회원 가입</h1>
	<p>우편번호 검색</p>
	<hr />
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
			<input type="text" id="addr" class="control" placeholder="동 입력"/>
			<input type="button" value="검색하기" class="control" onclick="search()"/>
			<br />
			<!-- 
				초기값이 '주소를 입력하세요'이기 때문에
				주소 선택하려면 무조건 change 이벤트 일어날 수 밖에 없다.
			 -->
			<select id="addrResult" class="control" onchange="selectZipCode(this)">
				<option>주소를 입력하세요.</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<th>주소 검색 결과</th>
		<td>
			<input type="text" readonly="readonly" style="width:200px;" id="addr1" class="control" />
			<br />
			<input type="text" readonly="readonly" style="width:400px;" id="addr2" class="control" />
			<br />
			<input type="text" style="width:400px;" id="addr3" class="control" placeholder="상세주소를 입력하세요."/>
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