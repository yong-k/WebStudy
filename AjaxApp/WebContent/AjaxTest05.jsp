<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!--
	[작성 순서]
	
	AjaxTest05.jsp
	> Test05send.java : 최초 요청 페이지에 대한 controller 
	> web.xml(/test05send.do)
	> test05send.do 파일 생성 : 실행시키기 편하려고
	
	이제 Test05.do 에서는 search 수신해서 그걸 background로 밀어줘야 한다.
	> Test05.java : ServletSample 복붙
	> web.xml(test05.do)
	> WordDTO.java
	> Test05.java 마저 작성
	> Test05Ok.jsp : web.xml에서 맨 윗줄 복붙
	> AjaxTest05.jsp : callBack() 함수 작성
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AjaxTest05.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<style type="text/css">
	#search {
		width: 500px;
	}
	#list {
		border: 1px solid gray;
		width: 500px;
		
		position: absolute;
		left: 70px;
		top: 134.5px;
		
		display: none;
	}
	#list .item {
		padding: 3px;
	}
	#list #footer {
		height: 14px;
		background-color: #DDD;
		text-align: right;
		padding: 5px;
		font-size: small;
	}
</style>
<script type="text/javascript" src="<%=cp %>/js/ajax.js"></script>
<script type="text/javascript">
	
	// 검색창에서 키보드를 누를 때마다...
	// 그 때 까지의 입력된 단어를 서버로 전송하고
	// 전송된 단어에 맞는 추천 검색어를 받아올 수 있도록 처리
	function search()
	{
		// 테스트
		//alert("확인");
		
		// 데이터 수집(입력된 값 얻어오기)
		var search = document.getElementById("search").value;
		
		// 테스트
		//alert(search);
		
		// 서버로 전송하기 전에 유효성 검사 -----------------------------------------------
		
		// ① 검색어가 존재할 경우에만 서버로 전송할 수 있도록 처리
		// 공백있다면, 그거 없애고, 없앴더니 내용 아무것도 없다면
		if (search.replace(" ", "") == "")
		{
			// 안보이게 하고, 함수 종료시킴
			document.getElementById("list").style.display = "none";
			return;
		}
		
		// ② 입력된 검색어가 완성형 한글일 경우에만 검색 키워드로 전송할 수 있도록 처리
		//    → 정규표현식 사용 → /^[가-힣]+$/
		//var regEx = /^[가-힣]+$/;
		var regEx = /^[가-힣]{1,}$/;
		
		// 입력된 내용이 완성형 한글이 아닐경우에는, 함수의 기능 종료할 수 있도록 처리
		// +) 패턴.test(str) : 패턴과 특정 문자열 사이의 일치에 대한 검색을 수행
		//             			 true  반환 → 정규식과 문자열 사이에 일치하는 항목 있으면  
		//    		   			 false 반환 → 일치하는 항목 없으면
		
		if (!regEx.test(search))
			return;
		
		// ----------------------------------------------- 서버로 전송하기 전에 유효성 검사
		
		
		// URL 구성
		var url = "test05.do?search=" + search;
		//-- search: textbox에 입력된 내용 값으로 전달해줌
		
		// XMLHttpRequest 객체(→ AJAX 객체) 생성
		ajax = createAjax();						//-- ajax.js
		
		ajax.open("GET", url, true);
		
		ajax.onreadystatechange = function()
		{
			if (ajax.readyState==4 && ajax.status==200)
			{
				// 업무 내용 수행(호출)
				callBack();
			}
		}
		
		ajax.send("");
	}
	
	// 업무 내용
	//-- XML 목록으로 받아온 검색어들을
	//   적당한 리스트로 생성해서 화면에 출력할 수 있도록 처리
	function callBack()
	{
		// XML 문서 객체
		var doc = ajax.responseXML;
		
		// XML 최상위 엘리먼트 수신 → 지금은 <list> 인 상황
		var root = doc.documentElement;		//-- list
		
		// 모든 <item> 엘리먼트 반환받기
		var itemList = root.getElementsByTagName("item");
		
		// 추천 검색어 노출지점 초기화
		document.getElementById("items").innerHTML = "";
		
		// 수신한 추천 검색어 삽입하기
		for (var i = 0; i < itemList.length; i++)
		{
			var word = itemList[i].firstChild.nodeValue;
			
			// items(노출지점) 에 추가
			document.getElementById("items").innerHTML
				+= "<div class='item'>" + word + "</div>";
		}
		
		// 최종적으로 목록을 화면에 보일 수 있도록 랜더링
		document.getElementById("list").style.display = "block";
	}
	
</script>
</head>
<body>
<!-- 
	DB상에 있는 내용 가져와서 추천 검색어에 띄어주려고 한다.
	'가' 입력   → 가방, 가지 가위....
	'가방' 입력 → 가방끈, 가방 만들기...
	하지만 이 페이지자체에 전체적으로 갱신이 일어나면 안된다.
-->
<div>
	<h1>AJAX 실습 - 추천 검색어</h1>
	<hr />
</div>

<div>
	<!-- 검색어 창에 텍스트 입력할 때마다 액션처리되면서 추천 검색어 나타나야 한다 -->
	검색어
	<input type="text" id="search" class="control" 
	placeholder="검색어를 입력하세요" onkeyup="search()"/>
</div>

<div id="list">
	<div id="items">
		<div class="item">가다랑어</div>
		<div class="item">가마</div>
		<div class="item">가사</div>
		<div class="item">가위</div>
		<div class="item">가지</div>
		<div class="item">가치</div>
		<div class="item">가풍</div>
		<div class="item">가훈</div>
	</div>
	<div id="footer">
		추천 검색어
	</div>
</div>



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